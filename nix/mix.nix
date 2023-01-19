{ lib, beamPackages, overrides ? (x: y: { }) }:

let
  buildRebar3 = lib.makeOverridable beamPackages.buildRebar3;
  buildMix = lib.makeOverridable beamPackages.buildMix;
  buildErlangMk = lib.makeOverridable beamPackages.buildErlangMk;

  self = packages // (overrides self packages);

  packages = with beamPackages;
    with self; {
      bunt = buildMix rec {
        name = "bunt";
        version = "0.2.1";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "19bp6xh052ql3ha0v3r8999cvja5d2p6cph02mxphfaj4jsbyc53";
        };

        beamDeps = [ ];
      };

      castore = buildMix rec {
        name = "castore";
        version = "1.0.0";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "0jr8ziwb0hs3a5hliyvz75kngkkf7f5bng53vyhprac3b62hwzap";
        };

        beamDeps = [ ];
      };

      cowboy = buildErlangMk rec {
        name = "cowboy";
        version = "2.9.0";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "1phv0a1zbgk7imfgcm0dlacm7hbjcdygb0pqmx4s26jf9f9rywic";
        };

        beamDeps = [ cowlib ranch ];
      };

      cowboy_telemetry = buildRebar3 rec {
        name = "cowboy_telemetry";
        version = "0.4.0";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "1pn90is3k9dq64wbijvzkqb6ldfqvwiqi7ymc8dx6ra5xv0vm63x";
        };

        beamDeps = [ cowboy telemetry ];
      };

      cowlib = buildRebar3 rec {
        name = "cowlib";
        version = "2.11.0";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "1ac6pj3x4vdbsa8hvmbzpdfc4k0v1p102jbd39snai8wnah9sgib";
        };

        beamDeps = [ ];
      };

      credo = buildMix rec {
        name = "credo";
        version = "1.7.0-rc.1";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "10q8w67gmw90hbwal3gvlba1z3zzrc567l8vz5r2s2mxiyyi6cjj";
        };

        beamDeps = [ bunt file_system jason ];
      };

      earmark_parser = buildMix rec {
        name = "earmark_parser";
        version = "1.4.29";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "00rmqvf3hkxfvkijqd624n0hn1xqims8h211xmm02fdi7qdsy0j9";
        };

        beamDeps = [ ];
      };

      esbuild = buildMix rec {
        name = "esbuild";
        version = "0.6.0";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "0h6hiwqp9m06kla0kjl1l3hiwkl6h0pk33rr6wz0vasv99fs1y9h";
        };

        beamDeps = [ castore ];
      };

      ex_doc = buildMix rec {
        name = "ex_doc";
        version = "0.29.1";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "1xkljn0ggg7fk8qv2dmr2m40h3lmfhi038p2hksdldja6yk5yx5p";
        };

        beamDeps = [ earmark_parser makeup_elixir makeup_erlang ];
      };

      expo = buildMix rec {
        name = "expo";
        version = "0.1.0";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "0idzpg3bc9ady0lqrkxs6y0x9daffjsapppfm9cf0vf545h56b62";
        };

        beamDeps = [ ];
      };

      file_system = buildMix rec {
        name = "file_system";
        version = "0.2.10";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "1p0myxmnjjds8bbg69dd6fvhk8q3n7lb78zd4qvmjajnzgdmw6a1";
        };

        beamDeps = [ ];
      };

      floki = buildMix rec {
        name = "floki";
        version = "0.34.0";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "1769xg2sqdh6s1j06l7gi98iy35ri79xk6sq58rh1phdyi1ryflw";
        };

        beamDeps = [ ];
      };

      gettext = buildMix rec {
        name = "gettext";
        version = "0.21.0";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "1xhl5zxvpvp4hkppnsri55r52yqnfcnbnh12z4c1sv9v22s6v9h4";
        };

        beamDeps = [ expo ];
      };

      jason = buildMix rec {
        name = "jason";
        version = "1.4.0";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "0891p2yrg3ri04p302cxfww3fi16pvvw1kh4r91zg85jhl87k8vr";
        };

        beamDeps = [ ];
      };

      makeup = buildMix rec {
        name = "makeup";
        version = "1.1.0";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "19jpprryixi452jwhws3bbks6ki3wni9kgzah3srg22a3x8fsi8a";
        };

        beamDeps = [ nimble_parsec ];
      };

      makeup_elixir = buildMix rec {
        name = "makeup_elixir";
        version = "0.16.0";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "1rrqydcq2bshs577z7jbgdnrlg7cpnzc8n48kap4c2ln2gfcpci8";
        };

        beamDeps = [ makeup nimble_parsec ];
      };

      makeup_erlang = buildMix rec {
        name = "makeup_erlang";
        version = "0.1.1";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "1fvw0zr7vqd94vlj62xbqh0yrih1f7wwnmlj62rz0klax44hhk8p";
        };

        beamDeps = [ makeup ];
      };

      mime = buildMix rec {
        name = "mime";
        version = "2.0.3";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "0szzdfalafpawjrrwbrplhkgxjv8837mlxbkpbn5xlj4vgq0p8r7";
        };

        beamDeps = [ ];
      };

      nimble_parsec = buildMix rec {
        name = "nimble_parsec";
        version = "1.2.3";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "1c3hnppmjkwnqrc9vvm72kpliav0mqyyk4cjp7vsqccikgiqkmy8";
        };

        beamDeps = [ ];
      };

      phoenix = buildMix rec {
        name = "phoenix";
        version = "1.6.15";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "0wh6s8id3b4c4hgiawq995p192wxsws4sr4bm1g7b55kyvxvj2np";
        };

        beamDeps = [
          castore
          jason
          phoenix_pubsub
          phoenix_view
          plug
          plug_cowboy
          plug_crypto
          telemetry
        ];
      };

      phoenix_html = buildMix rec {
        name = "phoenix_html";
        version = "3.2.0";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "0ky5idgid1psz6hmh2b2kmj6n974axww74hrxwv02p6jasx9gv1n";
        };

        beamDeps = [ plug ];
      };

      phoenix_live_dashboard = buildMix rec {
        name = "phoenix_live_dashboard";
        version = "0.6.5";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "0lmq1m7k465i9mzw35l7bx69n85mibwzd76976840r43sw6sakzg";
        };

        beamDeps = [ mime phoenix_live_view telemetry_metrics ];
      };

      phoenix_live_reload = buildMix rec {
        name = "phoenix_live_reload";
        version = "1.4.1";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "1aqm6sxy4ijd5gi8lmjmcaxal1smg2smibjlzrkq9w6xwwsbizwv";
        };

        beamDeps = [ file_system phoenix ];
      };

      phoenix_live_view = buildMix rec {
        name = "phoenix_live_view";
        version = "0.17.12";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "1j4r1pjl60hphan7mf0fn60cnqkdc7hah9zmf4sz8vy1mbhdavdg";
        };

        beamDeps = [ jason phoenix phoenix_html telemetry ];
      };

      phoenix_pubsub = buildMix rec {
        name = "phoenix_pubsub";
        version = "2.1.1";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "1nfqrmbrq45if9pgk6g6vqiply2sxc40is3bfanphn7a3rnpqdl1";
        };

        beamDeps = [ ];
      };

      phoenix_template = buildMix rec {
        name = "phoenix_template";
        version = "1.0.0";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "0ms39n5s6kh532s20yxzj7sh0rz5lslh09ibq5j21lkglacny1hv";
        };

        beamDeps = [ phoenix_html ];
      };

      phoenix_view = buildMix rec {
        name = "phoenix_view";
        version = "2.0.2";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "0vykabqxyk08gkfm45zy5dnlnzygwx6g9z4z2h7fxix51qiyfad9";
        };

        beamDeps = [ phoenix_html phoenix_template ];
      };

      plug = buildMix rec {
        name = "plug";
        version = "1.14.0";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "056wkb1b17mh5h9ncs2vbswvpjsm2iqc580nmyrvgznlqwr080mz";
        };

        beamDeps = [ mime plug_crypto telemetry ];
      };

      plug_cowboy = buildMix rec {
        name = "plug_cowboy";
        version = "2.6.0";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "19jgv5dm53hv5aqgxxzr3fnrpgfll9ics199swp6iriwfl5z4g07";
        };

        beamDeps = [ cowboy cowboy_telemetry plug ];
      };

      plug_crypto = buildMix rec {
        name = "plug_crypto";
        version = "1.2.3";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "18plj2idhp3f0nmqyjjf2rzj849l3br0797m8ln20p5dqscj0rxm";
        };

        beamDeps = [ ];
      };

      ranch = buildRebar3 rec {
        name = "ranch";
        version = "1.8.0";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "1rfz5ld54pkd2w25jadyznia2vb7aw9bclck21fizargd39wzys9";
        };

        beamDeps = [ ];
      };

      swoosh = buildMix rec {
        name = "swoosh";
        version = "1.9.1";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "07ipsrp34s18c9zd5kglqsdc8z7gxa9aadsrklj0zf6azzrzzpvn";
        };

        beamDeps = [ cowboy jason mime plug_cowboy telemetry ];
      };

      telemetry = buildRebar3 rec {
        name = "telemetry";
        version = "1.2.1";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "1mgyx9zw92g6w8fp9pblm3b0bghwxwwcbslrixq23ipzisfwxnfs";
        };

        beamDeps = [ ];
      };

      telemetry_metrics = buildMix rec {
        name = "telemetry_metrics";
        version = "0.6.1";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "1iilk2n75kn9i95fdp8mpxvn3rcn3ghln7p77cijqws13j3y1sbv";
        };

        beamDeps = [ telemetry ];
      };

      telemetry_poller = buildRebar3 rec {
        name = "telemetry_poller";
        version = "1.0.0";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "0vjgxkxn9ll1gc6xd8jh4b0ldmg9l7fsfg7w63d44gvcssplx8mk";
        };

        beamDeps = [ telemetry ];
      };
    };
in self

