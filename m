From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: [PATCH 1/1] Random documentation spelling fixes
Date: Thu, 21 Jan 2010 23:14:51 -0300
Message-ID: <1264126491-8273-2-git-send-email-vonbrand@inf.utfsm.cl>
References: <1264126491-8273-1-git-send-email-vonbrand@inf.utfsm.cl>
Cc: gitster@pobox.com, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 22 03:15:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY93T-0000XP-NB
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 03:15:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755743Ab0AVCPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 21:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755713Ab0AVCPM
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 21:15:12 -0500
Received: from inti.inf.utfsm.cl ([200.1.19.1]:52448 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755630Ab0AVCPI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 21:15:08 -0500
Received: from quelen.inf.utfsm.cl (quelen.inf.utfsm.cl [200.1.19.54])
	by inti.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id o0M2EkWt016083
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Jan 2010 23:14:46 -0300
Received: from laptop14.inf.utfsm.cl (pc-18-164-214-201.cm.vtr.net [201.214.164.18])
	by quelen.inf.utfsm.cl (8.14.3/8.14.3) with ESMTP id j075h1fA030758;
	Fri, 7 Jan 2005 02:43:01 -0300
Received: from laptop14.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop14.inf.utfsm.cl (8.14.3/8.14.3) with ESMTP id o0M2EvdY008314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Jan 2010 23:14:57 -0300
Received: (from vonbrand@localhost)
	by laptop14.inf.utfsm.cl (8.14.3/8.14.3/Submit) id o0M2EvGR008313;
	Thu, 21 Jan 2010 23:14:57 -0300
X-Mailer: git-send-email 1.6.6.1.383.g5a9f
In-Reply-To: <1264126491-8273-1-git-send-email-vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (inti.inf.utfsm.cl [0.0.0.0]); Thu, 21 Jan 2010 23:14:46 -0300 (CLST)
X-Spam-Status: No, score=-96.0 required=5.0 tests=AWL,RCVD_IN_PBL,RDNS_DYNAMIC,
	UNPARSEABLE_RELAY,URIBL_BLACK,URIBL_JP_SURBL,USER_IN_WHITELIST autolearn=no
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on inti.inf.utfsm.cl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137719>

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 Documentation/RelNotes-1.5.0.txt       |    2 +-
 Documentation/RelNotes-1.5.1.2.txt     |    2 +-
 Documentation/RelNotes-1.5.1.4.txt     |    2 +-
 Documentation/RelNotes-1.5.2.3.txt     |    2 +-
 Documentation/RelNotes-1.5.2.txt       |    2 +-
 Documentation/RelNotes-1.5.3.8.txt     |    2 +-
 Documentation/RelNotes-1.5.3.txt       |    6 +++---
 Documentation/RelNotes-1.5.4.2.txt     |    2 +-
 Documentation/RelNotes-1.5.5.3.txt     |    2 +-
 Documentation/RelNotes-1.5.6.txt       |    2 +-
 Documentation/RelNotes-1.6.0.txt       |    4 ++--
 Documentation/RelNotes-1.6.1.3.txt     |    2 +-
 Documentation/RelNotes-1.6.3.txt       |    2 +-
 Documentation/RelNotes-1.6.4.2.txt     |    2 +-
 Documentation/RelNotes-1.6.4.3.txt     |    2 +-
 Documentation/RelNotes-1.6.4.4.txt     |    2 +-
 Documentation/RelNotes-1.6.4.txt       |    2 +-
 Documentation/RelNotes-1.6.5.1.txt     |    2 +-
 Documentation/RelNotes-1.6.5.3.txt     |    4 ++--
 Documentation/RelNotes-1.6.5.4.txt     |    2 +-
 Documentation/RelNotes-1.6.5.txt       |    2 +-
 Documentation/RelNotes-1.6.6.txt       |    6 +++---
 Documentation/RelNotes-1.7.0.txt       |    2 +-
 Documentation/config.txt               |    2 +-
 Documentation/diff-format.txt          |    2 +-
 Documentation/git-bisect-lk2009.txt    |    2 +-
 Documentation/git-cvsimport.txt        |    4 ++--
 Documentation/git-cvsserver.txt        |    2 +-
 Documentation/git-fast-export.txt      |    2 +-
 Documentation/git-filter-branch.txt    |    2 +-
 Documentation/git-fsck.txt             |    4 ++--
 Documentation/git-http-backend.txt     |    4 ++--
 Documentation/git-imap-send.txt        |    4 ++--
 Documentation/git-index-pack.txt       |    2 +-
 Documentation/git-init.txt             |    2 +-
 Documentation/git-ls-files.txt         |    2 +-
 Documentation/git-merge-index.txt      |    2 +-
 Documentation/git-mktree.txt           |    2 +-
 Documentation/git-name-rev.txt         |    2 +-
 Documentation/git-pack-objects.txt     |    2 +-
 Documentation/git-patch-id.txt         |    2 +-
 Documentation/git-receive-pack.txt     |    2 +-
 Documentation/git-reflog.txt           |    4 ++--
 Documentation/git-remote-helpers.txt   |    4 ++--
 Documentation/git-remote.txt           |    2 +-
 Documentation/git-repack.txt           |    2 +-
 Documentation/git-replace.txt          |    4 ++--
 Documentation/git-rev-parse.txt        |   10 +++++-----
 Documentation/git-show-branch.txt      |    4 ++--
 Documentation/git-show-index.txt       |    2 +-
 Documentation/git-show-ref.txt         |    4 ++--
 Documentation/git-submodule.txt        |    6 +++---
 Documentation/git-svn.txt              |    8 ++++----
 Documentation/git-tag.txt              |    2 +-
 Documentation/git-unpack-file.txt      |    2 +-
 Documentation/git-update-index.txt     |    4 ++--
 Documentation/git-verify-tag.txt       |    2 +-
 Documentation/git.txt                  |   12 ++++++------
 Documentation/githooks.txt             |    2 +-
 Documentation/gitk.txt                 |    2 +-
 Documentation/gitmodules.txt           |    4 ++--
 Documentation/gitrepository-layout.txt |    2 +-
 Documentation/gittutorial-2.txt        |   16 ++++++++--------
 Documentation/pretty-formats.txt       |    4 ++--
 Documentation/user-manual.txt          |   14 +++++++-------
 65 files changed, 110 insertions(+), 110 deletions(-)

diff --git a/Documentation/RelNotes-1.5.0.txt b/Documentation/RelNotes-1.5.0.txt
index daf4bdb..a06782c 100644
--- a/Documentation/RelNotes-1.5.0.txt
+++ b/Documentation/RelNotes-1.5.0.txt
@@ -22,7 +22,7 @@ Specifically, the available options are:
    native protocol, since v1.4.2.  However, loose objects
    written in the new format cannot be read by git older than
    that version; people fetching from your repository using
-   older clients over dumb transports (e.g. http) using older
+   older clients over dumb transports (e.g. HTTP) using older
    versions of git will also be affected.
 
    To let git use the new loose object format, you have to
diff --git a/Documentation/RelNotes-1.5.1.2.txt b/Documentation/RelNotes-1.5.1.2.txt
index d884563..94a7594 100644
--- a/Documentation/RelNotes-1.5.1.2.txt
+++ b/Documentation/RelNotes-1.5.1.2.txt
@@ -6,7 +6,7 @@ Fixes since v1.5.1.1
 
 * Bugfixes
 
-  - "git clone" over http from a repository that has lost the
+  - "git clone" over HTTP from a repository that has lost the
     loose refs by running "git pack-refs" were broken (a code to
     deal with this was added to "git fetch" in v1.5.0, but it
     was missing from "git clone").
diff --git a/Documentation/RelNotes-1.5.1.4.txt b/Documentation/RelNotes-1.5.1.4.txt
index df2f66c..26f4f76 100644
--- a/Documentation/RelNotes-1.5.1.4.txt
+++ b/Documentation/RelNotes-1.5.1.4.txt
@@ -19,7 +19,7 @@ Fixes since v1.5.1.3
   - xdelta test program did not build correctly.
 
   - gitweb sometimes tried incorrectly to apply function to
-    decode utf8 twice, resulting in corrupt output.
+    decode UTF-8 twice, resulting in corrupt output.
 
   - "git blame -C" mishandled text at the end of a group of
     lines.
diff --git a/Documentation/RelNotes-1.5.2.3.txt b/Documentation/RelNotes-1.5.2.3.txt
index addb229..8835689 100644
--- a/Documentation/RelNotes-1.5.2.3.txt
+++ b/Documentation/RelNotes-1.5.2.3.txt
@@ -11,7 +11,7 @@ Fixes since v1.5.2.2
      represented in 32-bit.  The runtime code to validate such
      an index mishandled such an index for an empty pack.
 
-   - Commit walkers (most notably, fetch over http protocol)
+   - Commit walkers (most notably, fetch over HTTP protocol)
      tried to traverse commit objects contained in trees (aka
      subproject); they shouldn't.
 
diff --git a/Documentation/RelNotes-1.5.2.txt b/Documentation/RelNotes-1.5.2.txt
index e8328d0..491fa47 100644
--- a/Documentation/RelNotes-1.5.2.txt
+++ b/Documentation/RelNotes-1.5.2.txt
@@ -105,7 +105,7 @@ Updates since v1.5.1
   - "git archive" does not insist you to give --format parameter
     anymore; it defaults to "tar".
 
-  - "git cvsserver" can use backends other than sqlite.
+  - "git cvsserver" can use backends other than SQLite.
 
   - "gitview" (in contrib/ section) learned to better support
     "git-annotate".
diff --git a/Documentation/RelNotes-1.5.3.8.txt b/Documentation/RelNotes-1.5.3.8.txt
index 0e3ff58..a20f443 100644
--- a/Documentation/RelNotes-1.5.3.8.txt
+++ b/Documentation/RelNotes-1.5.3.8.txt
@@ -11,7 +11,7 @@ Fixes since v1.5.3.7
 
  * git-svn fix to tone down a needlessly alarming warning message.
 
- * git-clone did not correctly report errors while fetching over http.
+ * git-clone did not correctly report errors while fetching over HTTP.
 
  * git-send-email added redundant Message-Id: header to the outgoing
    e-mail when the patch text already had one.
diff --git a/Documentation/RelNotes-1.5.3.txt b/Documentation/RelNotes-1.5.3.txt
index 0668d3c..b9b9578 100644
--- a/Documentation/RelNotes-1.5.3.txt
+++ b/Documentation/RelNotes-1.5.3.txt
@@ -4,7 +4,7 @@ GIT v1.5.3 Release Notes
 Updates since v1.5.2
 --------------------
 
-* The commit walkers other than http are officially deprecated,
+* The commit walkers other than HTTP are officially deprecated,
   but still supported for now.
 
 * The submodule support has Porcelain layer.
@@ -270,7 +270,7 @@ Updates since v1.5.2
   - "gitview" (in contrib) has a better blame interface.
 
   - "git log" and friends did not handle a commit log message
-    that is larger than 16kB; they do now.
+    that is larger than 16KiB; they do now.
 
   - "--pretty=oneline" output format for "git log" and friends
     deals with "malformed" commit log messages that have more
@@ -285,7 +285,7 @@ Updates since v1.5.2
     rpm have been removed as well.
 
   - "git mailinfo" (hence "am") now tries to see if the message
-    is in utf-8 first, instead of assuming iso-8859-1, if
+    is in UTF-8 first, instead of assuming iso-8859-1, if
     incoming e-mail does not say what encoding it is in.
 
 * Builds
diff --git a/Documentation/RelNotes-1.5.4.2.txt b/Documentation/RelNotes-1.5.4.2.txt
index 21d0df5..e69a054 100644
--- a/Documentation/RelNotes-1.5.4.2.txt
+++ b/Documentation/RelNotes-1.5.4.2.txt
@@ -40,4 +40,4 @@ Fixes since v1.5.4
  * Customized color specification was parsed incorrectly when
    numeric color values are used.  This was fixed in 1.5.4.1.
 
- * http transport misbehaved when linked with curl-gnutls.
+ * HTTP transport misbehaved when linked with curl-gnutls.
diff --git a/Documentation/RelNotes-1.5.5.3.txt b/Documentation/RelNotes-1.5.5.3.txt
index f22f98b..d811287 100644
--- a/Documentation/RelNotes-1.5.5.3.txt
+++ b/Documentation/RelNotes-1.5.5.3.txt
@@ -4,7 +4,7 @@ GIT v1.5.5.3 Release Notes
 Fixes since v1.5.5.2
 --------------------
 
- * "git send-email --compose" did not notice that non-ascii contents
+ * "git send-email --compose" did not notice that non-ASCII contents
    needed some MIME magic.
 
  * "git fast-export" did not export octopus merges correctly.
diff --git a/Documentation/RelNotes-1.5.6.txt b/Documentation/RelNotes-1.5.6.txt
index e143d8d..0614225 100644
--- a/Documentation/RelNotes-1.5.6.txt
+++ b/Documentation/RelNotes-1.5.6.txt
@@ -25,7 +25,7 @@ Updates since v1.5.5
 * Many freestanding documentation pages have been converted and made
   available to "git help" (aka "man git<something>") as section 7 of
   the manual pages. This means bookmarks to some HTML documentation
-  files may need to be updated (eg "tutorial.html" became
+  files may need to be updated (eg, "tutorial.html" became
   "gittutorial.html").
 
 (performance)
diff --git a/Documentation/RelNotes-1.6.0.txt b/Documentation/RelNotes-1.6.0.txt
index de7ef16..a6c9227 100644
--- a/Documentation/RelNotes-1.6.0.txt
+++ b/Documentation/RelNotes-1.6.0.txt
@@ -68,7 +68,7 @@ Updates since v1.5.6
 * Sample hook scripts shipped in templates/ are now suffixed with
   *.sample.
 
-* perl's in-place edit (-i) does not work well without backup files on Windows;
+* Perl's in-place edit (-i) does not work well without backup files on Windows;
   some tests are rewritten to cope with this.
 
 (documentation)
@@ -178,7 +178,7 @@ Updates since v1.5.6
 * git-diff --check now checks leftover merge conflict markers.
 
 * "git-diff -p" learned to grab a better hunk header lines in
-  BibTex, Pascal/Delphi, and Ruby files and also pays attention to
+  BibTeX, Pascal/Delphi, and Ruby files and also pays attention to
   chapter and part boundary in TeX documents.
 
 * When remote side used to have branch 'foo' and git-fetch finds that now
diff --git a/Documentation/RelNotes-1.6.1.3.txt b/Documentation/RelNotes-1.6.1.3.txt
index 6f0bde1..7b2f345 100644
--- a/Documentation/RelNotes-1.6.1.3.txt
+++ b/Documentation/RelNotes-1.6.1.3.txt
@@ -23,7 +23,7 @@ Fixes since v1.6.1.2
 * "git merge -s octopus" with many potential merge bases did not
   work correctly.
 
-* RPM binary package installed the html manpages in a wrong place.
+* RPM binary package installed the HTML manpages in a wrong place.
 
 Also includes minor documentation fixes and updates.
 
diff --git a/Documentation/RelNotes-1.6.3.txt b/Documentation/RelNotes-1.6.3.txt
index 418c685..5550aa3 100644
--- a/Documentation/RelNotes-1.6.3.txt
+++ b/Documentation/RelNotes-1.6.3.txt
@@ -159,7 +159,7 @@ Updates since v1.6.2
   docbook-xsl package.  See comments in Documentation/Makefile for details.
 
 * Support for building and testing a subset of git on a system without a
-  working perl has been improved.
+  working Perl has been improved.
 
 
 Fixes since v1.6.2
diff --git a/Documentation/RelNotes-1.6.4.2.txt b/Documentation/RelNotes-1.6.4.2.txt
index c11ec01..9f044a1 100644
--- a/Documentation/RelNotes-1.6.4.2.txt
+++ b/Documentation/RelNotes-1.6.4.2.txt
@@ -20,7 +20,7 @@ Fixes since v1.6.4.1
 * "git clean -d -f" happily descended into a subdirectory that is managed by a
   separate git repository.  It now requires two -f options for safety.
 
-* "git fetch/push" over http transports had two rather grave bugs.
+* "git fetch/push" over HTTP transports had two rather grave bugs.
 
 * "git format-patch --cover-letter" did not prepare the cover letter file
   for use with non-ASCII strings when there are the series contributors with
diff --git a/Documentation/RelNotes-1.6.4.3.txt b/Documentation/RelNotes-1.6.4.3.txt
index 4f29bab..5643e65 100644
--- a/Documentation/RelNotes-1.6.4.3.txt
+++ b/Documentation/RelNotes-1.6.4.3.txt
@@ -11,7 +11,7 @@ Fixes since v1.6.4.2
   been deprecated.
 
 * "git fetch" and "git clone" had an extra sanity check to verify the
-  presense of the corresponding *.pack file before downloading *.idx
+  presence of the corresponding *.pack file before downloading *.idx
   file by issuing a HEAD request.  Github server however sometimes
   gave 500 (Internal server error) response to HEAD even if a GET
   request for *.pack file to the same URL would have succeeded, and broke
diff --git a/Documentation/RelNotes-1.6.4.4.txt b/Documentation/RelNotes-1.6.4.4.txt
index 0ead45f..54a9e4c 100644
--- a/Documentation/RelNotes-1.6.4.4.txt
+++ b/Documentation/RelNotes-1.6.4.4.txt
@@ -6,7 +6,7 @@ Fixes since v1.6.4.4
 
 * The workaround for Github server that sometimes gave 500 (Internal server
   error) response to HEAD requests in 1.6.4.3 introduced a regression that
-  caused re-fetching projects over http to segfault in certain cases due
+  caused re-fetching projects over HTTP to segfault in certain cases due
   to uninitialized pointer being freed.
 
 * "git pull" on an unborn branch used to consider anything in the work
diff --git a/Documentation/RelNotes-1.6.4.txt b/Documentation/RelNotes-1.6.4.txt
index 7a90441..15e06b4 100644
--- a/Documentation/RelNotes-1.6.4.txt
+++ b/Documentation/RelNotes-1.6.4.txt
@@ -76,7 +76,7 @@ Updates since v1.6.3
  * "git grep" learned -p option to show the location of the match using the
    same context hunk marker "git diff" uses.
 
- * https transport can optionally be told that the used client
+ * HTTPS transport can optionally be told that the used client
    certificate is password protected, in which case it asks the
    password only once.
 
diff --git a/Documentation/RelNotes-1.6.5.1.txt b/Documentation/RelNotes-1.6.5.1.txt
index 309ba18..77094e3 100644
--- a/Documentation/RelNotes-1.6.5.1.txt
+++ b/Documentation/RelNotes-1.6.5.1.txt
@@ -15,6 +15,6 @@ Fixes since v1.6.5
  * "git clone -b branch" gave a wrong commit object name to post-checkout
    hook.
 
- * "git pull" over http did not work on msys.
+ * "git pull" over HTTP did not work on msys.
 
 Other minor documentation updates are included.
diff --git a/Documentation/RelNotes-1.6.5.3.txt b/Documentation/RelNotes-1.6.5.3.txt
index b2fad1b..c414eaf 100644
--- a/Documentation/RelNotes-1.6.5.3.txt
+++ b/Documentation/RelNotes-1.6.5.3.txt
@@ -41,7 +41,7 @@ Fixes since v1.6.5.2
  * "git ls-files -i" was supposed to be inverse of "git ls-files" without -i
    with respect to exclude patterns, but it was broken since 1.6.5.2.
 
- * "git ls-remote" outside of a git repository over http was broken.
+ * "git ls-remote" outside of a git repository over HTTP was broken.
 
  * "git rebase -i" gave bogus error message when the command word was
    misspelled.
@@ -54,7 +54,7 @@ Fixes since v1.6.5.2
 
  * Release notes spelled the package name with incorrect capitalization.
 
- * "gitweb" did not escape non-ascii characters correctly in the URL.
+ * "gitweb" did not escape non-ASCII characters correctly in the URL.
 
  * "gitweb" showed "patch" link even for merge commits.
 
diff --git a/Documentation/RelNotes-1.6.5.4.txt b/Documentation/RelNotes-1.6.5.4.txt
index e42f8b2..d3a2a3e 100644
--- a/Documentation/RelNotes-1.6.5.4.txt
+++ b/Documentation/RelNotes-1.6.5.4.txt
@@ -26,7 +26,7 @@ Fixes since v1.6.5.3
    future versions, but not in this release,
 
  * "git merge -m <message> <branch>..." added the standard merge message
-   on its own after user-supplied message, which should have overrided the
+   on its own after user-supplied message, which should have overridden the
    standard one.
 
 Other minor documentation updates are included.
diff --git a/Documentation/RelNotes-1.6.5.txt b/Documentation/RelNotes-1.6.5.txt
index ee141c1..e3191e6 100644
--- a/Documentation/RelNotes-1.6.5.txt
+++ b/Documentation/RelNotes-1.6.5.txt
@@ -60,7 +60,7 @@ Updates since v1.6.4
  * The "git" main binary used to link with libcurl, which then dragged
    in a large number of external libraries.  When using basic plumbing
    commands in scripts, this unnecessarily slowed things down.  We now
-   implement http/https/ftp transfer as a separate executable as we
+   implement HTTP/HTTPS/ftp transfer as a separate executable as we
    used to.
 
  * "git clone" run locally hardlinks or copies the files in .git/ to
diff --git a/Documentation/RelNotes-1.6.6.txt b/Documentation/RelNotes-1.6.6.txt
index 04e205c..52509ec 100644
--- a/Documentation/RelNotes-1.6.6.txt
+++ b/Documentation/RelNotes-1.6.6.txt
@@ -29,7 +29,7 @@ or adjust to the new behaviour, on the day their sysadmin decides to install
 the new version of git.  When we switched from "git-foo" to "git foo" in
 1.6.0, even though the change had been advertised and the transition
 guide had been provided for a very long time, the users procrastinated
-during the entire transtion period, and ended up panicking on the day
+during the entire transition period, and ended up panicking on the day
 their sysadmins updated their git installation.  We are trying to avoid
 repeating that unpleasantness in the 1.7.0 release.
 
@@ -94,7 +94,7 @@ users will fare this time.
  * "git diff" traditionally treated various "ignore whitespace" options
    only as a way to filter the patch output.  "git diff --exit-code -b"
    exited with non-zero status even if all changes were about changing the
-   ammount of whitespace and nothing else.  and "git diff -b" showed the
+   amount of whitespace and nothing else.  and "git diff -b" showed the
    "diff --git" header line for such a change without patch text.
 
    In 1.7.0, the "ignore whitespaces" will affect the semantics of the
@@ -119,7 +119,7 @@ Updates since v1.6.5
 
  * various git-svn updates.
 
- * "git fetch" over http learned a new mode that is different from the
+ * "git fetch" over HTTP learned a new mode that is different from the
    traditional "dumb commit walker".
 
 (portability)
diff --git a/Documentation/RelNotes-1.7.0.txt b/Documentation/RelNotes-1.7.0.txt
index a3d0395..bb13d96 100644
--- a/Documentation/RelNotes-1.7.0.txt
+++ b/Documentation/RelNotes-1.7.0.txt
@@ -30,7 +30,7 @@ Notes on behaviour change
  * "git diff" traditionally treated various "ignore whitespace" options
    only as a way to filter the patch output.  "git diff --exit-code -b"
    exited with non-zero status even if all changes were about changing the
-   ammount of whitespace and nothing else.  and "git diff -b" showed the
+   amount of whitespace and nothing else.  and "git diff -b" showed the
    "diff --git" header line for such a change without patch text.
 
    In this release, the "ignore whitespaces" options affect the semantics
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8dcb191..191585b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1333,7 +1333,7 @@ pack.threads::
 	warning. This is meant to reduce packing time on multiprocessor
 	machines. The required amount of memory for the delta search window
 	is however multiplied by the number of threads.
-	Specifying 0 will cause git to auto-detect the number of CPU's
+	Specifying 0 will cause git to auto-detect the number of CPUs
 	and set the number of threads accordingly.
 
 pack.indexVersion::
diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index b717124..15c7e79 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -19,7 +19,7 @@ git-diff-tree [-r] <tree-ish-1> <tree-ish-2> [<pattern>...]::
 git-diff-files [<pattern>...]::
         compares the index and the files on the filesystem.
 
-The "git-diff-tree" command begins its ouput by printing the hash of
+The "git-diff-tree" command begins its output by printing the hash of
 what is being compared. After that, all the commands print one output
 line per changed file.
 
diff --git a/Documentation/git-bisect-lk2009.txt b/Documentation/git-bisect-lk2009.txt
index 6b7b2e5..eb35f2f 100644
--- a/Documentation/git-bisect-lk2009.txt
+++ b/Documentation/git-bisect-lk2009.txt
@@ -1320,7 +1320,7 @@ So git bisect is unconditional goodness - and feel free to quote that
 ;-)
 _____________
 
-Acknowledgements
+Acknowledgments
 ----------------
 
 Many thanks to Junio Hamano for his help in reviewing this paper, for
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index ddfcb3d..09f79b3 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -172,7 +172,7 @@ ISSUES
 ------
 Problems related to timestamps:
 
- * If timestamps of commits in the cvs repository are not stable enough
+ * If timestamps of commits in the CVS repository are not stable enough
    to be used for ordering commits changes may show up in the wrong
    order.
  * If any files were ever "cvs import"ed more than once (e.g., import of
@@ -185,7 +185,7 @@ Problems related to branches:
 
  * Branches on which no commits have been made are not imported.
  * All files from the branching point are added to a branch even if
-   never added in cvs.
+   never added in CVS.
  * This applies to files added to the source branch *after* a daughter
    branch was created: if previously no commit was made on the daughter
    branch they will erroneously be added to the daughter branch in git.
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index dbb053e..2bf0b3f 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -337,7 +337,7 @@ CRLF Line Ending Conversions
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 By default the server leaves the '-k' mode blank for all files,
-which causes the cvs client to treat them as a text files, subject
+which causes the CVS client to treat them as a text files, subject
 to crlf conversion on some platforms.
 
 You can make the server use `crlf` attributes to set the '-k' modes
diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index c24e14b..98ec6b5 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -37,7 +37,7 @@ unsigned, with 'verbatim', they will be silently exported
 and with 'warn', they will be exported, but you will see a warning.
 
 --tag-of-filtered-object=(abort|drop|rewrite)::
-	Specify how to handle tags whose tagged objectis filtered out.
+	Specify how to handle tags whose tagged object is filtered out.
 	Since revisions and files to export can be limited by path,
 	tagged objects may be filtered completely.
 +
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index cfaba2a..e2cff09 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -21,7 +21,7 @@ DESCRIPTION
 Lets you rewrite git revision history by rewriting the branches mentioned
 in the <rev-list options>, applying custom filters on each revision.
 Those filters can modify each tree (e.g. removing a file or running
-a perl rewrite on all files) or information about each commit.
+a Perl rewrite on all files) or information about each commit.
 Otherwise, all information (including original commit times or merge
 information) will be preserved.
 
diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 3ad48a6..a55d905 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -22,7 +22,7 @@ OPTIONS
 	An object to treat as the head of an unreachability trace.
 +
 If no objects are given, 'git fsck' defaults to using the
-index file, all SHA1 references in .git/refs/*, and all reflogs (unless
+index file, all SHA-1 references in .git/refs/*, and all reflogs (unless
 --no-reflogs is given) as heads.
 
 --unreachable::
@@ -72,7 +72,7 @@ index file, all SHA1 references in .git/refs/*, and all reflogs (unless
 	a blob, the contents are written into the file, rather than
 	its object name.
 
-It tests SHA1 and general object sanity, and it does full tracking of
+It tests SHA-1 and general object sanity, and it does full tracking of
 the resulting reachability and everything else. It prints out any
 corruption it finds (missing or bad objects), and if you use the
 '--unreachable' flag it will also print out objects that exist but
diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index 07931c6..cfc1c67 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -14,7 +14,7 @@ DESCRIPTION
 -----------
 A simple CGI program to serve the contents of a Git repository to Git
 clients accessing the repository over http:// and https:// protocols.
-The program supports clients fetching using both the smart HTTP protcol
+The program supports clients fetching using both the smart HTTP protocol
 and the backwards-compatible dumb HTTP protocol, as well as clients
 pushing using the smart HTTP protocol.
 
@@ -103,7 +103,7 @@ directive around the repository, or one of its parent directories:
 </Location>
 ----------------------------------------------------------------
 +
-To serve gitweb at the same url, use a ScriptAliasMatch to only
+To serve gitweb at the same URL, use a ScriptAliasMatch to only
 those URLs that 'git http-backend' can handle, and forward the
 rest to gitweb:
 +
diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 57db955..059bbd0 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -65,8 +65,8 @@ imap.sslverify::
 	imap.tunnel is set.
 
 imap.preformattedHTML::
-	A boolean to enable/disable the use of html encoding when sending
-	a patch.  An html encoded patch will be bracketed with <pre>
+	A boolean to enable/disable the use of HTML encoding when sending
+	a patch.  An HTML encoded patch will be bracketed with <pre>
 	and have a content type of text/html.  Ironically, enabling this
 	option causes Thunderbird to send the patch as a plain/text,
 	format=fixed email.  Default is `false`.
diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 65a301b..255863d 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -83,7 +83,7 @@ Note
 ----
 
 Once the index has been created, the list of object names is sorted
-and the SHA1 hash of that list is printed to stdout. If --stdin was
+and the SHA-1 hash of that list is printed to stdout. If --stdin was
 also used then this is prefixed by either "pack\t", or "keep\t" if a
 new .keep file was successfully created. This is useful to remove a
 .keep file used as a lock to prevent the race with 'git repack'
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 7ee102d..e447fb2 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -92,7 +92,7 @@ If the `$GIT_DIR` environment variable is set then it specifies a path
 to use instead of `./.git` for the base of the repository.
 
 If the object storage directory is specified via the `$GIT_OBJECT_DIRECTORY`
-environment variable then the sha1 directories are created underneath -
+environment variable then the SHA-1 directories are created underneath -
 otherwise the default `$GIT_DIR/objects` directory is used.
 
 Running 'git init' in an existing repository is safe. It will not overwrite
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index af409bf..39a6f8d 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -149,7 +149,7 @@ which case it outputs:
 'git ls-files --unmerged' and 'git ls-files --stage' can be used to examine
 detailed information on unmerged paths.
 
-For an unmerged path, instead of recording a single mode/SHA1 pair,
+For an unmerged path, instead of recording a single mode/SHA-1 pair,
 the index records up to three such pairs; one from tree O in stage
 1, A in stage 2, and B in stage 3.  This information can be used by
 the user (or the porcelain) to see what should eventually be recorded at the
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index 4d266de..fce6f8f 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 This looks up the <file>(s) in the index and, if there are any merge
-entries, passes the SHA1 hash for those files as arguments 1, 2, 3 (empty
+entries, passes the SHA-1 hash for those files as arguments 1, 2, 3 (empty
 argument if no file), and <file> as argument 4.  File modes for the three
 files are passed as arguments 5, 6 and 7.
 
diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
index 81e3326..d222fd8 100644
--- a/Documentation/git-mktree.txt
+++ b/Documentation/git-mktree.txt
@@ -24,7 +24,7 @@ OPTIONS
 
 --missing::
 	Allow missing objects.  The default behaviour (without this option)
-	is to verify that each tree entry's sha1 identifies an existing
+	is to verify that each tree entry's SHA-1 identifies an existing
 	object.  This option has no effect on the treatment of gitlink entries
 	(aka "submodules") which are always allowed to be missing.
 
diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index 2108237..063b69d 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -31,7 +31,7 @@ OPTIONS
 	List all commits reachable from all refs
 
 --stdin::
-	Read from stdin, append "(<rev_name>)" to all sha1's of nameable
+	Read from stdin, append "(<rev_name>)" to all SHA-1's of nameable
 	commits, and pass to stdout
 
 --name-only::
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 097a147..fe825a2 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -196,7 +196,7 @@ base-name::
 	This is meant to reduce packing time on multiprocessor machines.
 	The required amount of memory for the delta search window is
 	however multiplied by the number of threads.
-	Specifying 0 will cause git to auto-detect the number of CPU's
+	Specifying 0 will cause git to auto-detect the number of CPUs
 	and set the number of threads accordingly.
 
 --index-version=<version>[,<offset>]::
diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
index 4dae139..68904e5 100644
--- a/Documentation/git-patch-id.txt
+++ b/Documentation/git-patch-id.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-A "patch ID" is nothing but a SHA1 of the diff associated with a patch, with
+A "patch ID" is nothing but a SHA-1 of the diff associated with a patch, with
 whitespace and line numbers ignored.  As such, it's "reasonably stable", but at
 the same time also reasonably unique, i.e., two patches that have the same "patch
 ID" are almost guaranteed to be the same thing.
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 2790eeb..71b0799 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -20,7 +20,7 @@ The UI for the protocol is on the 'git send-pack' side, and the
 program pair is meant to be used to push updates to remote
 repository.  For pull operations, see linkgit:git-fetch-pack[1].
 
-The command allows for creation and fast-forwarding of sha1 refs
+The command allows for creation and fast-forwarding of SHA-1 refs
 (heads/tags) on the remote end (strictly speaking, it is the
 local end 'git-receive-pack' runs, but to the user who is sitting at
 the send-pack end, it is updating the remote.  Confused?)
diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 802bd57..f7d4c6a 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -81,12 +81,12 @@ them.
 	Instead of listing <refs> explicitly, prune all refs.
 
 --updateref::
-	Update the ref with the sha1 of the top reflog entry (i.e.
+	Update the ref with the SHA-1 of the top reflog entry (i.e.
 	<ref>@\{0\}) after expiring or deleting.
 
 --rewrite::
 	While expiring or deleting, adjust each reflog entry to ensure
-	that the `old` sha1 field points to the `new` sha1 field of the
+	that the `old` SHA-1 field points to the `new` SHA-1 field of the
 	previous entry.
 
 --verbose::
diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 4685a89..29d8d5f 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -25,14 +25,14 @@ Commands are given by the caller on the helper's standard input, one per line.
 
 'capabilities'::
 	Lists the capabilities of the helper, one per line, ending
-	with a blank line. Each capability may be preceeded with '*'.
+	with a blank line. Each capability may be preceded with '*'.
 	This marks them mandatory for git version using the remote
 	helper to understand (unknown mandatory capability is fatal
 	error).
 
 'list'::
 	Lists the refs, one per line, in the format "<value> <name>
-	[<attr> ...]". The value may be a hex sha1 hash, "@<dest>" for
+	[<attr> ...]". The value may be a hex SHA-1 hash, "@<dest>" for
 	a symref, or "?" to indicate that the helper could not get the
 	value of the ref. A space-separated list of attributes follows
 	the name; unrecognized attributes are ignored. After the
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index b03ccaa..d57c69c 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -29,7 +29,7 @@ OPTIONS
 
 -v::
 --verbose::
-	Be a little more verbose and show remote url after name.
+	Be a little more verbose and show remote URL after name.
 	NOTE: This must be placed between `remote` and `subcommand`.
 
 
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 538895c..ce1f102 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -114,7 +114,7 @@ smaller packs, but the generated packs are incompatible with
 versions of git older than (and including) v1.4.3; do not set
 the variable in a repository that older version of git needs to
 be able to read (this includes repositories from which packs can
-be copied out over http or rsync, and people who obtained packs
+be copied out over HTTP or rsync, and people who obtained packs
 that way can try to use older git with it).
 
 
diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index fde2092..607eddc 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -16,8 +16,8 @@ DESCRIPTION
 -----------
 Adds a 'replace' reference in `.git/refs/replace/`
 
-The name of the 'replace' reference is the SHA1 of the object that is
-replaced. The content of the 'replace' reference is the SHA1 of the
+The name of the 'replace' reference is the SHA-1 of the object that is
+replaced. The content of the 'replace' reference is the SHA-1 of the
 replacement object.
 
 Unless `-f` is given, the 'replace' reference must not yet exist in
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index d375f1a..6bb760c 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -33,7 +33,7 @@ OPTIONS
 --stop-at-non-option::
 	Only meaningful in `--parseopt` mode.  Lets the option parser stop at
 	the first non-option argument.  This can be used to parse sub-commands
-	that take options themself.
+	that take options themselves.
 
 --sq-quote::
 	Use 'git rev-parse' in shell quoting mode (see SQ-QUOTE
@@ -83,7 +83,7 @@ OPTIONS
 	one.
 
 --symbolic::
-	Usually the object names are output in SHA1 form (with
+	Usually the object names are output in SHA-1 form (with
 	possible '{caret}' prefix); this option makes them output in a
 	form as close to the original input as possible.
 
@@ -141,7 +141,7 @@ OPTIONS
 
 --short::
 --short=number::
-	Instead of outputting the full SHA1 values of object names try to
+	Instead of outputting the full SHA-1 values of object names try to
 	abbreviate them to a shorter unique name. When no length is specified
 	7 is used. The minimum length is 4.
 
@@ -163,12 +163,12 @@ SPECIFYING REVISIONS
 --------------------
 
 A revision parameter typically, but not necessarily, names a
-commit object.  They use what is called an 'extended SHA1'
+commit object.  They use what is called an 'extended SHA-1'
 syntax.  Here are various ways to spell object names.  The
 ones listed near the end of this list are to name trees and
 blobs contained in a commit.
 
-* The full SHA1 object name (40-byte hexadecimal string), or
+* The full SHA-1 object name (40-byte hexadecimal string), or
   a substring of such that is unique within the repository.
   E.g. dae86e1950b1277e545cee180551750029cfe735 and dae86e both
   name the same commit object if there are no other object in
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 7343361..59e882b 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -32,7 +32,7 @@ no <rev> nor <glob> is given on the command line.
 OPTIONS
 -------
 <rev>::
-	Arbitrary extended SHA1 expression (see linkgit:git-rev-parse[1])
+	Arbitrary extended SHA-1 expression (see linkgit:git-rev-parse[1])
 	that typically names a branch head or a tag.
 
 <glob>::
@@ -141,7 +141,7 @@ displayed, indented N places.  If a commit is on the I-th
 branch, the I-th indentation character shows a `+` sign;
 otherwise it shows a space.  Merge commits are denoted by
 a `-` sign.  Each commit shows a short name that
-can be used as an extended SHA1 to name that commit.
+can be used as an extended SHA-1 to name that commit.
 
 The following example shows three branches, "master", "fixes"
 and "mhf":
diff --git a/Documentation/git-show-index.txt b/Documentation/git-show-index.txt
index 8382fbe..2e97ae9 100644
--- a/Documentation/git-show-index.txt
+++ b/Documentation/git-show-index.txt
@@ -18,7 +18,7 @@ Reads given idx file for packed git archive created with
 
 The information it outputs is subset of what you can get from
 'git verify-pack -v'; this command only shows the packfile
-offset and SHA1 of each object.
+offset and SHA-1 of each object.
 
 
 Author
diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index df17d49..fc91b6a 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -50,8 +50,8 @@ OPTIONS
 -s::
 --hash[=<n>]::
 
-	Only show the SHA1 hash, not the reference name. When combined with
-	--dereference the dereferenced tag will still be shown after the SHA1.
+	Only show the SHA-1 hash, not the reference name. When combined with
+	--dereference the dereferenced tag will still be shown after the SHA-1.
 
 --verify::
 
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 63aa694..d7ed771 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -110,7 +110,7 @@ submodules, and show their status as well.
 
 init::
 	Initialize the submodules, i.e. register each submodule name
-	and url found in .gitmodules into .git/config.
+	and URL found in .gitmodules into .git/config.
 	The key used in .git/config is `submodule.$name.url`.
 	This command does not alter existing information in .git/config.
 	You can then customize the submodule clone URLs in .git/config
@@ -245,9 +245,9 @@ for linkgit:git-clone[1]'s --reference and --shared options carefully.
 FILES
 -----
 When initializing submodules, a .gitmodules file in the top-level directory
-of the containing repository is used to find the url of each submodule.
+of the containing repository is used to find the URL of each submodule.
 This file should be formatted in the same way as `$GIT_DIR/config`. The key
-to each submodule url is "submodule.$name.url".  See linkgit:gitmodules[5]
+to each submodule URL is "submodule.$name.url".  See linkgit:gitmodules[5]
 for details.
 
 
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 4cdca0d..06ffa03 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -46,7 +46,7 @@ COMMANDS
 --stdlayout;;
 	These are optional command-line options for init.  Each of
 	these flags can point to a relative repository path
-	(--tags=project/tags) or a full url
+	(--tags=project/tags) or a full URL
 	(--tags=https://foo.org/project/tags).
 	You can specify more than one --tags and/or --branches options, in case
 	your Subversion repository places tags or branches under multiple paths.
@@ -269,7 +269,7 @@ New features:
 +
 --
 --show-commit;;
-	shows the git commit sha1, as well
+	shows the git commit SHA-1, as well
 --oneline;;
 	our version of --pretty=oneline
 --
@@ -443,7 +443,7 @@ and lost.
 	Only used with the 'set-tree' command.
 +
 Read a list of commits from stdin and commit them in reverse
-order.  Only the leading sha1 is read from each line, so
+order.  Only the leading SHA-1 is read from each line, so
 'git rev-list --pretty=oneline' output can be used.
 
 --rmdir::
@@ -545,7 +545,7 @@ For 'rebase', display the local branch associated with the upstream svn
 repository associated with the current branch and the URL of svn
 repository that will be fetched from.
 +
-For 'branch' and 'tag', display the urls that will be used for copying when
+For 'branch' and 'tag', display the URLs that will be used for copying when
 creating the branch or tag.
 
 
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 31c78a8..bfc37c4 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -31,7 +31,7 @@ in the tag message.
 If `-m <msg>` or `-F <file>` is given and `-a`, `-s`, and `-u <key-id>`
 are absent, `-a` is implied.
 
-Otherwise just the SHA1 object name of the commit object is
+Otherwise just the SHA-1 object name of the commit object is
 written (i.e. a lightweight tag).
 
 A GnuPG signed tag object will be created when `-s` or `-u
diff --git a/Documentation/git-unpack-file.txt b/Documentation/git-unpack-file.txt
index 995db9f..799e5b4 100644
--- a/Documentation/git-unpack-file.txt
+++ b/Documentation/git-unpack-file.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Creates a file holding the contents of the blob specified by sha1. It
+Creates a file holding the contents of the blob specified by SHA-1. It
 returns the name of the temporary file in the following format:
 	.merge_file_XXXXX
 
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 68dc187..f9683eb 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -161,7 +161,7 @@ you will need to handle the situation manually.
 
 Using --refresh
 ---------------
-'--refresh' does not calculate a new sha1 file or bring the index
+'--refresh' does not calculate a new SHA-1 file or bring the index
 up-to-date for mode/content changes. But what it *does* do is to
 "re-match" the stat information of a file with the index, so that you
 can refresh the index for a file that hasn't been changed but where
@@ -237,7 +237,7 @@ $ git update-index --index-info
 ------------
 
 The first line of the input feeds 0 as the mode to remove the
-path; the SHA1 does not matter as long as it is well formatted.
+path; the SHA-1 does not matter as long as it is well formatted.
 Then the second and third line feeds stage 1 and stage 2 entries
 for that path.  After the above, we would end up with this:
 
diff --git a/Documentation/git-verify-tag.txt b/Documentation/git-verify-tag.txt
index dada212..9edb338 100644
--- a/Documentation/git-verify-tag.txt
+++ b/Documentation/git-verify-tag.txt
@@ -16,7 +16,7 @@ Validates the gpg signature created by 'git tag'.
 OPTIONS
 -------
 <tag>...::
-	SHA1 identifiers of git tag objects.
+	SHA-1 identifiers of git tag objects.
 
 Author
 ------
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 8c5f5b0..72ddb50 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -486,7 +486,7 @@ git so take care if using Cogito etc.
 
 'GIT_OBJECT_DIRECTORY'::
 	If the object storage directory is specified via this
-	environment variable then the sha1 directories are created
+	environment variable then the SHA-1 directories are created
 	underneath - otherwise the default `$GIT_DIR/objects`
 	directory is used.
 
@@ -548,7 +548,7 @@ where:
 
 	<old|new>-file:: are files GIT_EXTERNAL_DIFF can use to read the
                          contents of <old|new>,
-	<old|new>-hex:: are the 40-hexdigit SHA1 hashes,
+	<old|new>-hex:: are the 40-hexdigit SHA-1 hashes,
 	<old|new>-mode:: are the octal representation of the file modes.
 
 +
@@ -638,7 +638,7 @@ The commit, equivalent to what other systems call a "changeset" or
 represents an immediately preceding step.  Commits with more than one
 parent represent merges of independent lines of development.
 
-All objects are named by the SHA1 hash of their contents, normally
+All objects are named by the SHA-1 hash of their contents, normally
 written as a string of 40 hex digits.  Such names are globally unique.
 The entire history leading up to a commit can be vouched for by signing
 just that commit.  A fourth object type, the tag, is provided for this
@@ -648,9 +648,9 @@ When first created, objects are stored in individual files, but for
 efficiency may later be compressed together into "pack files".
 
 Named pointers called refs mark interesting points in history.  A ref
-may contain the SHA1 name of an object or the name of another ref.  Refs
-with names beginning `ref/head/` contain the SHA1 name of the most
-recent commit (or "head") of a branch under development.  SHA1 names of
+may contain the SHA-1 name of an object or the name of another ref.  Refs
+with names beginning `ref/head/` contain the SHA-1 name of the most
+recent commit (or "head") of a branch under development.  SHA-1 names of
 tags of interest are stored under `ref/tags/`.  A special ref named
 `HEAD` contains the name of the currently checked-out branch.
 
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 87e2c03..f6e7061 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -99,7 +99,7 @@ given); `template` (if a `-t` option was given or the
 configuration option `commit.template` is set); `merge` (if the
 commit is a merge or a `.git/MERGE_MSG` file exists); `squash`
 (if a `.git/SQUASH_MSG` file exists); or `commit`, followed by
-a commit SHA1 (if a `-c`, `-C` or `\--amend` option was given).
+a commit SHA-1 (if a `-c`, `-C` or `\--amend` option was given).
 
 If the exit status is non-zero, 'git commit' will abort.
 
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 99baa24..713022d 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -15,7 +15,7 @@ Displays changes in a repository or a selected set of commits. This includes
 visualizing the commit graph, showing information related to each commit, and
 the files in the trees of each revision.
 
-Historically, gitk was the first repository browser. It's written in tcl/tk
+Historically, gitk was the first repository browser. It's written in Tcl/Tk
 and started off in a separate repository but was later merged into the main
 git repository.
 
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 5daf750..d52e517 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -28,7 +28,7 @@ submodule.<name>.path::
 	be unique within the .gitmodules file.
 
 submodule.<name>.url::
-	Defines an url from where the submodule repository can be cloned.
+	Defines an URL from where the submodule repository can be cloned.
 
 submodule.<name>.update::
 	Defines what to do when the submodule is updated by the superproject.
@@ -58,7 +58,7 @@ Consider the following .gitmodules file:
 
 This defines two submodules, `libfoo` and `libbar`. These are expected to
 be checked out in the paths 'include/foo' and 'include/bar', and for both
-submodules an url is specified which can be used for cloning the submodules.
+submodules an URL is specified which can be used for cloning the submodules.
 
 SEE ALSO
 --------
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index 3cd32d6..eb3d040 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -16,7 +16,7 @@ You may find these things in your git repository (`.git`
 directory for a repository associated with your working tree, or
 `<project>.git` directory for a public 'bare' repository. It is
 also possible to have a working tree where `.git` is a plain
-ascii file containing `gitdir: <path>`, i.e. the path to the
+ASCII file containing `gitdir: <path>`, i.e. the path to the
 real git repository).
 
 objects::
diff --git a/Documentation/gittutorial-2.txt b/Documentation/gittutorial-2.txt
index ecab0c0..e97308b 100644
--- a/Documentation/gittutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -45,9 +45,9 @@ What are the 7 digits of hex that git responded to the commit with?
 
 We saw in part one of the tutorial that commits have names like this.
 It turns out that every object in the git history is stored under
-a 40-digit hex name.  That name is the SHA1 hash of the object's
+a 40-digit hex name.  That name is the SHA-1 hash of the object's
 contents; among other things, this ensures that git will never store
-the same data twice (since identical data is given an identical SHA1
+the same data twice (since identical data is given an identical SHA-1
 name), and that the contents of a git object will never change (since
 that would change the object's name as well). The 7 char hex strings
 here are simply the abbreviation of such 40 character long strings.
@@ -55,7 +55,7 @@ Abbreviations can be used everywhere where the 40 character strings
 can be used, so long as they are unambiguous.
 
 It is expected that the content of the commit object you created while
-following the example above generates a different SHA1 hash than
+following the example above generates a different SHA-1 hash than
 the one shown above because the commit object records the time when
 it was created and the name of the person performing the commit.
 
@@ -79,14 +79,14 @@ A tree can refer to one or more "blob" objects, each corresponding to
 a file.  In addition, a tree can also refer to other tree objects,
 thus creating a directory hierarchy.  You can examine the contents of
 any tree using ls-tree (remember that a long enough initial portion
-of the SHA1 will also work):
+of the SHA-1 will also work):
 
 ------------------------------------------------
 $ git ls-tree 92b8b694
 100644 blob 3b18e512dba79e4c8300dd08aeb37f8e728b8dad    file.txt
 ------------------------------------------------
 
-Thus we see that this tree has one file in it.  The SHA1 hash is a
+Thus we see that this tree has one file in it.  The SHA-1 hash is a
 reference to that file's data:
 
 ------------------------------------------------
@@ -105,7 +105,7 @@ Note that this is the old file data; so the object that git named in
 its response to the initial tree was a tree with a snapshot of the
 directory state that was recorded by the first commit.
 
-All of these objects are stored under their SHA1 names inside the git
+All of these objects are stored under their SHA-1 names inside the git
 directory:
 
 ------------------------------------------------
@@ -141,7 +141,7 @@ ref: refs/heads/master
 
 As you can see, this tells us which branch we're currently on, and it
 tells us this by naming a file under the .git directory, which itself
-contains a SHA1 name referring to a commit object, which we can
+contains a SHA-1 name referring to a commit object, which we can
 examine with cat-file:
 
 ------------------------------------------------
@@ -207,7 +207,7 @@ project's history:
 
 Note, by the way, that lots of commands take a tree as an argument.
 But as we can see above, a tree can be referred to in many different
-ways--by the SHA1 name for that tree, by the name of a commit that
+ways--by the SHA-1 name for that tree, by the name of a commit that
 refers to the tree, by the name of a branch whose head refers to that
 tree, etc.--and most such commands can accept any of these names.
 
diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 1686a54..baf4ec2 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -4,7 +4,7 @@ PRETTY FORMATS
 If the commit is a merge, and if the pretty-format
 is not 'oneline', 'email' or 'raw', an additional line is
 inserted before the 'Author:' line.  This line begins with
-"Merge: " and the sha1s of ancestral commits are printed,
+"Merge: " and the SHA-1s of ancestral commits are printed,
 separated by spaces.  Note that the listed commits may not
 necessarily be the list of the *direct* parent commits if you
 have limited your view of history: for example, if you are
@@ -70,7 +70,7 @@ This is designed to be as compact as possible.
 * 'raw'
 +
 The 'raw' format shows the entire commit exactly as
-stored in the commit object.  Notably, the SHA1s are
+stored in the commit object.  Notably, the SHA-1s are
 displayed in full, regardless of whether --abbrev or
 --no-abbrev are used, and 'parents' information show the
 true parent commits, without taking grafts nor history
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index b169836..367c3da 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1196,7 +1196,7 @@ the time, you will want to commit your changes before you can merge,
 and if you don't, then linkgit:git-stash[1] can take these changes
 away while you're doing the merge, and reapply them afterwards.
 
-If the changes are independant enough, Git will automatically complete
+If the changes are independent enough, Git will automatically complete
 the merge and commit the result (or reuse an existing commit in case
 of <<fast-forwards,fast-forward>>, see below). On the other hand,
 if there are conflicts--for example, if the same file is
@@ -1902,11 +1902,11 @@ linkgit:git-daemon[1] man page for details.  (See especially the
 examples section.)
 
 [[exporting-via-http]]
-Exporting a git repository via http
+Exporting a git repository via HTTP
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The git protocol gives better performance and reliability, but on a
-host with a web server set up, http exports may be simpler to set up.
+host with a web server set up, HTTP exports may be simpler to set up.
 
 All you need to do is place the newly created bare git repository in
 a directory that is exported by the web server, and make some
@@ -1932,7 +1932,7 @@ $ git clone http://yourserver.com/~you/proj.git
 (See also
 link:howto/setup-git-server-over-http.txt[setup-git-server-over-http]
 for a slightly more sophisticated setup using WebDAV which also
-allows pushing over http.)
+allows pushing over HTTP.)
 
 [[pushing-changes-to-a-public-repository]]
 Pushing changes to a public repository
@@ -2069,7 +2069,7 @@ advantages over the central shared repository:
 Allowing web browsing of a repository
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-The gitweb cgi script provides users an easy way to browse your
+The gitweb CGI script provides users an easy way to browse your
 project's files and history without having to install git; see the file
 gitweb/INSTALL in the git source tree for instructions on setting it up.
 
@@ -3022,7 +3022,7 @@ for example, the blob in the entry for "COPYING" from the tree above:
 $ git show 6ff87c4664
 
  Note that the only valid version of the GPL as far as this project
- is concerned is _this_ particular version of the license (ie v2, not
+ is concerned is _this_ particular version of the license (i.e., v2, not
  v2.2 or v3.x or whatever), unless explicitly otherwise stated.
 ...
 ------------------------------------------------
@@ -3366,7 +3366,7 @@ and your repository is good again!
 $ git log --raw --all
 ------------------------------------------------
 
-and just looked for the sha of the missing object (4b9458b..) in that
+and just looked for the SHA-1 of the missing object (4b9458b..) in that
 whole thing. It's up to you - git does *have* a lot of information, it is
 just missing one particular blob version.
 
-- 
1.6.6.1.383.g5a9f
