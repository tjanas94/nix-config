{...}: {
  imports = [./common];

  home.file.".ssh" = {
    source = ../../config/ssh;
    recursive = true;
  };
}
