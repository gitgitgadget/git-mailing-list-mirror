From: =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
Subject: [PATCH] Spelling fixes.
Date: Sat, 23 Feb 2013 16:31:39 +0200
Message-ID: <1361629899-8346-1-git-send-email-ville.skytta@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 23 15:32:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9G9H-0007QK-AG
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 15:32:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758132Ab3BWObq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Feb 2013 09:31:46 -0500
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:57865 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756441Ab3BWObn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 09:31:43 -0500
Received: from localhost (localhost [127.0.0.1])
	by filtteri2.pp.htv.fi (Postfix) with ESMTP id 8644F19BB0E
	for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:31:41 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
	by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
	with ESMTP id JQo8ew7sTDgM for <git@vger.kernel.org>;
	Sat, 23 Feb 2013 16:31:40 +0200 (EET)
Received: from viper.bobcat.mine.nu.bobcat.mine.nu (cs78200229.pp.htv.fi [62.78.200.229])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp4.welho.com (Postfix) with ESMTPS id 19F795BC011
	for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:31:40 +0200 (EET)
X-Mailer: git-send-email 1.7.11.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216896>


Signed-off-by: Ville Skytt=C3=A4 <ville.skytta@iki.fi>
---
 Documentation/RelNotes/1.7.5.4.txt                 |  2 +-
 Documentation/RelNotes/1.7.8.txt                   |  2 +-
 Documentation/RelNotes/1.8.2.txt                   |  2 +-
 Documentation/git-credential.txt                   |  2 +-
 Documentation/git-remote-ext.txt                   |  2 +-
 Documentation/git-svn.txt                          |  4 ++--
 Documentation/revisions.txt                        |  2 +-
 Documentation/technical/api-argv-array.txt         |  2 +-
 Documentation/technical/api-credentials.txt        |  2 +-
 Documentation/technical/api-ref-iteration.txt      |  2 +-
 builtin/apply.c                                    |  6 +++---
 commit.c                                           |  2 +-
 commit.h                                           |  2 +-
 contrib/mw-to-git/git-remote-mediawiki.perl        |  6 +++---
 contrib/mw-to-git/t/README                         |  6 +++---
 contrib/mw-to-git/t/install-wiki/LocalSettings.php |  2 +-
 contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh        | 10 +++++-----
 contrib/mw-to-git/t/test-gitmw-lib.sh              |  2 +-
 contrib/subtree/t/t7900-subtree.sh                 |  2 +-
 diff.c                                             |  2 +-
 git-add--interactive.perl                          |  2 +-
 git-cvsserver.perl                                 |  4 ++--
 git-gui/lib/blame.tcl                              |  2 +-
 git-gui/lib/index.tcl                              |  2 +-
 git-gui/lib/spellcheck.tcl                         |  4 ++--
 git-quiltimport.sh                                 |  2 +-
 gitweb/INSTALL                                     |  2 +-
 gitweb/gitweb.perl                                 |  6 +++---
 kwset.c                                            |  4 ++--
 perl/Git.pm                                        |  2 +-
 perl/Git/I18N.pm                                   |  2 +-
 perl/private-Error.pm                              |  2 +-
 po/README                                          |  6 +++---
 po/pt_PT.po                                        |  2 +-
 po/zh_CN.po                                        |  2 +-
 sequencer.c                                        |  2 +-
 t/t0022-crlf-rename.sh                             |  2 +-
 t/t3701-add-interactive.sh                         |  2 +-
 t/t4014-format-patch.sh                            |  6 +++---
 t/t4124-apply-ws-rule.sh                           |  2 +-
 t/t6030-bisect-porcelain.sh                        |  2 +-
 t/t7001-mv.sh                                      |  8 ++++----
 t/t7004-tag.sh                                     |  2 +-
 t/t7600-merge.sh                                   |  2 +-
 t/t7601-merge-pull-config.sh                       |  2 +-
 t/t9001-send-email.sh                              |  2 +-
 transport.h                                        |  2 +-
 xdiff/xdiffi.c                                     |  2 +-
 xdiff/xhistogram.c                                 |  2 +-
 49 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/Documentation/RelNotes/1.7.5.4.txt b/Documentation/RelNote=
s/1.7.5.4.txt
index cf3f455..7796df3 100644
--- a/Documentation/RelNotes/1.7.5.4.txt
+++ b/Documentation/RelNotes/1.7.5.4.txt
@@ -5,7 +5,7 @@ Fixes since v1.7.5.3
 --------------------
=20
  * The single-key mode of "git add -p" was easily fooled into thinking
-   that it was told to add everthing ('a') when up-arrow was pressed b=
y
+   that it was told to add everything ('a') when up-arrow was pressed =
by
    mistake.
=20
  * Setting a git command that uses custom configuration via "-c var=3D=
val"
diff --git a/Documentation/RelNotes/1.7.8.txt b/Documentation/RelNotes/=
1.7.8.txt
index b4d90bb..7012329 100644
--- a/Documentation/RelNotes/1.7.8.txt
+++ b/Documentation/RelNotes/1.7.8.txt
@@ -9,7 +9,7 @@ Updates since v1.7.7
  * Updates to bash completion scripts.
=20
  * The build procedure has been taught to take advantage of computed
-   dependency automatically when the complier supports it.
+   dependency automatically when the compiler supports it.
=20
  * The date parser now accepts timezone designators that lack minutes
    part and also has a colon between "hh:mm".
diff --git a/Documentation/RelNotes/1.8.2.txt b/Documentation/RelNotes/=
1.8.2.txt
index a287f24..4e63644 100644
--- a/Documentation/RelNotes/1.8.2.txt
+++ b/Documentation/RelNotes/1.8.2.txt
@@ -17,7 +17,7 @@ preference configuration variable "push.default" to c=
hange this.
=20
 "git push $there tag v1.2.3" used to allow replacing a tag v1.2.3
 that already exists in the repository $there, if the rewritten tag
-you are pushing points at a commit that is a decendant of a commit
+you are pushing points at a commit that is a descendant of a commit
 that the old tag v1.2.3 points at.  This was found to be error prone
 and starting with this release, any attempt to update an existing
 ref under refs/tags/ hierarchy will fail, without "--force".
diff --git a/Documentation/git-credential.txt b/Documentation/git-crede=
ntial.txt
index 472f00f..7da0f13 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -56,7 +56,7 @@ For example, if we want a password for
 `https://example.com/foo.git`, we might generate the following
 credential description (don't forget the blank line at the end; it
 tells `git credential` that the application finished feeding all the
-infomation it has):
+information it has):
=20
 	 protocol=3Dhttps
 	 host=3Dexample.com
diff --git a/Documentation/git-remote-ext.txt b/Documentation/git-remot=
e-ext.txt
index 58b7fac..8cfc748 100644
--- a/Documentation/git-remote-ext.txt
+++ b/Documentation/git-remote-ext.txt
@@ -86,7 +86,7 @@ begins with `ext::`.  Examples:
 	edit .ssh/config.
=20
 "ext::socat -t3600 - ABSTRACT-CONNECT:/git-server %G/somerepo"::
-	Represents repository with path /somerepo accessable over
+	Represents repository with path /somerepo accessible over
 	git protocol at abstract namespace address /git-server.
=20
 "ext::git-server-alias foo %G/repo"::
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 1b8b649..7706d41 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -245,7 +245,7 @@ first have already been pushed into SVN.
 	patch), "all" (accept all patches), or "quit".
 	+
 	'git svn dcommit' returns immediately if answer if "no" or "quit", wi=
thout
-	commiting anything to SVN.
+	committing anything to SVN.
=20
 'branch'::
 	Create a branch in the SVN repository.
@@ -856,7 +856,7 @@ HANDLING OF SVN BRANCHES
 ------------------------
 If 'git svn' is configured to fetch branches (and --follow-branches
 is in effect), it sometimes creates multiple Git branches for one
-SVN branch, where the addtional branches have names of the form
+SVN branch, where the additional branches have names of the form
 'branchname@nnn' (with nnn an SVN revision number).  These additional
 branches are created if 'git svn' cannot find a parent commit for the
 first commit in an SVN branch, to connect the branch to the history of
diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 678d175..39a855a 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -55,7 +55,7 @@ when you run `git cherry-pick`.
 +
 Note that any of the 'refs/*' cases above may come either from
 the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
-While the ref name encoding is unspecified, UTF-8 is prefered as
+While the ref name encoding is unspecified, UTF-8 is preferred as
 some output processing may assume ref names in UTF-8.
=20
 '<refname>@\{<date>\}', e.g. 'master@\{yesterday\}', 'HEAD@\{5 minutes=
 ago\}'::
diff --git a/Documentation/technical/api-argv-array.txt b/Documentation=
/technical/api-argv-array.txt
index a959517..a6b7d83 100644
--- a/Documentation/technical/api-argv-array.txt
+++ b/Documentation/technical/api-argv-array.txt
@@ -55,7 +55,7 @@ Functions
 	initial, empty state.
=20
 `argv_array_detach`::
-	Detach the argv array from the `struct argv_array`, transfering
+	Detach the argv array from the `struct argv_array`, transferring
 	ownership of the allocated array and strings.
=20
 `argv_array_free_detached`::
diff --git a/Documentation/technical/api-credentials.txt b/Documentatio=
n/technical/api-credentials.txt
index 516fda7..c1b42a4 100644
--- a/Documentation/technical/api-credentials.txt
+++ b/Documentation/technical/api-credentials.txt
@@ -160,7 +160,7 @@ int foo_login(struct foo_connection *f)
 		break;
 	default:
 		/*
-		 * Some other error occured. We don't know if the
+		 * Some other error occurred. We don't know if the
 		 * credential is good or bad, so report nothing to the
 		 * credential subsystem.
 		 */
diff --git a/Documentation/technical/api-ref-iteration.txt b/Documentat=
ion/technical/api-ref-iteration.txt
index dbbea95..aa1c50f 100644
--- a/Documentation/technical/api-ref-iteration.txt
+++ b/Documentation/technical/api-ref-iteration.txt
@@ -35,7 +35,7 @@ Iteration functions
 * `head_ref_submodule()`, `for_each_ref_submodule()`,
   `for_each_ref_in_submodule()`, `for_each_tag_ref_submodule()`,
   `for_each_branch_ref_submodule()`, `for_each_remote_ref_submodule()`
-  do the same as the functions descibed above but for a specified
+  do the same as the functions described above but for a specified
   submodule.
=20
 * `for_each_rawref()` can be used to learn about broken ref and symref=
=2E
diff --git a/builtin/apply.c b/builtin/apply.c
index 06f5320..f6a3c97 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1921,7 +1921,7 @@ static int parse_binary(char *buffer, unsigned lo=
ng size, struct patch *patch)
 }
=20
 /*
- * Read the patch text in "buffer" taht extends for "size" bytes; stop
+ * Read the patch text in "buffer" that extends for "size" bytes; stop
  * reading after seeing a single patch (i.e. changes to a single file)=
=2E
  * Create fragments (i.e. patch hunks) and hang them to the given patc=
h.
  * Return the number of bytes consumed, so that the caller can call us
@@ -3025,7 +3025,7 @@ static struct patch *in_fn_table(const char *name=
)
  *
  * The latter is needed to deal with a case where two paths A and B
  * are swapped by first renaming A to B and then renaming B to A;
- * moving A to B should not be prevented due to presense of B as we
+ * moving A to B should not be prevented due to presence of B as we
  * will remove it in a later patch.
  */
 #define PATH_TO_BE_DELETED ((struct patch *) -2)
@@ -3509,7 +3509,7 @@ static int check_patch(struct patch *patch)
 	 *
 	 * A patch to swap-rename between A and B would first rename A
 	 * to B and then rename B to A.  While applying the first one,
-	 * the presense of B should not stop A from getting renamed to
+	 * the presence of B should not stop A from getting renamed to
 	 * B; ask to_be_deleted() about the later rename.  Removal of
 	 * B and rename from A to B is handled the same way by asking
 	 * was_deleted().
diff --git a/commit.c b/commit.c
index e8eb0ae..1a41757 100644
--- a/commit.c
+++ b/commit.c
@@ -834,7 +834,7 @@ struct commit_list *get_merge_bases(struct commit *=
one, struct commit *two,
 }
=20
 /*
- * Is "commit" a decendant of one of the elements on the "with_commit"=
 list?
+ * Is "commit" a descendant of one of the elements on the "with_commit=
" list?
  */
 int is_descendant_of(struct commit *commit, struct commit_list *with_c=
ommit)
 {
diff --git a/commit.h b/commit.h
index 4138bb4..252c7f8 100644
--- a/commit.h
+++ b/commit.h
@@ -164,7 +164,7 @@ extern struct commit_list *get_merge_bases(struct c=
ommit *rev1, struct commit *r
 extern struct commit_list *get_merge_bases_many(struct commit *one, in=
t n, struct commit **twos, int cleanup);
 extern struct commit_list *get_octopus_merge_bases(struct commit_list =
*in);
=20
-/* largest postive number a signed 32-bit integer can contain */
+/* largest positive number a signed 32-bit integer can contain */
 #define INFINITE_DEPTH 0x7fffffff
=20
 extern int register_shallow(const unsigned char *sha1);
diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 094129d..779c379 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -28,7 +28,7 @@ use warnings;
 use constant SLASH_REPLACEMENT =3D> "%2F";
=20
 # It's not always possible to delete pages (may require some
-# priviledges). Deleted pages are replaced with this content.
+# privileges). Deleted pages are replaced with this content.
 use constant DELETED_CONTENT =3D> "[[Category:Deleted]]\n";
=20
 # It's not possible to create empty pages. New empty files in Git are
@@ -841,7 +841,7 @@ sub mw_import_ref {
 	if ($fetch_from =3D=3D 1 && $n =3D=3D 0) {
 		print STDERR "You appear to have cloned an empty MediaWiki.\n";
 		# Something has to be done remote-helper side. If nothing is done, a=
n error is
-		# thrown saying that HEAD is refering to unknown object 000000000000=
0000000
+		# thrown saying that HEAD is referring to unknown object 00000000000=
00000000
 		# and the clone fails.
 	}
 }
@@ -986,7 +986,7 @@ sub mw_upload_file {
 		print STDERR "Check the configuration of file uploads in your mediaw=
iki.\n";
 		return $newrevid;
 	}
-	# Deleting and uploading a file requires a priviledged user
+	# Deleting and uploading a file requires a privileged user
 	if ($file_deleted) {
 		mw_connect_maybe();
 		my $query =3D {
diff --git a/contrib/mw-to-git/t/README b/contrib/mw-to-git/t/README
index 96e9739..03f6ee5 100644
--- a/contrib/mw-to-git/t/README
+++ b/contrib/mw-to-git/t/README
@@ -25,7 +25,7 @@ Principles and Technical Choices
=20
 The test environment makes it easy to install and manipulate one or
 several MediaWiki instances. To allow developers to run the testsuite
-easily, the environment does not require root priviledge (except to
+easily, the environment does not require root privilege (except to
 install the required packages if needed). It starts a webserver
 instance on the user's account (using lighttpd greatly helps for
 that), and does not need a separate database daemon (thanks to the use
@@ -81,7 +81,7 @@ parameters, please refer to the `test-gitmw-lib.sh` a=
nd
=20
 ** `test_check_wiki_precond`:
 Check if the tests must be skipped or not. Please use this function
-at the beggining of each new test file.
+at the beginning of each new test file.
=20
 ** `wiki_getpage`:
 Fetch a given page from the wiki and puts its content in the
@@ -113,7 +113,7 @@ Tests if a given page exists on the wiki.
=20
 ** `wiki_reset`:
 Reset the wiki, i.e. flush the database. Use this function at the
-begining of each new test, except if the test re-uses the same wiki
+beginning of each new test, except if the test re-uses the same wiki
 (and history) as the previous test.
=20
 How to write a new test
diff --git a/contrib/mw-to-git/t/install-wiki/LocalSettings.php b/contr=
ib/mw-to-git/t/install-wiki/LocalSettings.php
index 29f1251..745e47e 100644
--- a/contrib/mw-to-git/t/install-wiki/LocalSettings.php
+++ b/contrib/mw-to-git/t/install-wiki/LocalSettings.php
@@ -88,7 +88,7 @@ $wgShellLocale =3D "en_US.utf8";
=20
 ## Set $wgCacheDirectory to a writable directory on the web server
 ## to make your wiki go slightly faster. The directory should not
-## be publically accessible from the web.
+## be publicly accessible from the web.
 #$wgCacheDirectory =3D "$IP/cache";
=20
 # Site language code, should be one of the list in ./languages/Names.p=
hp
diff --git a/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh b/contrib/mw-t=
o-git/t/t9362-mw-to-git-utf8.sh
index b6405ce..e764ddc 100755
--- a/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh
+++ b/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh
@@ -139,7 +139,7 @@ test_expect_success 'character $ in file name (git =
-> mw) ' '
 '
=20
=20
-test_expect_failure 'capital at the begining of file names' '
+test_expect_failure 'capital at the beginning of file names' '
 	wiki_reset &&
 	git clone mediawiki::'"$WIKI_URL"' mw_dir_10 &&
 	(
@@ -156,7 +156,7 @@ test_expect_failure 'capital at the begining of fil=
e names' '
 '
=20
=20
-test_expect_failure 'special character at the begining of file name fr=
om mw to git' '
+test_expect_failure 'special character at the beginning of file name f=
rom mw to git' '
 	wiki_reset &&
 	git clone mediawiki::'"$WIKI_URL"' mw_dir_11 &&
 	wiki_editpage {char_1 "expect to be renamed {char_1" false &&
@@ -207,7 +207,7 @@ test_expect_success 'test of correct formating for =
file name from mw to git' '
 '
=20
=20
-test_expect_failure 'test of correct formating for file name begining =
with special character' '
+test_expect_failure 'test of correct formating for file name beginning=
 with special character' '
 	wiki_reset &&
 	git clone mediawiki::'"$WIKI_URL"' mw_dir_13 &&
 	(
@@ -215,7 +215,7 @@ test_expect_failure 'test of correct formating for =
file name begining with speci
 		echo "my new file {char_1" >\{char_1.mw &&
 		echo "my new file [char_2" >\[char_2.mw &&
 		git add . &&
-		git commit -am "commiting some exotic file name..." &&
+		git commit -am "committing some exotic file name..." &&
 		git push &&
 		git pull
 	) &&
@@ -234,7 +234,7 @@ test_expect_success 'test of correct formating for =
file name from git to mw' '
 		echo "my new file char{_1" >Char\{_1.mw &&
 		echo "my new file char[_2" >Char\[_2.mw &&
 		git add . &&
-		git commit -m "commiting some exotic file name..." &&
+		git commit -m "committing some exotic file name..." &&
 		git push
 	) &&
 	wiki_getallpage ref_page_14 &&
diff --git a/contrib/mw-to-git/t/test-gitmw-lib.sh b/contrib/mw-to-git/=
t/test-gitmw-lib.sh
index 3b2cfac..dbaf47d 100755
--- a/contrib/mw-to-git/t/test-gitmw-lib.sh
+++ b/contrib/mw-to-git/t/test-gitmw-lib.sh
@@ -95,7 +95,7 @@ test_diff_directories () {
 # Check that <dir> contains exactly <N> files
 test_contains_N_files () {
 	if test `ls -- "$1" | wc -l` -ne "$2"; then
-		echo "directory $1 sould contain $2 files"
+		echo "directory $1 should contain $2 files"
 		echo "it contains these files:"
 		ls "$1"
 		false
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t79=
00-subtree.sh
index 80d3399..4729521 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -419,7 +419,7 @@ test_expect_success 'add main-sub5' '
 test_expect_success 'split for main-sub5 without --onto' '
         # also test that we still can split out an entirely new subtre=
e
         # if the parent of the first commit in the tree is not empty,
-        # then the new subtree has accidently been attached to somethi=
ng
+        # then the new subtree has accidentally been attached to somet=
hing
         git subtree split --prefix subdir2 --branch mainsub5 &&
         check_equal ''"$(git log --pretty=3Dformat:%P -1 mainsub5)"'' =
""
 '
diff --git a/diff.c b/diff.c
index 156fec4..71ac502 100644
--- a/diff.c
+++ b/diff.c
@@ -1553,7 +1553,7 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
 	 * Binary files are displayed with "Bin XXX -> YYY bytes"
 	 * instead of the change count and graph. This part is treated
 	 * similarly to the graph part, except that it is not
-	 * "scaled". If total width is too small to accomodate the
+	 * "scaled". If total width is too small to accommodate the
 	 * guaranteed minimum width of the filename part and the
 	 * separators and this message, this message will "overflow"
 	 * making the line longer than the maximum width.
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 710764a..d2c4ce6 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1247,7 +1247,7 @@ sub summarize_hunk {
=20
=20
 # Print a one-line summary of each hunk in the array ref in
-# the first argument, starting wih the index in the 2nd.
+# the first argument, starting with the index in the 2nd.
 sub display_hunks {
 	my ($hunks, $i) =3D @_;
 	my $ctr =3D 0;
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 3679074..b50a970 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2911,7 +2911,7 @@ sub filenamesplit
 }
=20
 # Cleanup various junk in filename (try to canonicalize it), and
-# add prependdir to accomodate running CVS client from a
+# add prependdir to accommodate running CVS client from a
 # subdirectory (so the output is relative to top directory of the proj=
ect).
 sub filecleanup
 {
@@ -4583,7 +4583,7 @@ sub getmeta
     #     the numerical value of the corresponding byte plus
     #     100.
     #      - "plus 100" avoids "0"s, and also reduces the
-    #        likelyhood of a collision in the case that someone someda=
y
+    #        likelihood of a collision in the case that someone someda=
y
     #        writes an import tool that tries to preserve original
     #        CVS revision numbers, and the original CVS data had done
     #        lots of branches off of branches and other strangeness to
diff --git a/git-gui/lib/blame.tcl b/git-gui/lib/blame.tcl
index 324f774..b1d15f4 100644
--- a/git-gui/lib/blame.tcl
+++ b/git-gui/lib/blame.tcl
@@ -5,7 +5,7 @@ class blame {
=20
 image create photo ::blame::img_back_arrow -data {R0lGODlhGAAYAIUAAPwC=
BEzKXFTSZIz+nGzmhGzqfGTidIT+nEzGXHTqhGzmfGzifFzadETCVES+VARWDFzWbHzyjAR=
eDGTadFTOZDSyRDyyTCymPARaFGTedFzSbDy2TCyqRCyqPARaDAyCHES6VDy6VCyiPAR6HC=
SeNByWLARyFARiDARqFGTifARiFAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAAAALAAAAAAYABgAAAajQIBw=
SCwaj8ikcsk0BppJwRPqHEypQwHBis0WDAdEFyBIKBaMAKLBdjQeSkFBYTBAIvgEoS6JmhU=
TEwIUDQ4VFhcMGEhyCgoZExoUaxsWHB0THkgfAXUGAhoBDSAVFR0XBnCbDRmgog0hpSIiDJ=
pJIyEQhBUcJCIlwA22SSYVogknEg8eD82qSigdDSknY0IqJQXPYxIl1dZCGNvWw+Dm510GQ=
QAh/mhDcmVhdGVkIGJ5IEJNUFRvR0lGIFBybyB2ZXJzaW9uIDIuNQ0KqSBEZXZlbENvciAx=
OTk3LDE5OTguIEFsbCByaWdodHMgcmVzZXJ2ZWQuDQpodHRwOi8vd3d3LmRldmVsY29yLmN=
vbQA7}
=20
-# Persistant data (survives loads)
+# Persistent data (survives loads)
 #
 field history {}; # viewer history: {commit path}
 field header    ; # array commit,key -> header field
diff --git a/git-gui/lib/index.tcl b/git-gui/lib/index.tcl
index 8efbbdd..74a81a7 100644
--- a/git-gui/lib/index.tcl
+++ b/git-gui/lib/index.tcl
@@ -414,7 +414,7 @@ proc revert_helper {txt paths} {
 	# such distinction is needed in some languages. Previously, the
 	# code used "Revert changes in" for both, but that can't work
 	# in languages where 'in' must be combined with word from
-	# rest of string (in diffrent way for both cases of course).
+	# rest of string (in different way for both cases of course).
 	#
 	# FIXME: Unfortunately, even that isn't enough in some languages
 	# as they have quite complex plural-form rules. Unfortunately,
diff --git a/git-gui/lib/spellcheck.tcl b/git-gui/lib/spellcheck.tcl
index e612030..538d61c 100644
--- a/git-gui/lib/spellcheck.tcl
+++ b/git-gui/lib/spellcheck.tcl
@@ -14,7 +14,7 @@ field w_menu      ; # context menu for the widget
 field s_menuidx 0 ; # last index of insertion into $w_menu
=20
 field s_i           {} ; # timer registration for _run callbacks
-field s_clear        0 ; # did we erase mispelled tags yet?
+field s_clear        0 ; # did we erase misspelled tags yet?
 field s_seen    [list] ; # lines last seen from $w_text in _run
 field s_checked [list] ; # lines already checked
 field s_pending [list] ; # [$line $data] sent to ispell/aspell
@@ -259,7 +259,7 @@ method _run {} {
 		if {$n =3D=3D $cur_line
 		 && ![regexp {^\W$} [$w_text get $cur_pos insert]]} {
=20
-			# If the current word is mispelled remove the tag
+			# If the current word is misspelled remove the tag
 			# but force a spellcheck later.
 			#
 			set tags [$w_text tag names $cur_pos]
diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 9a6ba2b..8e17525 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -59,7 +59,7 @@ tmp_patch=3D"$tmp_dir/patch"
 tmp_info=3D"$tmp_dir/info"
=20
=20
-# Find the intial commit
+# Find the initial commit
 commit=3D$(git rev-parse HEAD)
=20
 mkdir $tmp_dir || exit 2
diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index 6d45406..08f3dda 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -244,7 +244,7 @@ for gitweb (in gitweb/README), and gitweb.conf(5) m=
anpage.
   through the GITWEB_CONFIG_SYSTEM environment variable.
=20
   Note that if per-instance configuration file exists, then system-wid=
e
-  configuration is _not used at all_.  This is quite untypical and sup=
rising
+  configuration is _not used at all_.  This is quite untypical and sur=
prising
   behavior.  On the other hand changing current behavior would break b=
ackwards
   compatibility and can lead to unexpected changes in gitweb behavior.
   Therefore gitweb also looks for common system-wide configuration fil=
e,
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1309196..80950c0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -683,7 +683,7 @@ sub evaluate_gitweb_config {
 	our $GITWEB_CONFIG_SYSTEM =3D $ENV{'GITWEB_CONFIG_SYSTEM'} || "++GITW=
EB_CONFIG_SYSTEM++";
 	our $GITWEB_CONFIG_COMMON =3D $ENV{'GITWEB_CONFIG_COMMON'} || "++GITW=
EB_CONFIG_COMMON++";
=20
-	# Protect agains duplications of file names, to not read config twice=
=2E
+	# Protect against duplications of file names, to not read config twic=
e.
 	# Only one of $GITWEB_CONFIG and $GITWEB_CONFIG_SYSTEM is used, so
 	# there possibility of duplication of filename there doesn't matter.
 	$GITWEB_CONFIG =3D ""        if ($GITWEB_CONFIG eq $GITWEB_CONFIG_COM=
MON);
@@ -1136,7 +1136,7 @@ sub handle_errors_html {
=20
 	# to avoid infinite loop where error occurs in die_error,
 	# change handler to default handler, disabling handle_errors_html
-	set_message("Error occured when inside die_error:\n$msg");
+	set_message("Error occurred when inside die_error:\n$msg");
=20
 	# you cannot jump out of die_error when called as error handler;
 	# the subroutine set via CGI::Carp::set_message is called _after_
@@ -7485,7 +7485,7 @@ sub git_object {
 		system(git_cmd(), "cat-file", '-e', $hash_base) =3D=3D 0
 			or die_error(404, "Base object does not exist");
=20
-		# here errors should not hapen
+		# here errors should not happen
 		open my $fd, "-|", git_cmd(), "ls-tree", $hash_base, "--", $file_nam=
e
 			or die_error(500, "Open git-ls-tree failed");
 		my $line =3D <$fd>;
diff --git a/kwset.c b/kwset.c
index 51b2ab6..5800999 100644
--- a/kwset.c
+++ b/kwset.c
@@ -26,7 +26,7 @@
    The author may be reached (Email) at the address mike@ai.mit.edu,
    or (US mail) as Mike Haertel c/o Free Software Foundation. */
=20
-/* The algorithm implemented by these routines bears a startling resem=
blence
+/* The algorithm implemented by these routines bears a startling resem=
blance
    to one discovered by Beate Commentz-Walter, although it is not iden=
tical.
    See "A String Matching Algorithm Fast on the Average," Technical Re=
port,
    IBM-Germany, Scientific Center Heidelberg, Tiergartenstrasse 15, D-=
6900
@@ -435,7 +435,7 @@ kwsprep (kwset_t kws)
 	  /* Update the delta table for the descendents of this node. */
 	  treedelta(curr->links, curr->depth, delta);
=20
-	  /* Compute the failure function for the decendents of this node. */
+	  /* Compute the failure function for the descendants of this node. *=
/
 	  treefails(curr->links, curr->fail, kwset->trie);
=20
 	  /* Update the shifts at each node in the current node's chain
diff --git a/perl/Git.pm b/perl/Git.pm
index a56d1e7..2adec53 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1029,7 +1029,7 @@ my (%TEMP_FILEMAP, %TEMP_FILES);
=20
 =3Ditem temp_acquire ( NAME )
=20
-Attempts to retreive the temporary file mapped to the string C<NAME>. =
If an
+Attempts to retrieve the temporary file mapped to the string C<NAME>. =
If an
 associated temp file has not been created this session or was closed, =
it is
 created, cached, and set for autoflush and binmode.
=20
diff --git a/perl/Git/I18N.pm b/perl/Git/I18N.pm
index 40dd897..f889fd6 100644
--- a/perl/Git/I18N.pm
+++ b/perl/Git/I18N.pm
@@ -68,7 +68,7 @@ Git::I18N - Perl interface to Git's Gettext localizat=
ions
=20
 	print __("Welcome to Git!\n");
=20
-	printf __("The following error occured: %s\n"), $error;
+	printf __("The following error occurred: %s\n"), $error;
=20
 =3Dhead1 DESCRIPTION
=20
diff --git a/perl/private-Error.pm b/perl/private-Error.pm
index 11e9cd9..9a0c567 100644
--- a/perl/private-Error.pm
+++ b/perl/private-Error.pm
@@ -769,7 +769,7 @@ is a numeric value. These values are what will be r=
eturned by the
 overload methods.
=20
 If the text value ends with C<at file line 1> as $@ strings do, then
-this infomation will be used to set the C<-file> and C<-line> argument=
s
+this information will be used to set the C<-file> and C<-line> argumen=
ts
 of the error object.
=20
 This class is used internally if an eval'd block die's with an error
diff --git a/po/README b/po/README
index c1520e8..d8c9111 100644
--- a/po/README
+++ b/po/README
@@ -232,7 +232,7 @@ Shell:
=20
        # To interpolate variables:
        details=3D"oh noes"
-       eval_gettext "An error occured: \$details"; echo
+       eval_gettext "An error occurred: \$details"; echo
=20
    In addition we have wrappers for messages that end with a trailing
    newline. I.e. you could write the above as:
@@ -242,7 +242,7 @@ Shell:
=20
        # To interpolate variables:
        details=3D"oh noes"
-       eval_gettextln "An error occured: \$details"
+       eval_gettextln "An error occurred: \$details"
=20
    More documentation about the interface is available in the GNU info
    page: `info '(gettext)sh'`. Looking at git-am.sh (the first shell
@@ -257,7 +257,7 @@ Perl:
=20
        use Git::I18N;
        print __("Welcome to Git!\n");
-       printf __("The following error occured: %s\n"), $error;
+       printf __("The following error occurred: %s\n"), $error;
=20
    Run `perldoc perl/Git/I18N.pm` for more info.
=20
diff --git a/po/pt_PT.po b/po/pt_PT.po
index 517ec29..d8f5abd 100644
--- a/po/pt_PT.po
+++ b/po/pt_PT.po
@@ -1,7 +1,7 @@
 # Portuguese translations for Git package.
 # Copyright (C) 2012 Marco Sousa <marcomsousa AT gmail.com>
 # This file is distributed under the same license as the Git package.
-# Contributers:
+# Contributors:
 #   - Marco Sousa <marcomsousa AT gmail.com>
 #
 msgid ""
diff --git a/po/zh_CN.po b/po/zh_CN.po
index 6379876..f7e3270 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -2,7 +2,7 @@
 # Git =E8=BD=AF=E4=BB=B6=E5=8C=85=E7=9A=84=E7=AE=80=E4=BD=93=E4=B8=AD=E6=
=96=87=E7=BF=BB=E8=AF=91.
 # Copyright (C) 2012,2013 Jiang Xin <worldhello.net AT gmail.com>
 # This file is distributed under the same license as the Git package.
-# Contributers:
+# Contributors:
 #   - Jiang Xin <worldhello.net AT gmail.com>
 #   - Riku <lu.riku AT gmail.com>
 #   - Zhuang Ya <zhuangya AT me.com>
diff --git a/sequencer.c b/sequencer.c
index aef5e8a..bad5077 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -133,7 +133,7 @@ static void print_advice(int show_hint, struct repl=
ay_opts *opts)
 	if (msg) {
 		fprintf(stderr, "%s\n", msg);
 		/*
-		 * A conflict has occured but the porcelain
+		 * A conflict has occurred but the porcelain
 		 * (typically rebase --interactive) wants to take care
 		 * of the commit itself so remove CHERRY_PICK_HEAD
 		 */
diff --git a/t/t0022-crlf-rename.sh b/t/t0022-crlf-rename.sh
index 7af3fbc..f702302 100755
--- a/t/t0022-crlf-rename.sh
+++ b/t/t0022-crlf-rename.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
=20
-test_description=3D'ignore CR in CRLF sequence while computing similia=
rity'
+test_description=3D'ignore CR in CRLF sequence while computing similar=
ity'
=20
 . ./test-lib.sh
=20
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 098a6ae..9fab25c 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -319,7 +319,7 @@ test_expect_success PERL 'split hunk "add -p (edit)=
"' '
 	# times to get out.
 	#
 	# 2. Correct version applies the (not)edited version, and asks
-	#    about the next hunk, against wich we say q and program
+	#    about the next hunk, against which we say q and program
 	#    exits.
 	for a in s e     q n q q
 	do
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 7fa3647..e91e66c 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -742,21 +742,21 @@ test_expect_success 'format-patch --signature --c=
over-letter' '
 	test 2 =3D $(grep "my sig" output | wc -l)
 '
=20
-test_expect_success 'format.signature=3D"" supresses signatures' '
+test_expect_success 'format.signature=3D"" suppresses signatures' '
 	git config format.signature "" &&
 	git format-patch --stdout -1 >output &&
 	check_patch output &&
 	! grep "^-- \$" output
 '
=20
-test_expect_success 'format-patch --no-signature supresses signatures'=
 '
+test_expect_success 'format-patch --no-signature suppresses signatures=
' '
 	git config --unset-all format.signature &&
 	git format-patch --stdout --no-signature -1 >output &&
 	check_patch output &&
 	! grep "^-- \$" output
 '
=20
-test_expect_success 'format-patch --signature=3D"" supresses signature=
s' '
+test_expect_success 'format-patch --signature=3D"" suppresses signatur=
es' '
 	git format-patch --stdout --signature=3D"" -1 >output &&
 	check_patch output &&
 	! grep "^-- \$" output
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 6f6ee88..581a801 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -47,7 +47,7 @@ test_fix () {
 	# find touched lines
 	$DIFF file target | sed -n -e "s/^> //p" >fixed
=20
-	# the changed lines are all expeced to change
+	# the changed lines are all expected to change
 	fixed_cnt=3D$(wc -l <fixed)
 	case "$1" in
 	'') expect_cnt=3D$fixed_cnt ;;
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 3e0e15f..8bf99e1 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -190,7 +190,7 @@ test_expect_success 'bisect start: no ".git/BISECT_=
START" if checkout error' '
 # $HASH1 is good, $HASH4 is bad, we skip $HASH3
 # but $HASH2 is bad,
 # so we should find $HASH2 as the first bad commit
-test_expect_success 'bisect skip: successfull result' '
+test_expect_success 'bisect skip: successful result' '
 	git bisect reset &&
 	git bisect start $HASH4 $HASH1 &&
 	git bisect skip &&
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index a845b15..3a51878 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -16,7 +16,7 @@ test_expect_success \
=20
 # in path0 currently
 test_expect_success \
-    'commiting the change' \
+    'committing the change' \
     'cd .. && git commit -m move-out -a'
=20
 test_expect_success \
@@ -30,7 +30,7 @@ test_expect_success \
=20
 # in path0 currently
 test_expect_success \
-    'commiting the change' \
+    'committing the change' \
     'cd .. && git commit -m move-in -a'
=20
 test_expect_success \
@@ -82,7 +82,7 @@ test_expect_success \
     'git mv path0 path2'
=20
 test_expect_success \
-    'commiting the change' \
+    'committing the change' \
     'git commit -m dir-move -a'
=20
 test_expect_success \
@@ -101,7 +101,7 @@ test_expect_success \
     'git mv path2 path1'
=20
 test_expect_success \
-    'commiting the change' \
+    'committing the change' \
     'git commit -m dir-move -a'
=20
 test_expect_success \
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index f5a79b1..4fb28dc 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -75,7 +75,7 @@ test_expect_success \
=20
 # todo: git tag -l now returns always zero, when fixed, change this te=
st
 test_expect_success \
-	'listing tags using a non-matching pattern should suceed' \
+	'listing tags using a non-matching pattern should succeed' \
 	'git tag -l xxx'
=20
 test_expect_success \
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 5e19598..37cc095 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -316,7 +316,7 @@ test_expect_success 'merge c1 with c2 (squash)' '
=20
 test_debug 'git log --graph --decorate --oneline --all'
=20
-test_expect_success 'unsuccesful merge of c1 with c2 (squash, ff-only)=
' '
+test_expect_success 'unsuccessful merge of c1 with c2 (squash, ff-only=
)' '
 	git reset --hard c1 &&
 	test_must_fail git merge --squash --ff-only c2
 '
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.s=
h
index b44b293..25dac79 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -109,7 +109,7 @@ test_expect_success 'setup conflicted merge' '
 '
=20
 # First do the merge with resolve and recursive then verify that
-# recusive is choosen.
+# recusive is chosen.
=20
 test_expect_success 'merge picks up the best result' '
 	git config --unset-all pull.twohead &&
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 97d6f4c..feaee8b 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -101,7 +101,7 @@ test_expect_success $PREREQ \
=20
 test_expect_success $PREREQ 'Send patches with --envelope-sender' '
     clean_fake_sendmail &&
-     git send-email --envelope-sender=3D"Patch Contributer <patch@exam=
ple.com>" --suppress-cc=3Dsob --from=3D"Example <nobody@example.com>" -=
-to=3Dnobody@example.com --smtp-server=3D"$(pwd)/fake.sendmail" $patche=
s 2>errors
+     git send-email --envelope-sender=3D"Patch Contributor <patch@exam=
ple.com>" --suppress-cc=3Dsob --from=3D"Example <nobody@example.com>" -=
-to=3Dnobody@example.com --smtp-server=3D"$(pwd)/fake.sendmail" $patche=
s 2>errors
 '
=20
 test_expect_success $PREREQ 'setup expect' '
diff --git a/transport.h b/transport.h
index a3450e9..e7beb81 100644
--- a/transport.h
+++ b/transport.h
@@ -74,7 +74,7 @@ struct transport {
 		       const char *executable, int fd[2]);
=20
 	/** get_refs_list(), fetch(), and push_refs() can keep
-	 * resources (such as a connection) reserved for futher
+	 * resources (such as a connection) reserved for further
 	 * use. disconnect() releases these resources.
 	 **/
 	int (*disconnect)(struct transport *connection);
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 1b7012a..b2eb6db 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -490,7 +490,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdf=
o, long flags) {
=20
 		/*
 		 * Try to move back the possibly merged group of changes, to match
-		 * the recorded postion in the other file.
+		 * the recorded position in the other file.
 		 */
 		while (ixref < ix) {
 			rchg[--ixs] =3D 1;
diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index bf99787..73210cb 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -55,7 +55,7 @@ struct histindex {
 	struct record {
 		unsigned int ptr, cnt;
 		struct record *next;
-	} **records, /* an ocurrence */
+	} **records, /* an occurrence */
 	  **line_map; /* map of line to record chain */
 	chastore_t rcha;
 	unsigned int *next_ptrs;
--=20
1.7.11.7
