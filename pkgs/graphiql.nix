{ stdenv
, fetchFromGitHub
, fetchYarnDeps
, yarnConfigHook
, yarnBuildHook
, npmHooks
, nodejs
}:
let
  buildGraphiqlMonorepoPackage = { name, buildInputs ? [ ], postInstall ? "" }: stdenv.mkDerivation rec {
    inherit name buildInputs postInstall;

    src = fetchFromGitHub {
      owner = "tjanas94";
      repo = "graphiql";
      rev = "8b7f51451729d36d2687f5c0849c709f8e76cb1d";
      hash = "sha256-8xNcBRWtsoIi9dl+ye6TmONgCBmGI1wZkGlHCXCL0xw=";
    };

    yarnOfflineCache = fetchYarnDeps {
      yarnLock = "${src}/yarn.lock";
      hash = "sha256-n5bWhGAFuCRDPLp+zQDWkIE2gTVgAKkAANU+EI/YoZM=";
    };

    dontNpmPrune = true;
    npmWorkspace = "packages/${name}";

    nativeBuildInputs = [
      yarnConfigHook
      yarnBuildHook
      npmHooks.npmInstallHook
      nodejs
    ];
  };
in
rec {
  graphql-language-service = buildGraphiqlMonorepoPackage {
    name = "graphql-language-service";
  };
  graphql-language-service-server = buildGraphiqlMonorepoPackage {
    name = "graphql-language-service-server";
    buildInputs = [ graphql-language-service ];
    postInstall = ''
      ln -sf ${graphql-language-service}/lib/node_modules/graphiql-monorepo $out/lib/node_modules/graphiql-monorepo/node_modules/graphql-language-service
    '';
  };
  graphql-language-service-cli = buildGraphiqlMonorepoPackage {
    name = "graphql-language-service-cli";
    buildInputs = [ graphql-language-service graphql-language-service-server ];
    postInstall = ''
      ln -sf ${graphql-language-service}/lib/node_modules/graphiql-monorepo $out/lib/node_modules/graphiql-monorepo/node_modules/graphql-language-service
      ln -sf ${graphql-language-service-server}/lib/node_modules/graphiql-monorepo $out/lib/node_modules/graphiql-monorepo/node_modules/graphql-language-service-server
    '';
  };
}

