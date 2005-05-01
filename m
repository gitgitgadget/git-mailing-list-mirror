From: Russell King <rmk@arm.linux.org.uk>
Subject: Todays update (with cogito 0.8)
Date: Sun, 1 May 2005 09:27:43 +0100
Message-ID: <20050501092743.B7459@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 01 10:22:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DS9iD-0005G9-F6
	for gcvg-git@gmane.org; Sun, 01 May 2005 10:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVEAI15 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 04:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVEAI15
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 04:27:57 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27658 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261552AbVEAI1s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2005 04:27:48 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DS9nl-0006AI-El
	for git@vger.kernel.org; Sun, 01 May 2005 09:27:45 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DS9nk-0002pw-9G
	for git@vger.kernel.org; Sun, 01 May 2005 09:27:44 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This still doesn't seem to be working properly (details below):

MOTD:	
MOTD:	Welcome to the Linux Kernel Archive.
MOTD:	
MOTD:	Due to U.S. Exports Regulations, all cryptographic software on this
MOTD:	site is subject to the following legal notice:
MOTD:	
MOTD:	This site includes publicly available encryption source code
MOTD:	which, together with object code resulting from the compiling of
MOTD:	publicly available source code, may be exported from the United
MOTD:	States under License Exception "TSU" pursuant to 15 C.F.R. Section
MOTD:	740.13(e).
MOTD:	
MOTD:	This legal notice applies to cryptographic software only.
MOTD:	Please see the Bureau of Industry and Security,
MOTD:	http://www.bis.doc.gov/ for more information about current
MOTD:	U.S. regulations.
MOTD:	

receiving file list ... done
.git/refs/heads/origin

sent 142 bytes  received 857 bytes  399.60 bytes/sec
total size is 41  speedup is 0.04

receiving file list ... done
00/83f2ab03ca2ec99ef2d31104710cf3898ce065
04/783ceb050c13d7a475a60bdb916b6eb56ffddf
06/6744ef2b6f86d258c40b00ad6390060d4b4288
07/a8f51940fb0ee87721628b0e84dd48b293d9a0
12/be8c2f4969d94e724aecaee7681a99ed4ba41d
12/f1b1dca9d98e3aaed6e9d8e5db123da16d6e9e
13/59cf3d21c56aa884c704656c16c0df87c3e6cb
17/47e1bfd5a700bc4242981c82ac35afcf834124
18/a6f4b9824853e4afb4f42410eb855f6b188fa1
1a/844ca139e0df85e57cee2a67916aa305b1ffcb
1a/b353e235955eee63e43a3a030d0b8b4b719a2b
1d/651f3332340c232ff66b7f5bab66cb8903859f
1d/db8a16aa0e60e7fdc48b1f532cf43e692f8fae
1f/dbe77e8211508763d1e0e9c5fec7065fc1c599
24/c3666b0f36f9e99c6d91a3266032285781cae6
28/96a380d4ea902d88f3831d23e847f63ffcf7c3
2c/acb3da620a4a93f3a77e1d2c8c06bb3c74bcb0
2f/e7cf50bb45a3ca94f095695bab5414fa56c1f3
31/eba8fc14bad5baac157b6f9a1123d02e6e89ce
32/1dbe91dc14e270450216cf4cc79562d89ca225
33/d8b5800cfaa3d75fd738c3c39411d27e6f9086
36/d362b6f5522e59e663031f4ce2eaf6169b38c3
37/0dfe77589d2abd9d8a963772fc79072feba5c0
3b/948e8c27513f7896263a87a99123ad5394b860
3c/2fa5c284c04ef223c468c2df53f6c7676dc20a
41/4f0ffac3493a9c34ded9c137ce8dfdda83ae7e
47/74e2260cf25c54f2188dd0407676e3af6f1f23
48/990899db0d9a9506e72fe2fa79570c3b5a306b
49/e7dc54cd4cbdb439ecc4e06214b0ca1a1a72b4
4f/a27a868f60eabcffec9971c03cdb7b12629ca6
53/8f078cc9db35255c8224d3bd39292357c7d998
68/575476718ed1c6d6ddafeec8310b109e7a7a7f
6f/2a6107859521b5f6b498aa50421cf0d0aebb7a
72/b03f201eb946f97c9f419090d683ece6ea5bc1
74/0fd350c127e12a902e7d781250429c30282bd7
74/1ff0c69f37f44154247020649b4104afff0cda
75/22285ae23e8375d91e3ef1e1a8a38acc6707d0
77/11c1cb3bfa0ef6ba82a20b3af86a490e844131
7a/76d85912492f50504ba428f4e1c9bdd3725c37
86/43112fac20933b0abcb5ccb5ea4fb3206962f2
8c/c881694e2911d0a2eff3ca7eb5dd5efc0503d3
90/ab8bb6a1d7dcced48f3d079dd455dd66cfdfc0
93/9c6303e46bbb5f763d51ad43768a4379ef46d0
95/483baab706baa9921eb14757c08da90970fdb5
95/c744856cbe042190fe5a346f4f99fd8d655931
97/47dd6fa98f2983f4dd09cd6dad1fa3d2a4c5f2
99/c47c498867ff5ee2fe0845622f4d1c4e1df1f4
9d/31aaad024e5e56d0ee124ea5909e1513e351c7
9e/a1f8f505f6f770bd593e689960ac4f893509b2
9e/b5099b4517719370a7655b825dc78ff0051d56
a3/183c173e2fbd44f4cc23da7a18bb283b00c64f
a3/89c37a97b58a3c31d19b2ab9665bb96196972e
a4/5aaa115a76664bb81438455b06a6ff890886f7
b3/d9ae4b98f6d28481d4d4b768d860a2cfb5805d
b5/9438bc23460062417fe1d5e3aa16679cde91bb
b5/fd078b5a6deada354ca78f0e6334c718ad6989
b6/d8654a4f75e8eeba365d4fa20073e0e39258b0
b7/d0f7f2fe5498c5845a974df475132634af4a74
bb/9bffcbef6166cf03385fbcde97c27bc1a5e689
bf/12fe2ba57544a73e0cc33858973f842e6490d3
c1/c9aa8a8e8fe3a3ffd5559ff0432bcb0a7249d8
c2/a7103979aff61109bdc6c6d572238338b79ce3
cf/04dd7d7b54dd2cb21ff305dae41a770278bf4e
d5/aa207e46ff7ee838683a7d95ecf46fe42a9a56
d6/66db0d6c68a8bc887e65e873d84ffa2c7e02d8
d8/c98e6ebdade1c73ea6926b6be3d86d9ade9cb6
dd/b7d643d247c1f7650245794433b7c1eec92331
dd/e77151cc2360c15c804ef82eb1fd628e53f10e
df/0d2d760073f9bd841a85ed0e1d758c8bacd3e3
df/4e2c7e4254667485a73c0b8960151fe47043f2
e3/06d25a5ad1ad6b22aefbdf8bb5e557cead1e4b
e8/e6993178344eb348f60f05b16d9dc30db3b9cf
eb/42422f72456e40a1152ae0ce4f4df44f4d1ef5
ed/562ab12733ab75437b3390427d41fce9da83c3
ed/867db550a9da16a690a9a122b28d33491ac6f8
f5/0443f1c9ea6c85a2733e67840d4860cdab4d3b
f8/50fb0fb5118be47d976291ee028697fbdeb688
f8/e191827f6ff913d083a89028b1b732ef56b231

sent 1674 bytes  received 1186530 bytes  34440.70 bytes/sec
total size is 70393608  speedup is 59.24

receiving file list ... done
client: nothing to do: perhaps you need to specify some filenames or the --recursive option?

receiving file list ... done
client: nothing to do: perhaps you need to specify some filenames or the --recursive option?
unable to get tags list (non-fatal)
Tree change: a6ad57fb4b5e9d68553f4440377b99f75588fa88:e8e6993178344eb348f60f05b16d9dc30db3b9cf
*100644->100644	blob	8da3a306d0c0c070d87048d14a033df02f40a154->48990899db0d9a9506e72fe2fa79570c3b5a306b	Makefile
*100644->100644	blob	c397e71f938d0f79fbcbf29869fbb1d40cf09306->72b03f201eb946f97c9f419090d683ece6ea5bc1	arch/arm/common/rtctime.c
*100644->100644	blob	68e15c36e33610d6ed0ccec61d7d7a23ebcd4fa3->3b948e8c27513f7896263a87a99123ad5394b860	arch/arm/mach-integrator/integrator_cp.c
*100644->100644	blob	20729de2af285d62102691ef20942f7caab184af->1a844ca139e0df85e57cee2a67916aa305b1ffcb	arch/arm/mach-integrator/time.c
*100644->100644	blob	b1575b8dc1cd3e043f78794c56df9d57e6e96afa->a45aaa115a76664bb81438455b06a6ff890886f7	arch/arm/mach-pxa/generic.c
*100644->100644	blob	314c7146e9bf0a58c9df75c86065b4ad7598b419->04783ceb050c13d7a475a60bdb916b6eb56ffddf	arch/i386/Makefile
*100644->100644	blob	774de8e2387193be0570a3fba681fd6dd1936816->f850fb0fb5118be47d976291ee028697fbdeb688	arch/ppc/boot/images/Makefile
*100644->100644	blob	b0e167db6af9c68f49949d409abc747d3119842f->3c2fa5c284c04ef223c468c2df53f6c7676dc20a	arch/ppc64/kernel/signal32.c
*100644->100644	blob	8e61be34a1d328c5a948a646504ad65629eaef62->ed867db550a9da16a690a9a122b28d33491ac6f8	drivers/char/s3c2410-rtc.c
*100644->100644	blob	3e386fd4c5c6e627699ccd04117b712030f0f3f4->321dbe91dc14e270450216cf4cc79562d89ca225	drivers/video/amba-clcd.c
*100644->100644	blob	4d2404305ab687c2a0eee84b3c5842ba9852965a->95483baab706baa9921eb14757c08da90970fdb5	fs/cifs/CHANGES
*100644->100644	blob	1e8490ed694878b3bbed1e96ab792791ddf1daed->8cc881694e2911d0a2eff3ca7eb5dd5efc0503d3	fs/cifs/TODO
*100644->100644	blob	b004fef0a42bac42e8b3490fba19df1ea233762d->741ff0c69f37f44154247020649b4104afff0cda	fs/cifs/cifssmb.c
*100644->100644	blob	d31c1a71f781ccc7c189e3bff9dc1ee4ee282188->1ab353e235955eee63e43a3a030d0b8b4b719a2b	include/asm-arm/arch-integrator/cm.h
*100644->100644	blob	aa7e16b2e2255fbcc0f5aef2cf72c241daf2f81b->370dfe77589d2abd9d8a963772fc79072feba5c0	include/asm-arm/rtc.h

Applying changes...
Fast-forwarding a6ad57fb4b5e9d68553f4440377b99f75588fa88 -> e8e6993178344eb348f60f05b16d9dc30db3b9cf
	on top of a6ad57fb4b5e9d68553f4440377b99f75588fa88...
The next patch would create the file arch/ia64/sn/include/pci/pcibus_provider_defs.h,
which already exists!  Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file arch/ia64/sn/include/pci/pcibus_provider_defs.h.rej
The next patch would create the file arch/ia64/sn/include/pci/pcidev.h,
which already exists!  Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file arch/ia64/sn/include/pci/pcidev.h.rej

The diff between these two IDs is:

$ cg-diff -r a6ad57fb4b5e9d68553f4440377b99f75588fa88:e8e6993178344eb348f60f05b16d9dc30db3b9cf| diffstat
 Makefile                                 |    6 ++++--
 arch/arm/common/rtctime.c                |   29 +++++++++++++++--------------
 arch/arm/mach-integrator/integrator_cp.c |   17 ++++++++++++++++-
 arch/arm/mach-integrator/time.c          |   17 ++++++++++++-----
 arch/arm/mach-pxa/generic.c              |   25 +++++++++++++++++++++++++
 arch/i386/Makefile                       |    7 ++++---
 arch/ppc/boot/images/Makefile            |    3 ++-
 arch/ppc64/kernel/signal32.c             |    4 ++--
 drivers/char/s3c2410-rtc.c               |    8 ++++++--
 drivers/video/amba-clcd.c                |    8 ++++----
 fs/cifs/CHANGES                          |    4 +++-
 fs/cifs/TODO                             |   12 ++++++++++--
 fs/cifs/cifssmb.c                        |    6 ++++--
 include/asm-arm/arch-integrator/cm.h     |    6 +++---
 include/asm-arm/rtc.h                    |    4 ++--
 15 files changed, 112 insertions(+), 44 deletions(-)

which doesn't touch those files it's complaining about.  So something's
up with the merging process - I don't see why we'd even be trying to
touch these two files.

-- 
Russell King

