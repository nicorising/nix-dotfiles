{
  programs.nixvim.plugins.vimtex = {
    enable = true;
    texlivePackage = null;

    settings = {
      view_method = "zathura";
      compiler_method = "latexmk";
    };
  };
}
