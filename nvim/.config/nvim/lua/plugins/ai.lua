return {
  "gera2ld/ai.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  event = "VeryLazy",
  opts = {
    ---- AI's answer is displayed in a popup buffer
    ---- Default behaviour is not to give it the focus because it is seen as a kind of tooltip
    ---- But if you prefer it to get the focus, set to true.
    result_popup_gets_focus = true,
    ---- Override default prompts here, see below for more details
    prompts = {
      translateCode = {
        command = "GeminiTranslateCode",
        header_tpl = "## translate Code \n\n{{input}}",
        prompt_tpl = "Translate all comments only in the following code to English. Do not modify the code itself. Preserving the exact same comment syntax. Return only the updated code inside a single fenced code block with no explanation.\n```\n{{input}}\n```",
      },
      translateText = {
        command = "GeminiTranslateText",
        header_tpl = "# Translate text \n\n{{input}}",
        prompt_tpl = "Translate only the words in the following code block to English. Do NOT change anything else. Keep ALL original formatting, including symbols, indentation, emojis, and especially symbols at the beginning of lines like '-', '*', '#', etc. Return ONLY the translated version, inside a code block with the same formatting:\n```\n{{input}}\n```",
      },
      addTypeAnnotation = {
        command = "GeminiTypeAnnotation",
        header_tpl = "# Add Type Annotation \n\n{{input}}",
        prompt_tpl = "Add type annotations to the following code. Return only the updated code wrapped in md block quote\n```\n{{input}}\n```",
      },
      addJsDoc = {
        command = "GeminiJsDoc",
        header_tpl = "# Add Js Doc \n\n{{input}}",
        prompt_tpl = "Add proper JSDoc comments to the following code. Only output the updated code without any explanation. Wrap the output in md codeblock:\n```\n{{input}}\n```",
      },
      addTsDoc = {
        command = "GeminiTsDoc",
        header_tpl = "# Add Ts Doc \n\n{{input}}",
        prompt_tpl = "Add proper TSDoc comments to the following code. Only output the updated code without any explanation. Wrap the output in md codeblock:\n```\n{{input}}\n```",
      },
      translateAndImprove = {
        command = "GeminiTranslateAndImprove",
        header_tpl = "# Improve and Translate Technical Text \n\n{{input}}",
        prompt_tpl = [[
Act as an expert in technical writing and translation for software development. The input text may be in Spanish or English. Your task is to:

1. Improve clarity, grammar, and style while keeping a professional technical tone suitable for documentation, code comments, or technical communication.
2. Translate the text into English if it is in Spanish, or just improve it if it is already in English.
3. Keep all function names, variable names, and programming terms unchanged.

Return ONLY the resulting English text inside a code block, with no explanations or extra text:

```
{{input}}
```
  ]],
      },
    },
    ---- Default models for each prompt, can be overridden in the prompt definition
    models = {
      {
        provider = "gemini",
        model = "gemini-2.5-flash",
        result_tpl = "## Gemini\n\n{{output}}",
      },
    },
  },
  config = function(_, opts)
    opts.gemini = {
      api_key = os.getenv("NVIM_AI_GEMININI_KEY"),
    }

    require("ai").setup(opts)
  end,
}
