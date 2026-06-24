{ flakeNixpkgs, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    enableMan = false; # Fix LSP package bug

    globals.mapleader = " ";
    diagnostic.settings.float.border = "rounded";
    extraConfigLua = builtins.readFile ./config.lua;

    nixpkgs = {
      source = flakeNixpkgs;
      config.allowUnfree = true;
    };

    opts = {
      number = true;
      relativenumber = true;
      clipboard = "unnamedplus";
      updatetime = 300;
      autoread = true;
    };

    highlightOverride = {
      Todo = {
        fg = "#fabd2f";
        bg = "NONE";
        bold = true;
      };
    };

    plugins = {
      # Nerd font icons
      web-devicons.enable = true;

      # Language server protocol
      lsp = {
        enable = true;

        servers = {
          clojure_lsp.enable = true;
          eslint.enable = true;
          lua_ls.enable = true;
          nil_ls = {
            enable = true;
            settings.nix.flake.autoArchive = true; # Auto-fetch flake inputs
          };
          pyright.enable = true;
          ruff.enable = true;
          tailwindcss.enable = true;
          texlab.enable = true;
          ts_ls.enable = true;
        };

        keymaps = {
          lspBuf = {
            gd = "definition";
          };
        };
      };

      # Syntax highlighting and code parsing
      treesitter = {
        enable = true;
        grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;

        highlight.enable = true;
        indent.enable = true;
      };

      # Syntax tree navigation/selection
      flash = {
        enable = true;
        settings.modes.treesitter.enable = true;
      };

      # Formatter
      conform-nvim = {
        enable = true;

        settings = {
          format_on_save.lsp_fallback = true;

          formatters_by_ft = {
            c = [ "clang_format" ];
            cpp = [ "clang_format" ];
            javascript = [
              "eslint_d"
              "prettier"
            ];
            javascriptreact = [
              "eslint_d"
              "prettier"
            ];
            nix = [ "nixfmt" ];
            python = [
              "ruff_fix"
              "ruff_format"
            ];
            tex = [ "tex-fmt" ];
            typescript = [
              "eslint_d"
              "prettier"
            ];
            typescriptreact = [
              "eslint_d"
              "prettier"
            ];
            "_" = [ "prettier" ];
          };
        };
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "buffer"; }
          ];
          mapping = {
            "<cr>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping.select_next_item()";
            "<S-Tab>" = "cmp.mapping.select_prev_item()";
          };
        };
      };

      telescope = {
        enable = true;
        extensions.fzf-native.enable = true;
      };

      # File explorer panel
      neo-tree = {
        enable = true;

        settings = {
          log_level = "warn";
          close_if_last_window = true;

          filesystem = {
            filtered_items = {
              visible = true;
              hide_dotfiles = false;
              hide_gitignored = false;
            };

            follow_current_file.enabled = true;
          };
        };
      };

      # Easy commenting/uncommenting
      comment.enable = true;

      # Git QoL in Neovim
      gitsigns = {
        enable = true;
        settings.current_line_blame = true;
      };

      # Better navigation between Neovim and tmux
      tmux-navigator.enable = true;

      # Image rendering
      image = {
        enable = true;
        settings.backend = "kitty";
      };

      # Lua for Neovim
      lazydev.enable = true;

      # Python virtual environment selector
      venv-selector.enable = true;
    };

    colorschemes.gruvbox = {
      enable = true;

      settings = {
        contrast_dark = "dark";
        transparent_mode = true;
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader><cr>";
        action = "i<cr><Esc>";
        options.desc = "Insert line break";
      }
      {
        mode = "n";
        key = "<leader>ca";
        action = "<cmd>lua vim.lsp.buf.code_action()<cr>";
        options.desc = "Code actions";
      }

      # Neo-tree
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Neotree toggle<cr>";
        options.desc = "Toggle explorer";
      }

      # Telescope
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<cr>";
        options.desc = "Find files";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<cr>";
        options.desc = "Live grep";
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<cr>";
        options.desc = "Open buffers";
      }
      {
        mode = "n";
        key = "<leader>fr";
        action = "<cmd>Telescope oldfiles<cr>";
        options.desc = "Recent files";
      }
      {
        mode = "n";
        key = "<leader>fs";
        action = "<cmd>Telescope lsp_document_symbols<cr>";
        options.desc = "LSP symbols";
      }
      {
        mode = "n";
        key = "gi";
        action = "<cmd>Telescope lsp_implementations<cr>";
        options.desc = "Implementations";
      }
      {
        mode = "n";
        key = "gr";
        action = "<cmd>Telescope lsp_references<cr>";
        options.desc = "References";
      }

      # Flash
      {
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "s";
        action = "<cmd>lua require('flash').jump()<cr>";
        options.desc = "Flash";
      }
      {
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "S";
        action = "<cmd>lua require('flash').treesitter()<cr>";
        options.desc = "Flash Treesitter";
      }
      {
        mode = [
          "o"
          "x"
        ];
        key = "R";
        action = "<cmd>lua require('flash').treesitter_search()<cr>";
        options.desc = "Treesitter search";
      }

      # Git
      {
        mode = "n";
        key = "<leader>gp";
        action = "<cmd>Gitsigns preview_hunk<cr>";
        options.desc = "Preview Git hunk";
      }
      {
        mode = "n";
        key = "<leader>gr";
        action = "<cmd>Gitsigns reset_hunk<cr>";
        options.desc = "Reset Git hunk";
      }

      # Virtual environment selector
      {
        mode = "n";
        key = "<leader>vs";
        action = "<cmd>VenvSelect<cr>";
        options.desc = "Select Python virtual environment";
      }
    ];
  };

  home.file.".editorconfig".source = ./.editorconfig;

  # Fixes for treesitter syntax highlighting
  xdg.configFile = {
    "nvim/queries/ecma/highlights.scm".text = ''
      [
        "break"
        "case"
        "catch"
        "continue"
        "default"
        "do"
        "else"
        "finally"
        "for"
        "if"
        "return"
        "switch"
        "throw"
        "try"
        "while"
        "const"
        "let"
        "var"
        "function"
        "class"
        "new"
        "async"
        "await"
        "import"
        "export"
        "from"
        "as"
      ] @keyword

      (string) @string
      (number) @number
      (true) @boolean
      (false) @boolean
      (null) @constant.builtin
      (comment) @comment
    '';

    "nvim/queries/jsx/highlights.scm".text = ''
      (jsx_element
        open_tag: (jsx_opening_element
          name: (identifier) @tag))

      (jsx_element
        close_tag: (jsx_closing_element
          name: (identifier) @tag))

      (jsx_self_closing_element
        name: (identifier) @tag)

      (jsx_attribute
        (property_identifier) @tag.attribute)
    '';
  };
}
