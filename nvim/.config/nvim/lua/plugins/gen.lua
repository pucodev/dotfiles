return {
  "David-Kunz/gen.nvim",
  lazy = false,
  opts = {
    model = "qwen2.5-coder:0.5b", -- The default model to use.
    quit_map = "q", -- set keymap to close the response window
    retry_map = "<c-r>", -- set keymap to re-send the current prompt
    accept_map = "<c-s>", -- set keymap to replace the previous selection with the last result
    host = "localhost", -- The host running the Ollama service.
    port = "11434", -- The port on which the Ollama service is listening.
    display_mode = "float", -- The display mode. Can be "float" or "split" or "horizontal-split" or "vertical-split".
    show_prompt = true, -- Shows the prompt submitted to Ollama. Can be true (3 lines) or "full".
    show_model = true, -- Displays which model you are using at the beginning of your chat session.
    no_auto_close = false, -- Never closes the window automatically.
    file = false, -- Write the payload to a temporary file to keep the command short.
    hidden = false, -- Hide the generation window (if true, will implicitly set `prompt.replace = true`), requires Neovim >= 0.10
    init = function(options)
      pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
    end,
    -- Function to initialize Ollama
    command = function(options)
      local body = { model = options.model, stream = true }
      return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
    end,
    -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
    -- This can also be a command string.
    -- The executed command must return a JSON object with { response, context }
    -- (context property is optional).
    -- list_models = '<omitted lua function>', -- Retrieves a list of model names
    result_filetype = "markdown", -- Configure filetype of the result buffer
    debug = true, -- Prints errors and the command which is run.
  },
  keys = {
    { "<leader>mm", ":Gen<CR>", desc = "Gen: Run custom prompt", mode = { "n", "v" } },
    { "<leader>ma", ":Gen ⭐_Autocomplete<CR>", desc = "Gen: Autocomplete", mode = { "n", "v" } },
    { "<leader>md", ":Gen ⭐_Generate_JSDoc<CR>", desc = "Gen: Generate JSDoc", mode = { "n", "v" } },
    { "<leader>ml", ":Gen ⭐_Generate_LuaDoc<CR>", desc = "Gen: Generate LuaDoc", mode = { "n", "v" } },
    { "<leader>mt", ":Gen ⭐_Translate_Text<CR>", desc = "Gen: Translate text", mode = { "n", "v" } },
    {
      "<leader>mc",
      ":Gen ⭐_Translate_Code_Comments<CR>",
      desc = "Gen: Translate code comments",
      mode = { "n", "v" },
    },
    { "<leader>me", ":Gen Enhance_Code<CR>", desc = "Gen: Enhance code", mode = { "n", "v" } },
  },
  config = function(_, opts)
    opts.host = os.getenv("NVIM_GEN_HOST") or opts.host
    opts.port = os.getenv("NVIM_GEN_PORT") or opts.port
    require("gen").setup(opts)

    --- Extracts a code block from a Markdown-style string.
    --
    -- This function attempts to extract the content inside a fenced code block (```).
    -- If no fenced block is found, it returns the full result string.
    --
    -- @param output A table with a `result_string` field containing the output text.
    -- @return The extracted code block if found, otherwise the full result string.
    local function parse_output(output)
      local result = output.result_string
      local block = result:match("```.-\n(.-)```")
      return block or result
    end

    require("gen").prompts["⭐_Autocomplete"] = {
      prompt = "You are a code completion engine. Complete the following code using the context provided. Only output the completed code between the <fim_prefix> and <fim_suffix> markers, without any extra explanation. Wrap the result in ```$filetype\n...\n```:\n```$filetype\n<fim_prefix>$text<fim_suffix>\n```",
      replace = true,
      extract = parse_output,
    }
    require("gen").prompts["⭐_Write_Commit_Message"] = {
      prompt = "Generate a conventional commit message for the following diff:\n```diff\n$text\n```",
    }
    require("gen").prompts["⭐_Add_Types"] = {
      prompt = "Add type annotations to the following code. Return only the updated code wrapped in ```$filetype\n...\n```:\n```$filetype\n$text\n```",
      replace = true,
      extract = parse_output,
    }
    require("gen").prompts["⭐_Generate_JSDoc"] = {
      prompt = "Add proper JSDoc comments to the following code. Only output the updated code without any explanation. Wrap the output in ```$filetype\n...\n```:\n```$filetype\n$text\n```",
      replace = true,
      extract = parse_output,
    }
    require("gen").prompts["⭐_Translate_Code_Comments"] = {
      prompt = "Translate all comments only in the following code to English. Do not modify the code itself. Preserving the exact same comment syntax used by the language $filetype . Return only the updated code inside a single fenced code block with no explanation.\n```$filetype\n$text\n```",
      replace = true,
      extract = parse_output,
    }
    require("gen").prompts["⭐_Translate_Text"] = {
      prompt = "/no_think Translate only the words in the following code block to English. Do NOT change anything else. Keep ALL original formatting, including symbols, indentation, emojis, and especially symbols at the beginning of lines like '-', '*', '#', etc. Return ONLY the translated version, inside a code block with the same formatting:\n```plaintext\n$text\n```",
      replace = true,
      extract = parse_output,
      model = "qwen3:0.6b",
    }
    require("gen").prompts["⭐_Generate_LuaDoc"] = {
      prompt = [[
You are an expert at documenting Lua code using LDoc format.
Here are some documentation style examples for reference (do not include or modify them in the output):
--- Adds two numbers.
-- @param a The first number.
-- @param b The second number.
-- @return The sum of a and b.
function add(a, b)
  return a + b
end
--- Greets the user.
-- @param name The user's name. Defaults to "World".
-- @return A personalized greeting.
function greet(name)
  name = name or "World"
  return "Hello, " .. name
end
--- Math utilities module.
-- Contains common math functions like add and subtract.
-- @module math_utils
--- The maximum number of allowed attempts.
-- @field max_attempts
-- @type number
max_attempts = 5
--- Returns the minimum and maximum from a list.
-- @param t A table of numbers.
-- @return The minimum value.
-- @return The maximum value.
function min_max(t)
  table.sort(t)
  return t[1], t[#t]
end
Now, add proper LDoc-style documentation **only to the code below**.
Only return the final code with added documentation — no explanations, no examples, and do not repeat or comment on the examples above.
Wrap the entire response in a Lua code block using triple backticks (```) like this:

```lua
-- your documented code here
````

Code to document:
````lua
$text
````
]],
      extract = parse_output,
      model = "qwen2.5-coder:1.5b",
    }
  end,
}
