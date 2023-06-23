{pkgs, inputs}:

pkgs.mkShell {
  shellHook = ''
     # For some reason, Exsync doesn't find mac_listener which exist.
     # So I'm exporting it to our path
     export PATH=./dep/file_system/priv/:$PATH
  '';

  buildInputs = with pkgs; [
    # Basic buildtools
    gnumake
    coreutils
    findutils
    bash

    # Extra buildtools
    scc
    entr # file watcher

    # Lang
    lua
    #luajitPackages.luacheck
    luajitPackages.luarocks
    luajitPackages.busted
    nodePackages.lua-fmt
  ];
}
