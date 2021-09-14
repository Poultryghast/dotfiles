{
    programs.firefox = {
        enable = true;
        profiles.default.isDefault = true;
    };
    home.file.".mozilla/firefox/default/user.js".source = ../dotfiles/firefox/user.js;
}