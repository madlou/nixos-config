{ stdenv, fetchurl, makeWrapper, appimage-run }:

stdenv.mkDerivation {
  pname = "turtle-wow";
  version = "2.3.0-beta6";

  src = fetchurl {
    url = "https://launcher.turtlecraft.gg/api/launcher/TurtleWoW.AppImage?download=bunny";
    hash = "sha256-utkZrPU/AWzXqjpmYOK++GzGyhd8Mwfa7/b2zen991E=";
  };

  unpackPhase = ''
    cp $src ./TurtleWoW.AppImage
    chmod +x ./TurtleWoW.AppImage

    # Extracting like this, because appimageTools.extract (aka. unsquashfs) can't extract this weirdly structured AppImage.
    ./TurtleWoW.AppImage --appimage-extract

    mkdir $out
    mv ./AppDir $out/.
  '';

  nativeBuildInputs = [
    makeWrapper
  ];

  installPhase = ''
    mkdir -p $out/share/applications
    cp $out/AppDir/share/applications/TurtleWoW.desktop $out/share/applications/.

    makeWrapper ${appimage-run}/bin/appimage-run \
      $out/bin/turtle-wow \
      --add-flags "-w $out/AppDir"
  '';

  meta = {
    homepage = "https://turtlecraft.gg";
    description = "Turtle WoW Launcher";
    mainProgram = "turtle-wow";
    platforms = [ "x86_64-linux" ];
  };
}
