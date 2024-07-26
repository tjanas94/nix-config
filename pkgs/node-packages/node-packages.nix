# This file has been generated by node2nix 1.11.1. Do not edit!

{ nodeEnv, fetchurl, fetchgit, nix-gitignore, stdenv, lib, globalBuildInputs ? [ ] }:

let
  sources = {
    "@astrojs/compiler-2.9.2" = {
      name = "_at_astrojs_slash_compiler";
      packageName = "@astrojs/compiler";
      version = "2.9.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/@astrojs/compiler/-/compiler-2.9.2.tgz";
        sha512 = "Vpu0Ffsj8SoV+N0DFHlxxOMKHwSC9059Xy/OlG1t6uFYSoJXxkBC2WyF6igO7x10V+8uJrhOxaXr3nA90kJXow==";
      };
    };
    "@jridgewell/sourcemap-codec-1.5.0" = {
      name = "_at_jridgewell_slash_sourcemap-codec";
      packageName = "@jridgewell/sourcemap-codec";
      version = "1.5.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/@jridgewell/sourcemap-codec/-/sourcemap-codec-1.5.0.tgz";
        sha512 = "gv3ZRaISU3fjPAgNsriBRqGWQL6quFx04YMPW/zD8XMLsU32mhCCbfbO6KZFLjvYpCZ8zyDEgqsgf+PwPaM7GQ==";
      };
    };
    "@nodelib/fs.scandir-2.1.5" = {
      name = "_at_nodelib_slash_fs.scandir";
      packageName = "@nodelib/fs.scandir";
      version = "2.1.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/@nodelib/fs.scandir/-/fs.scandir-2.1.5.tgz";
        sha512 = "vq24Bq3ym5HEQm2NKCr3yXDwjc7vTsEThRDnkp2DK9p1uqLR+DHurm/NOTo0KG7HYHU7eppKZj3MyqYuMBf62g==";
      };
    };
    "@nodelib/fs.stat-2.0.5" = {
      name = "_at_nodelib_slash_fs.stat";
      packageName = "@nodelib/fs.stat";
      version = "2.0.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/@nodelib/fs.stat/-/fs.stat-2.0.5.tgz";
        sha512 = "RkhPPp2zrqDAQA/2jNhnztcPAlv64XdhIp7a7454A5ovI7Bukxgt7MX7udwAu3zg1DcpPU0rz3VV1SeaqvY4+A==";
      };
    };
    "@nodelib/fs.walk-1.2.8" = {
      name = "_at_nodelib_slash_fs.walk";
      packageName = "@nodelib/fs.walk";
      version = "1.2.8";
      src = fetchurl {
        url = "https://registry.npmjs.org/@nodelib/fs.walk/-/fs.walk-1.2.8.tgz";
        sha512 = "oGB+UxlgWcgQkgwo8GcEGwemoTFt3FIO9ababBmaGwXIoBKZ+GTy0pP185beGg7Llih/NSHSV2XAs1lnznocSg==";
      };
    };
    "@one-ini/wasm-0.1.1" = {
      name = "_at_one-ini_slash_wasm";
      packageName = "@one-ini/wasm";
      version = "0.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/@one-ini/wasm/-/wasm-0.1.1.tgz";
        sha512 = "XuySG1E38YScSJoMlqovLru4KTUNSjgVTIjyh7qMX6aNN5HY5Ct5LhRJdxO79JtTzKfzV/bnWpz+zquYrISsvw==";
      };
    };
    "@volar/language-core-2.4.0-alpha.18" = {
      name = "_at_volar_slash_language-core";
      packageName = "@volar/language-core";
      version = "2.4.0-alpha.18";
      src = fetchurl {
        url = "https://registry.npmjs.org/@volar/language-core/-/language-core-2.4.0-alpha.18.tgz";
        sha512 = "JAYeJvYQQROmVRtSBIczaPjP3DX4QW1fOqW1Ebs0d3Y3EwSNRglz03dSv0Dm61dzd0Yx3WgTW3hndDnTQqgmyg==";
      };
    };
    "@volar/source-map-2.4.0-alpha.18" = {
      name = "_at_volar_slash_source-map";
      packageName = "@volar/source-map";
      version = "2.4.0-alpha.18";
      src = fetchurl {
        url = "https://registry.npmjs.org/@volar/source-map/-/source-map-2.4.0-alpha.18.tgz";
        sha512 = "MTeCV9MUwwsH0sNFiZwKtFrrVZUK6p8ioZs3xFzHc2cvDXHWlYN3bChdQtwKX+FY2HG6H3CfAu1pKijolzIQ8g==";
      };
    };
    "@volar/typescript-2.4.0-alpha.18" = {
      name = "_at_volar_slash_typescript";
      packageName = "@volar/typescript";
      version = "2.4.0-alpha.18";
      src = fetchurl {
        url = "https://registry.npmjs.org/@volar/typescript/-/typescript-2.4.0-alpha.18.tgz";
        sha512 = "sXh5Y8sqGUkgxpMWUGvRXggxYHAVxg0Pa1C42lQZuPDrW6vHJPR0VCK8Sr7WJsAW530HuNQT/ZIskmXtxjybMQ==";
      };
    };
    "balanced-match-1.0.2" = {
      name = "balanced-match";
      packageName = "balanced-match";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/balanced-match/-/balanced-match-1.0.2.tgz";
        sha512 = "3oSeUO0TMV67hN1AmbXsK4yaqU7tjiHlbxRDZOpH0KW9+CeX4bRAaX0Anxt0tx2MrpRpWwQaPwIlISEJhYU5Pw==";
      };
    };
    "brace-expansion-2.0.1" = {
      name = "brace-expansion";
      packageName = "brace-expansion";
      version = "2.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/brace-expansion/-/brace-expansion-2.0.1.tgz";
        sha512 = "XnAIvQ8eM+kC6aULx6wuQiwVsnzsi9d3WxzV3FpWTGA19F621kwdbsAcFKXgKUHZWsy+mY6iL1sHTxWEFCytDA==";
      };
    };
    "braces-3.0.3" = {
      name = "braces";
      packageName = "braces";
      version = "3.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/braces/-/braces-3.0.3.tgz";
        sha512 = "yQbXgO/OSZVD2IsiLlro+7Hf6Q18EJrKSEsdoMzKePKXct3gvD8oLcOQdIzGupr5Fj+EDe8gO/lxc1BzfMpxvA==";
      };
    };
    "commander-11.1.0" = {
      name = "commander";
      packageName = "commander";
      version = "11.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/commander/-/commander-11.1.0.tgz";
        sha512 = "yPVavfyCcRhmorC7rWlkHn15b4wDVgVmBA7kV4QVBsF7kv/9TKJAbAXVTxvTnwP8HHKjRCJDClKbciiYS7p0DQ==";
      };
    };
    "domino-2.1.6" = {
      name = "domino";
      packageName = "domino";
      version = "2.1.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/domino/-/domino-2.1.6.tgz";
        sha512 = "3VdM/SXBZX2omc9JF9nOPCtDaYQ67BGp5CoLpIQlO2KCAPETs8TcDHacF26jXadGbvUteZzRTeos2fhID5+ucQ==";
      };
    };
    "editorconfig-2.0.0" = {
      name = "editorconfig";
      packageName = "editorconfig";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/editorconfig/-/editorconfig-2.0.0.tgz";
        sha512 = "s1NQ63WQ7RNXH6Efb2cwuyRlfpbtdZubvfNe4vCuoyGPewNPY7vah8JUSOFBiJ+jr99Qh8t0xKv0oITc1dclgw==";
      };
    };
    "encoding-0.1.13" = {
      name = "encoding";
      packageName = "encoding";
      version = "0.1.13";
      src = fetchurl {
        url = "https://registry.npmjs.org/encoding/-/encoding-0.1.13.tgz";
        sha512 = "ETBauow1T35Y/WZMkio9jiM0Z5xjHHmJ4XmjZOq1l/dXz3lr2sRn87nJy20RupqSh1F2m3HHPSp8ShIPQJrJ3A==";
      };
    };
    "fast-glob-3.3.2" = {
      name = "fast-glob";
      packageName = "fast-glob";
      version = "3.3.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/fast-glob/-/fast-glob-3.3.2.tgz";
        sha512 = "oX2ruAFQwf/Orj8m737Y5adxDQO0LAB7/S5MnxCdTNDd4p6BsyIVsv9JQsATbTSq8KHRpLwIHbVlUNatxd+1Ow==";
      };
    };
    "fastq-1.17.1" = {
      name = "fastq";
      packageName = "fastq";
      version = "1.17.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/fastq/-/fastq-1.17.1.tgz";
        sha512 = "sRVD3lWVIXWg6By68ZN7vho9a1pQcN/WBFaAAsDDFzlJjvoGx0P8z7V1t72grFJfJhu3YPZBuu25f7Kaw2jN1w==";
      };
    };
    "fill-range-7.1.1" = {
      name = "fill-range";
      packageName = "fill-range";
      version = "7.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/fill-range/-/fill-range-7.1.1.tgz";
        sha512 = "YsGpe3WHLK8ZYi4tWDg2Jy3ebRz2rXowDxnld4bkQB00cc/1Zw9AWnC0i9ztDJitivtQvaI9KaLyKrc+hBW0yg==";
      };
    };
    "fuzzy-search-3.2.1" = {
      name = "fuzzy-search";
      packageName = "fuzzy-search";
      version = "3.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/fuzzy-search/-/fuzzy-search-3.2.1.tgz";
        sha512 = "vAcPiyomt1ioKAsAL2uxSABHJ4Ju/e4UeDM+g1OlR0vV4YhLGMNsdLNvZTpEDY4JCSt0E4hASCNM5t2ETtsbyg==";
      };
    };
    "glob-parent-5.1.2" = {
      name = "glob-parent";
      packageName = "glob-parent";
      version = "5.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/glob-parent/-/glob-parent-5.1.2.tgz";
        sha512 = "AOIgSQCepiJYwP3ARnGx+5VnTu2HBYdzbGP45eLw1vr3zB3vZLeyed1sC9hnbcOc9/SrMyM5RPQrkGz4aS9Zow==";
      };
    };
    "iconv-lite-0.6.3" = {
      name = "iconv-lite";
      packageName = "iconv-lite";
      version = "0.6.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/iconv-lite/-/iconv-lite-0.6.3.tgz";
        sha512 = "4fCk79wshMdzMp2rH06qWrJE4iolqLhCUH+OiuIgU++RB0+94NlDL81atO7GX55uUKueo0txHNtvEyI6D7WdMw==";
      };
    };
    "is-extglob-2.1.1" = {
      name = "is-extglob";
      packageName = "is-extglob";
      version = "2.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-extglob/-/is-extglob-2.1.1.tgz";
        sha512 = "SbKbANkN603Vi4jEZv49LeVJMn4yGwsbzZworEoyEiutsN3nJYdbO36zfhGJ6QEDpOZIFkDtnq5JRxmvl3jsoQ==";
      };
    };
    "is-glob-4.0.3" = {
      name = "is-glob";
      packageName = "is-glob";
      version = "4.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-glob/-/is-glob-4.0.3.tgz";
        sha512 = "xelSayHH36ZgE7ZWhli7pW34hNbNl8Ojv5KVmkJD4hBdD3th8Tfk9vYasLM+mXWOZhFkgZfxhLSnrwRr4elSSg==";
      };
    };
    "is-number-7.0.0" = {
      name = "is-number";
      packageName = "is-number";
      version = "7.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-number/-/is-number-7.0.0.tgz";
        sha512 = "41Cifkg6e8TylSpdtTpeLVMqvSBEVzTttHvERD741+pnZ8ANv0004MRL43QKPDlK9cGvNp6NZWZUBlbGXYxxng==";
      };
    };
    "merge2-1.4.1" = {
      name = "merge2";
      packageName = "merge2";
      version = "1.4.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/merge2/-/merge2-1.4.1.tgz";
        sha512 = "8q7VEgMJW4J8tcfVPy8g09NcQwZdbwFEqhe/WZkoIzjn/3TGDwtOCYtXGxA3O8tPzpczCCDgv+P2P5y00ZJOOg==";
      };
    };
    "micromatch-4.0.7" = {
      name = "micromatch";
      packageName = "micromatch";
      version = "4.0.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/micromatch/-/micromatch-4.0.7.tgz";
        sha512 = "LPP/3KorzCwBxfeUuZmaR6bG2kdeHSbe0P2tY3FLRU4vYrjYz5hI4QZwV0njUx3jeuKe67YukQ1LSPZBKDqO/Q==";
      };
    };
    "minimatch-9.0.2" = {
      name = "minimatch";
      packageName = "minimatch";
      version = "9.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/minimatch/-/minimatch-9.0.2.tgz";
        sha512 = "PZOT9g5v2ojiTL7r1xF6plNHLtOeTpSlDI007As2NlA2aYBMfVom17yqa6QzhmDP8QOhn7LjHTg7DFCVSSa6yg==";
      };
    };
    "node-fetch-2.7.0" = {
      name = "node-fetch";
      packageName = "node-fetch";
      version = "2.7.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/node-fetch/-/node-fetch-2.7.0.tgz";
        sha512 = "c4FRfUm/dbcWZ7U+1Wq0AwCyFL+3nt2bEw05wfxSz+DWpWsitgmSgYmy2dQdWyKC1694ELPqMs/YzUSNozLt8A==";
      };
    };
    "path-browserify-1.0.1" = {
      name = "path-browserify";
      packageName = "path-browserify";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/path-browserify/-/path-browserify-1.0.1.tgz";
        sha512 = "b7uo2UCUOYZcnF/3ID0lulOJi/bafxa1xPe7ZPsammBSpjSWQkjNxlt635YGS2MiR9GjvuXCtz2emr3jbsz98g==";
      };
    };
    "picomatch-2.3.1" = {
      name = "picomatch";
      packageName = "picomatch";
      version = "2.3.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/picomatch/-/picomatch-2.3.1.tgz";
        sha512 = "JU3teHTNjmE2VCGFzuY8EXzCDVwEqB2a8fsIvwaStHhAWJEeVd1o1QD80CU6+ZdEXXSLbSsuLwJjkCBWqRQUVA==";
      };
    };
    "queue-microtask-1.2.3" = {
      name = "queue-microtask";
      packageName = "queue-microtask";
      version = "1.2.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/queue-microtask/-/queue-microtask-1.2.3.tgz";
        sha512 = "NuaNSa6flKT5JaSYQzJok04JzTL1CA6aGhv5rfLW3PgqA+M2ChpZQnAC8h8i4ZFkBS8X5RqkDBHA7r4hej3K9A==";
      };
    };
    "reusify-1.0.4" = {
      name = "reusify";
      packageName = "reusify";
      version = "1.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/reusify/-/reusify-1.0.4.tgz";
        sha512 = "U9nH88a3fc/ekCF1l0/UP1IosiuIjyTh7hBvXVMHYgVcfGvt897Xguj2UOLDeI5BG2m7/uwyaLVT6fbtCwTyzw==";
      };
    };
    "run-parallel-1.2.0" = {
      name = "run-parallel";
      packageName = "run-parallel";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/run-parallel/-/run-parallel-1.2.0.tgz";
        sha512 = "5l4VyZR86LZ/lDxZTR6jqL8AFE2S0IFLMP26AbjsLVADxHdhB/c0GUsH+y39UfCi3dzz8OlQuPmnaJOMoDHQBA==";
      };
    };
    "safer-buffer-2.1.2" = {
      name = "safer-buffer";
      packageName = "safer-buffer";
      version = "2.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/safer-buffer/-/safer-buffer-2.1.2.tgz";
        sha512 = "YZo3K82SD7Riyi0E1EQPojLz7kpepnSQI9IyPbHHg1XXXevb5dJI7tpyN2ADxGcQbHG7vcyRHk0cbwqcQriUtg==";
      };
    };
    "semver-7.6.3" = {
      name = "semver";
      packageName = "semver";
      version = "7.6.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/semver/-/semver-7.6.3.tgz";
        sha512 = "oVekP1cKtI+CTDvHWYFUcMtsK/00wmAEfyqKfNdARm8u1wNVhSgaX7A8d4UuIlUI5e84iEwOhs7ZPYRmzU9U6A==";
      };
    };
    "to-regex-range-5.0.1" = {
      name = "to-regex-range";
      packageName = "to-regex-range";
      version = "5.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/to-regex-range/-/to-regex-range-5.0.1.tgz";
        sha512 = "65P7iz6X5yEr1cwcgvQxbbIw7Uk3gOy5dIdtZ4rDveLqhrdJP+Li/Hx6tyK0NEb+2GCyneCMJiGqrADCSNk8sQ==";
      };
    };
    "tr46-0.0.3" = {
      name = "tr46";
      packageName = "tr46";
      version = "0.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/tr46/-/tr46-0.0.3.tgz";
        sha512 = "N3WMsuqV66lT30CrXNbEjx4GEwlow3v6rr4mCcv6prnfwhS01rkgyFdjPNBYd9br7LpXV1+Emh01fHnq2Gdgrw==";
      };
    };
    "turndown-7.1.3" = {
      name = "turndown";
      packageName = "turndown";
      version = "7.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/turndown/-/turndown-7.1.3.tgz";
        sha512 = "Z3/iJ6IWh8VBiACWQJaA5ulPQE5E1QwvBHj00uGzdQxdRnd8fh1DPqNOJqzQDu6DkOstORrtXzf/9adB+vMtEA==";
      };
    };
    "vscode-jsonrpc-8.0.2" = {
      name = "vscode-jsonrpc";
      packageName = "vscode-jsonrpc";
      version = "8.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/vscode-jsonrpc/-/vscode-jsonrpc-8.0.2.tgz";
        sha512 = "RY7HwI/ydoC1Wwg4gJ3y6LpU9FJRZAUnTYMXthqhFXXu77ErDd/xkREpGuk4MyYkk4a+XDWAMqe0S3KkelYQEQ==";
      };
    };
    "vscode-languageserver-8.0.2" = {
      name = "vscode-languageserver";
      packageName = "vscode-languageserver";
      version = "8.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/vscode-languageserver/-/vscode-languageserver-8.0.2.tgz";
        sha512 = "bpEt2ggPxKzsAOZlXmCJ50bV7VrxwCS5BI4+egUmure/oI/t4OlFzi/YNtVvY24A2UDOZAgwFGgnZPwqSJubkA==";
      };
    };
    "vscode-languageserver-protocol-3.17.2" = {
      name = "vscode-languageserver-protocol";
      packageName = "vscode-languageserver-protocol";
      version = "3.17.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/vscode-languageserver-protocol/-/vscode-languageserver-protocol-3.17.2.tgz";
        sha512 = "8kYisQ3z/SQ2kyjlNeQxbkkTNmVFoQCqkmGrzLH6A9ecPlgTbp3wDTnUNqaUxYr4vlAcloxx8zwy7G5WdguYNg==";
      };
    };
    "vscode-languageserver-textdocument-1.0.11" = {
      name = "vscode-languageserver-textdocument";
      packageName = "vscode-languageserver-textdocument";
      version = "1.0.11";
      src = fetchurl {
        url = "https://registry.npmjs.org/vscode-languageserver-textdocument/-/vscode-languageserver-textdocument-1.0.11.tgz";
        sha512 = "X+8T3GoiwTVlJbicx/sIAF+yuJAqz8VvwJyoMVhwEMoEKE/fkDmrqUgDMyBECcM2A2frVZIUj5HI/ErRXCfOeA==";
      };
    };
    "vscode-languageserver-types-3.17.2" = {
      name = "vscode-languageserver-types";
      packageName = "vscode-languageserver-types";
      version = "3.17.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/vscode-languageserver-types/-/vscode-languageserver-types-3.17.2.tgz";
        sha512 = "zHhCWatviizPIq9B7Vh9uvrH6x3sK8itC84HkamnBWoDFJtzBf7SWlpLCZUit72b3os45h6RWQNC9xHRDF8dRA==";
      };
    };
    "vscode-uri-3.0.8" = {
      name = "vscode-uri";
      packageName = "vscode-uri";
      version = "3.0.8";
      src = fetchurl {
        url = "https://registry.npmjs.org/vscode-uri/-/vscode-uri-3.0.8.tgz";
        sha512 = "AyFQ0EVmsOZOlAnxoFOGOq1SQDWAB7C6aqMGS23svWAllfOaxbuFvcT8D1i8z3Gyn8fraVeZNNmN6e9bxxXkKw==";
      };
    };
    "web-tree-sitter-0.22.5" = {
      name = "web-tree-sitter";
      packageName = "web-tree-sitter";
      version = "0.22.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/web-tree-sitter/-/web-tree-sitter-0.22.5.tgz";
        sha512 = "rGX2jRXjcGOhf35zWyO0i/+Wjz4/KVUYN9Oh3AhDsZ0fGOgTIkw/bMhqwvc8L7HgMK8rqDq9RcROWc7lnsnhWg==";
      };
    };
    "webidl-conversions-3.0.1" = {
      name = "webidl-conversions";
      packageName = "webidl-conversions";
      version = "3.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/webidl-conversions/-/webidl-conversions-3.0.1.tgz";
        sha512 = "2JAn3z8AR6rjK8Sm8orRC0h/bcl/DqL7tRPdGZ4I1CjdF+EaMLmYxBHyXuKL849eucPFhvBoxMsflfOb8kxaeQ==";
      };
    };
    "whatwg-url-5.0.0" = {
      name = "whatwg-url";
      packageName = "whatwg-url";
      version = "5.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/whatwg-url/-/whatwg-url-5.0.0.tgz";
        sha512 = "saE57nupxk6v3HY35+jzBwYa0rKSy0XR8JSxZPwgLr7ys0IBzhGviA1/TUGJLmSVqs8pb9AnvICXEuOHLprYTw==";
      };
    };
    "zod-3.22.4" = {
      name = "zod";
      packageName = "zod";
      version = "3.22.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/zod/-/zod-3.22.4.tgz";
        sha512 = "iC+8Io04lddc+mVqQ9AZ7OQ2MrUKGN+oIQyq1vemgt46jwCwLfhq7/pwnBnNXXXZb8VTVLKwp9EDkx+ryxIWmg==";
      };
    };
  };
in
{
  "@astrojs/ts-plugin" = nodeEnv.buildNodePackage {
    name = "_at_astrojs_slash_ts-plugin";
    packageName = "@astrojs/ts-plugin";
    version = "1.9.0";
    src = fetchurl {
      url = "https://registry.npmjs.org/@astrojs/ts-plugin/-/ts-plugin-1.9.0.tgz";
      sha512 = "QastYNlKF2I0oOksKRm3bG8auk2AlyD6be7ptHzSHKj/ikUvK9ObnS2ruGFh0h8aQ760Qw7aEJ9JZT/IZ7t46A==";
    };
    dependencies = [
      sources."@astrojs/compiler-2.9.2"
      sources."@jridgewell/sourcemap-codec-1.5.0"
      sources."@volar/language-core-2.4.0-alpha.18"
      sources."@volar/source-map-2.4.0-alpha.18"
      sources."@volar/typescript-2.4.0-alpha.18"
      sources."path-browserify-1.0.1"
      sources."semver-7.6.3"
      sources."vscode-languageserver-textdocument-1.0.11"
      sources."vscode-uri-3.0.8"
    ];
    buildInputs = globalBuildInputs;
    meta = {
      description = "A TypeScript Plugin providing Astro intellisense";
      homepage = "https://github.com/withastro/language-tools#readme";
      license = "MIT";
    };
    production = true;
    bypassCache = true;
    reconstructLock = true;
  };
  bash-language-server = nodeEnv.buildNodePackage {
    name = "bash-language-server";
    packageName = "bash-language-server";
    version = "5.4.0";
    src = fetchurl {
      url = "https://registry.npmjs.org/bash-language-server/-/bash-language-server-5.4.0.tgz";
      sha512 = "YLCIBjnwdxvlwlurTA4Be7UfPXDzaWCJKzJwzO8rVjJH0QlbhPvo3FXkYOBXPLg81G4hb0ZbhSAi4+yrs7j5cQ==";
    };
    dependencies = [
      sources."@nodelib/fs.scandir-2.1.5"
      sources."@nodelib/fs.stat-2.0.5"
      sources."@nodelib/fs.walk-1.2.8"
      sources."@one-ini/wasm-0.1.1"
      sources."balanced-match-1.0.2"
      sources."brace-expansion-2.0.1"
      sources."braces-3.0.3"
      sources."commander-11.1.0"
      sources."domino-2.1.6"
      sources."editorconfig-2.0.0"
      sources."encoding-0.1.13"
      sources."fast-glob-3.3.2"
      sources."fastq-1.17.1"
      sources."fill-range-7.1.1"
      sources."fuzzy-search-3.2.1"
      sources."glob-parent-5.1.2"
      sources."iconv-lite-0.6.3"
      sources."is-extglob-2.1.1"
      sources."is-glob-4.0.3"
      sources."is-number-7.0.0"
      sources."merge2-1.4.1"
      sources."micromatch-4.0.7"
      sources."minimatch-9.0.2"
      sources."node-fetch-2.7.0"
      sources."picomatch-2.3.1"
      sources."queue-microtask-1.2.3"
      sources."reusify-1.0.4"
      sources."run-parallel-1.2.0"
      sources."safer-buffer-2.1.2"
      sources."semver-7.6.3"
      sources."to-regex-range-5.0.1"
      sources."tr46-0.0.3"
      sources."turndown-7.1.3"
      sources."vscode-jsonrpc-8.0.2"
      sources."vscode-languageserver-8.0.2"
      sources."vscode-languageserver-protocol-3.17.2"
      sources."vscode-languageserver-textdocument-1.0.11"
      sources."vscode-languageserver-types-3.17.2"
      sources."web-tree-sitter-0.22.5"
      sources."webidl-conversions-3.0.1"
      sources."whatwg-url-5.0.0"
      sources."zod-3.22.4"
    ];
    buildInputs = globalBuildInputs;
    meta = {
      description = "A language server for Bash";
      homepage = "https://github.com/bash-lsp/bash-language-server#readme";
      license = "MIT";
    };
    production = true;
    bypassCache = true;
    reconstructLock = true;
  };
}
