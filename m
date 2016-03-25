From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3 0/5] Expanding tabs in "git log" output
Date: Fri, 25 Mar 2016 15:13:19 +0100
Message-ID: <56F5477F.6090600@web.de>
References: <xmqq7fh0s5l7.fsf@gitster.mtv.corp.google.com>
 <1458775426-2215-1-git-send-email-gitster@pobox.com>
 <56F391A4.6090603@web.de> <xmqqmvpn91o2.fsf@gitster.mtv.corp.google.com>
 <56F50608.10606@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 15:25:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajSUj-0007Y2-LC
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 15:13:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231AbcCYONk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 10:13:40 -0400
Received: from mout.web.de ([212.227.17.11]:53252 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753055AbcCYONk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 10:13:40 -0400
Received: from macce.local ([79.223.101.215]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MC1nQ-1aah3y2u9Y-008qkT; Fri, 25 Mar 2016 15:13:23
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.7.0
In-Reply-To: <56F50608.10606@web.de>
X-Provags-ID: V03:K0:7zip8pEZ2t2OLunZ/oXalBukraVgzwlxEcuf7wJqlepukNItoz3
 NJxDGOMvombJwYjc/xg2c+rRiqXDM1ZWR4uwGYXnp5pI/kjZoLhmNrXwh5YNu8HE7wIhmOu
 CUkyMhz8U/EJytfinpuZDFZp9JJHgfMxipq8ER32OIw3FOixqUHecNAaSlwnwBQzcM18XIW
 +5d7zrTFI77Ht3sFhmOfw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:v+BT7WYYBFQ=:XBN5YonOv/5qCyCPf9PR4f
 zZWn23vSSH98saoyrNIqJELrpZDrj/lTtjjxCE+p0grG3JkHWRtkqjWCAxLMUqiIYPLgLS77i
 tVqDtn4MpM/km1BNfY1lHc0xb8pYMj9syKgeT6m6A/EdZXGoEAitG5pkkLERicCMQN3S3qLI+
 cej0vvs8GPEWd/I95q5oy4heCGFRnXmTU4GpBoyIW2NgNCj6BpB/W4sB+/WDM1dnWoD7d5oES
 2CZyOMjUvV251I74Nt7528BVCuVyzmKTzpq2sCqfQ6Mh+EabROTZ/2K46AHeRO9kbepQXA053
 Cv3icjkvE6bEPgmGRW9/ivm9kt2TWsSpWUxyGJC2qK7IUEkN8VIe+toytSI3DXL+TBxWGQ6N2
 WPntiY0xo8z5/eqG2FEBf6AFoRExAUig3MygZtTDmoTtAR8LDnqGNaJRmLPZQ0xvCAZZTA+6L
 I84sfDkDZTm+/PjF1EJzH+yi7je07Nevxzha6zmkpokV3RhilBZ1wAWoPKCWdAfCFjEqRt++u
 T/aSaC9TPUeEYQEQbzBmZIJhy1ih/rOJ/djMB+jtLawQbTs1Qe9pYb3Ynu0xHip9hVhf1kxOy
 L9x1GrSy2tjMi7CdsFeB52CLApQcCxHS5YlC4L5HkBX6LVIC9R4LBo5IfE8r6zm1AgEKDmnpw
 lPVKyd3vWjQb38oHTcnMcw0NHm0GPXL2AVMTBAHr81j7m0eUFl2Tw+GGbag1Ct6a15u+IjnIE
 4NlNZayVaLKLqhaWmR6wMBtk1DqJeggU2+7Ao6qfdpDFD0RVl1+mYhW650ilLB9LHQUNWN+c 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289887>

This is copy-paste replacement for the last commit.
(Most probably it is white space damaged)
I'm not sure, is it's worth it ?
If yes, I can send a proper patch later.

git show HEAD

commit 3ac551127d51cd59b24f49729d9ce4dd011a09a1
Author: Junio C Hamano <gitster@pobox.com>
Date:   Wed Mar 23 15:57:42 2016 -0700

    pretty-print: Add the config variable log.tabwidth

    The output formats of "git log" that indent the log message by 4
    spaces have been updated to expand tabs by default in previous
    steps, without a way to restore the original behaviour.

    Introduce a config variable log.tabwidth to allow this.

        $ git -c log.tabwidth=0 log [--pretty=medium]

    would not expand.

    The non-expansion can be made permanent:
        $ git config log.tabwidth 0

    Or the TAB width can be changed like this:
        $ git config log.tabwidth 4

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2cd6bdd..611f5e4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1915,6 +1915,10 @@ log.showRoot::
 	Tools like linkgit:git-log[1] or linkgit:git-whatchanged[1], which
 	normally hide the root commit will now show it. True by default.

+log.tabWidth::
+	Sets the width of a TAB.  If 0, no TAB expansion is done.
+	8 by default.
+
 log.mailmap::
 	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
 	linkgit:git-whatchanged[1] assume `--use-mailmap`.
diff --git a/cache.h b/cache.h
index b829410..fd115d2 100644
--- a/cache.h
+++ b/cache.h
@@ -649,6 +649,7 @@ extern int ignore_case;
 extern int assume_unchanged;
 extern int prefer_symlink_refs;
 extern int log_all_ref_updates;
+extern unsigned log_tab_width;
 extern int warn_ambiguous_refs;
 extern int warn_on_object_refname_ambiguity;
 extern int shared_repository;
diff --git a/config.c b/config.c
index 9ba40bc..e6aadfe 100644
--- a/config.c
+++ b/config.c
@@ -1030,6 +1030,11 @@ int git_default_config(const char *var, const char
*value, void *dummy)
 		pack_size_limit_cfg = git_config_ulong(var, value);
 		return 0;
 	}
+
+	if (!strcmp(var, "log.tabwidth")) {
+		log_tab_width = (unsigned)git_config_ulong(var, value);
+		return 0;
+	}
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 6dec9d0..3c72b44 100644
--- a/environment.c
+++ b/environment.c
@@ -21,6 +21,7 @@ int ignore_case;
 int assume_unchanged;
 int prefer_symlink_refs;
 int is_bare_repository_cfg = -1; /* unspecified */
+unsigned log_tab_width = 8;
 int log_all_ref_updates = -1; /* unspecified */
 int warn_ambiguous_refs = 1;
 int warn_on_object_refname_ambiguity = 1;
diff --git a/pretty.c b/pretty.c
index 5a33b7e..1d92c55 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1667,7 +1667,7 @@ static void strbuf_add_tabexpand(struct strbuf *sb,
 		strbuf_add(sb, line, tab - line);

 		/* .. and the de-tabified tab */
-		strbuf_addchars(sb, ' ', 8-(width & 7));
+		strbuf_addchars(sb, ' ', log_tab_width - (width % log_tab_width));

 		/* Skip over the printed part .. */
 		linelen -= 1+tab-line;
@@ -1692,7 +1692,7 @@ static void pp_handle_indent(struct pretty_print_context *pp,
 			     const char *line, int linelen)
 {
 	strbuf_addchars(sb, ' ', indent);
-	if (pp->expand_tabs_in_log)
+	if (pp->expand_tabs_in_log && log_tab_width)
 		strbuf_add_tabexpand(sb, line, linelen);
 	else
 		strbuf_add(sb, line, linelen);
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 96233ca..9235a2e 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -114,8 +114,8 @@ EOF
 	test_cmp expect out
 '

-test_expect_failure !MINGW 'shortlog from non-git directory' '
-	git log HEAD >log &&
+test_expect_success !MINGW 'shortlog from non-git directory' '
+	git -c log.tabwidth=0 log HEAD >log &&
 	GIT_DIR=non-existing git shortlog -w <log >out &&
 	test_cmp expect out
 '
