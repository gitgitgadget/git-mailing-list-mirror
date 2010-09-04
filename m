From: avarab@gmail.com
Subject: [PATCH 2/2] po/en_GB.po: add British English Translation
Date: Sat,  4 Sep 2010 00:49:27 +0000
Message-ID: <4c8197ad.1707e30a.3f10.714b@mx.google.com>
References: <AANLkTi=6ctLp-8FeqOGMZuhwvM_7DbaEp7+LK4nXfCaE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Sam Reed <sam@reedyboy.net>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 04 02:50:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrgxY-0006cP-Az
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 02:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908Ab0IDAt4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Sep 2010 20:49:56 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:57907 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346Ab0IDAtw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 20:49:52 -0400
Received: by wwd20 with SMTP id 20so13234wwd.1
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 17:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=aAe9Lt2u3m+qE6ldJ0zOIbkBUaZbBhTfMI3PW6Z5IEk=;
        b=C7lGtj98+qNf4yJ2cGKZrHAiJHK3BKSthbmFmTDm+ZlatuacYeB3xN9PyVkpGeHYNn
         oNiBCZ2kietCMBDQszn0zzjiEcA7pxqy06zN8PAtEMDc7mmQO/g04zWmGzrkctHXuPw/
         FCW/gQ3n3cwBHRG3udEo0AyfrvW7Ns2C8rNy8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XjUXVlZvCmznLW382GrLmUkyKkTjcT7cPSSToFv1BLUMX4ultHVBbIGrLlZP23XTWf
         RsHjdMCVPy06oKW9xu9R8XCBAzP708oXoXyUhE0PaMtAnAQE8DpwHeSaOBCAv+zBIRjk
         xn27YS3ZN/9shnVIKR264zp+CPvZwVKtFdoM4=
Received: by 10.227.134.136 with SMTP id j8mr70690wbt.206.1283561390378;
        Fri, 03 Sep 2010 17:49:50 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id b23sm2108432wbb.22.2010.09.03.17.49.49
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Sep 2010 17:49:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.336.g704fc
In-Reply-To: <AANLkTi=6ctLp-8FeqOGMZuhwvM_7DbaEp7+LK4nXfCaE@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155293>

=46rom: Sam Reed <sam@reedyboy.net>

Translate the three Git messages from US to British English. These all
had to do with z v.s. s differences.

Signed-off-by: Sam Reed <sam@reedyboy.net>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 po/en_GB.po | 1771 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 1771 insertions(+), 0 deletions(-)
 create mode 100644 po/en_GB.po

diff --git a/po/en_GB.po b/po/en_GB.po
new file mode 100644
index 0000000..b12cd76
--- /dev/null
+++ b/po/en_GB.po
@@ -0,0 +1,1771 @@
+msgid ""
+msgstr ""
+"Project-Id-Version: Git\n"
+"Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
+"POT-Creation-Date: 2010-09-03 17:21+0000\n"
+"Language: en-gb\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+msgid "# Unmerged paths:"
+msgstr ""
+
+#, c-format
+msgid "#   (use \"git reset %s <file>...\" to unstage)"
+msgstr ""
+
+msgid "#   (use \"git rm --cached <file>...\" to unstage)"
+msgstr ""
+
+msgid "#   (use \"git add/rm <file>...\" as appropriate to mark resolu=
tion)"
+msgstr ""
+
+msgid "# Changes to be committed:"
+msgstr ""
+
+msgid "# Changed but not updated:"
+msgstr ""
+
+msgid "#   (use \"git add <file>...\" to update what will be committed=
)"
+msgstr ""
+
+msgid "#   (use \"git add/rm <file>...\" to update what will be commit=
ted)"
+msgstr ""
+
+msgid ""
+"#   (use \"git checkout -- <file>...\" to discard changes in working =
"
+"directory)"
+msgstr ""
+
+msgid "#   (commit or discard the untracked or modified content in sub=
modules)"
+msgstr ""
+
+#, c-format
+msgid "# %s files:"
+msgstr ""
+
+#, c-format
+msgid "#   (use \"git %s <file>...\" to include in what will be commit=
ted)"
+msgstr ""
+
+msgid "bug"
+msgstr ""
+
+msgid "both deleted:"
+msgstr ""
+
+msgid "added by us:"
+msgstr ""
+
+msgid "deleted by them:"
+msgstr ""
+
+msgid "added by them:"
+msgstr ""
+
+msgid "deleted by us:"
+msgstr ""
+
+msgid "both added:"
+msgstr ""
+
+msgid "both modified:"
+msgstr ""
+
+msgid "new commits, "
+msgstr ""
+
+msgid "modified content, "
+msgstr ""
+
+msgid "untracked content, "
+msgstr ""
+
+#, c-format
+msgid "new file:   %s"
+msgstr ""
+
+#, c-format
+msgid "copied:     %s -> %s"
+msgstr ""
+
+#, c-format
+msgid "deleted:    %s"
+msgstr ""
+
+#, c-format
+msgid "modified:   %s"
+msgstr ""
+
+#, c-format
+msgid "renamed:    %s -> %s"
+msgstr ""
+
+#, c-format
+msgid "typechange: %s"
+msgstr ""
+
+#, c-format
+msgid "unknown:    %s"
+msgstr ""
+
+#, c-format
+msgid "unmerged:   %s"
+msgstr ""
+
+#, c-format
+msgid "bug: unhandled diff status %c"
+msgstr ""
+
+msgid "On branch "
+msgstr ""
+
+msgid "Not currently on any branch."
+msgstr ""
+
+msgid "# Initial commit"
+msgstr ""
+
+msgid "Untracked"
+msgstr ""
+
+msgid "add"
+msgstr ""
+
+msgid "Ignored"
+msgstr ""
+
+msgid "add -f"
+msgstr ""
+
+#, c-format
+msgid "# Untracked files not listed%s\n"
+msgstr ""
+
+msgid " (use -u option to show untracked files)"
+msgstr ""
+
+#, c-format
+msgid "# No changes\n"
+msgstr ""
+
+#, c-format
+msgid "no changes added to commit%s\n"
+msgstr ""
+
+msgid " (use \"git add\" and/or \"git commit -a\")"
+msgstr ""
+
+#, c-format
+msgid "nothing added to commit but untracked files present%s\n"
+msgstr ""
+
+msgid " (use \"git add\" to track)"
+msgstr ""
+
+msgid " (create/copy files and use \"git add\" to track)"
+msgstr ""
+
+#, c-format
+msgid "nothing to commit%s\n"
+msgstr ""
+
+msgid " (use -u to show untracked files)"
+msgstr ""
+
+msgid " (working directory clean)"
+msgstr ""
+
+msgid "HEAD (no branch)"
+msgstr ""
+
+msgid "Initial commit on "
+msgstr ""
+
+msgid "behind "
+msgstr ""
+
+msgid "ahead "
+msgstr ""
+
+msgid ", behind "
+msgstr ""
+
+#, c-format
+msgid "unexpected diff status %c"
+msgstr ""
+
+msgid "updating files failed"
+msgstr ""
+
+#, c-format
+msgid "remove '%s'\n"
+msgstr ""
+
+#, c-format
+msgid "Path '%s' is in submodule '%.*s'"
+msgstr ""
+
+msgid "Unstaged changes after refreshing the index:"
+msgstr ""
+
+#, c-format
+msgid "pathspec '%s' did not match any files"
+msgstr ""
+
+#, c-format
+msgid "'%s' is beyond a symbolic link"
+msgstr ""
+
+msgid "Could not read the index"
+msgstr ""
+
+#, c-format
+msgid "Could not open '%s' for writing."
+msgstr ""
+
+msgid "Could not write patch"
+msgstr ""
+
+#, c-format
+msgid "Could not stat '%s'"
+msgstr ""
+
+msgid "Empty patch. Aborted."
+msgstr ""
+
+#, c-format
+msgid "Could not apply '%s'"
+msgstr ""
+
+#, c-format
+msgid "Use -f if you really want to add them.\n"
+msgstr ""
+
+msgid "no files added"
+msgstr ""
+
+msgid "adding files failed"
+msgstr ""
+
+msgid "-A and -u are mutually incompatible"
+msgstr ""
+
+msgid "Option --ignore-missing can only be used together with --dry-ru=
n"
+msgstr ""
+
+#, c-format
+msgid "Nothing specified, nothing added.\n"
+msgstr ""
+
+#, c-format
+msgid "Maybe you wanted to say 'git add .'?\n"
+msgstr ""
+
+msgid "index file corrupt"
+msgstr ""
+
+msgid "Unable to write new index file"
+msgstr ""
+
+#, c-format
+msgid ""
+"deleting branch '%s' that has been merged to\n"
+"         '%s', but it is not yet merged to HEAD."
+msgstr ""
+
+#, c-format
+msgid ""
+"not deleting branch '%s' that is not yet merged to\n"
+"         '%s', even though it is merged to HEAD."
+msgstr ""
+
+#. TRANSLATORS: This is "remote " in "remote branch '%s' not found"
+msgid "remote "
+msgstr ""
+
+msgid "cannot use -a with -d"
+msgstr ""
+
+msgid "Couldn't look up commit object for HEAD"
+msgstr ""
+
+#, c-format
+msgid "Cannot delete the branch '%s' which you are currently on."
+msgstr ""
+
+#, c-format
+msgid "%sbranch '%s' not found."
+msgstr ""
+
+#, c-format
+msgid "Couldn't look up commit object for '%s'"
+msgstr ""
+
+#, c-format
+msgid ""
+"The branch '%s' is not fully merged.\n"
+"If you are sure you want to delete it, run 'git branch -D %s'."
+msgstr ""
+
+#, c-format
+msgid "Error deleting %sbranch '%s'"
+msgstr ""
+
+#, c-format
+msgid "Deleted %sbranch %s (was %s).\n"
+msgstr ""
+
+msgid "Update of config-file failed"
+msgstr ""
+
+#, c-format
+msgid "branch '%s' does not point at a commit"
+msgstr ""
+
+#, c-format
+msgid "behind %d] "
+msgstr ""
+
+#, c-format
+msgid "ahead %d] "
+msgstr ""
+
+#, c-format
+msgid "ahead %d, behind %d] "
+msgstr ""
+
+msgid "(no branch)"
+msgstr ""
+
+msgid "some refs could not be read"
+msgstr ""
+
+msgid "cannot rename the current branch while not on any."
+msgstr ""
+
+#, c-format
+msgid "Invalid branch name: '%s'"
+msgstr ""
+
+#, c-format
+msgid "A branch named '%s' already exists."
+msgstr ""
+
+msgid "Branch rename failed"
+msgstr ""
+
+#, c-format
+msgid "Renamed a misnamed branch '%s' away"
+msgstr ""
+
+#, c-format
+msgid "Branch renamed to %s, but HEAD is not updated!"
+msgstr ""
+
+msgid "Branch is renamed, but update of config-file failed"
+msgstr ""
+
+#, c-format
+msgid "malformed object name %s"
+msgstr ""
+
+msgid "Failed to resolve HEAD as a valid ref."
+msgstr ""
+
+msgid "HEAD not found below refs/heads!"
+msgstr ""
+
+msgid "-a and -r options to 'git branch' do not make sense with a bran=
ch name"
+msgstr ""
+
+#, c-format
+msgid "path '%s' does not have our version"
+msgstr ""
+
+#, c-format
+msgid "path '%s' does not have their version"
+msgstr ""
+
+#, c-format
+msgid "path '%s' does not have all three versions"
+msgstr ""
+
+#, c-format
+msgid "path '%s' does not have all 3 versions"
+msgstr ""
+
+#, c-format
+msgid "path '%s': cannot merge"
+msgstr ""
+
+#, c-format
+msgid "Unable to add merge result for '%s'"
+msgstr ""
+
+#, c-format
+msgid "make_cache_entry failed for path '%s'"
+msgstr ""
+
+msgid "corrupt index file"
+msgstr ""
+
+#, c-format
+msgid "path '%s' is unmerged"
+msgstr ""
+
+msgid "unable to write new index file"
+msgstr ""
+
+msgid "diff_setup_done failed"
+msgstr ""
+
+msgid "you need to resolve your current index first"
+msgstr ""
+
+#, c-format
+msgid "Can not do reflog for '%s'\n"
+msgstr ""
+
+#, c-format
+msgid "Already on '%s'\n"
+msgstr ""
+
+#, c-format
+msgid "Switched to and reset branch '%s'\n"
+msgstr ""
+
+#, c-format
+msgid "Switched to a new branch '%s'\n"
+msgstr ""
+
+#, c-format
+msgid "Switched to branch '%s'\n"
+msgstr ""
+
+msgid "HEAD is now at"
+msgstr ""
+
+msgid "You are on a branch yet to be born"
+msgstr ""
+
+msgid "Previous HEAD position was"
+msgstr ""
+
+msgid "-B cannot be used with -b"
+msgstr ""
+
+msgid "--patch is incompatible with all other options"
+msgstr ""
+
+msgid "--track needs a branch name"
+msgstr ""
+
+msgid "Missing branch name; try -b"
+msgstr ""
+
+msgid "--orphan and -b|-B are mutually exclusive"
+msgstr ""
+
+msgid "--orphan cannot be used with -t"
+msgstr ""
+
+msgid "git checkout: -f and -m are incompatible"
+msgstr ""
+
+#. case (1)
+#, c-format
+msgid "invalid reference: %s"
+msgstr ""
+
+#. case (1): want a tree
+#, c-format
+msgid "reference is not a tree: %s"
+msgstr ""
+
+msgid "invalid path specification"
+msgstr ""
+
+#, c-format
+msgid ""
+"git checkout: updating paths is incompatible with switching branches.=
\n"
+"Did you intend to checkout '%s' which can not be resolved as commit?"
+msgstr ""
+
+msgid "git checkout: updating paths is incompatible with switching bra=
nches."
+msgstr ""
+
+msgid ""
+"git checkout: --ours/--theirs, --force and --merge are incompatible w=
hen\n"
+"checking out of the index."
+msgstr ""
+
+#, c-format
+msgid "git checkout: we do not like '%s' as a branch name."
+msgstr ""
+
+#, c-format
+msgid "git checkout: branch %s already exists"
+msgstr ""
+
+msgid "Cannot switch branch to a non-commit."
+msgstr ""
+
+msgid "--ours/--theirs is incompatible with switching branches."
+msgstr ""
+
+#, c-format
+msgid "reference repository '%s' is not a local directory."
+msgstr ""
+
+#, c-format
+msgid "failed to open '%s'"
+msgstr ""
+
+#, c-format
+msgid "failed to create directory '%s'"
+msgstr ""
+
+#, c-format
+msgid "failed to stat '%s'"
+msgstr ""
+
+#, c-format
+msgid "%s exists and is not a directory"
+msgstr ""
+
+#, c-format
+msgid "failed to stat %s\n"
+msgstr ""
+
+#, c-format
+msgid "failed to unlink '%s'"
+msgstr ""
+
+#, c-format
+msgid "failed to create link '%s'"
+msgstr ""
+
+#, c-format
+msgid "failed to copy file to '%s'"
+msgstr ""
+
+#, c-format
+msgid "done.\n"
+msgstr ""
+
+msgid "Too many arguments."
+msgstr ""
+
+msgid "You must specify a repository to clone."
+msgstr ""
+
+#, c-format
+msgid "--bare and --origin %s options are incompatible."
+msgstr ""
+
+#, c-format
+msgid "destination path '%s' already exists and is not an empty direct=
ory."
+msgstr ""
+
+#, c-format
+msgid "working tree '%s' already exists."
+msgstr ""
+
+#, c-format
+msgid "could not create leading directories of '%s'"
+msgstr ""
+
+#, c-format
+msgid "could not create work tree dir '%s'."
+msgstr ""
+
+#, c-format
+msgid "Cloning into bare repository %s"
+msgstr ""
+
+#, c-format
+msgid "Cloning into %s"
+msgstr ""
+
+#, c-format
+msgid "Don't know how to clone %s"
+msgstr ""
+
+#, c-format
+msgid "Remote branch %s not found in upstream %s, using HEAD instead"
+msgstr ""
+
+msgid "You appear to have cloned an empty repository."
+msgstr ""
+
+msgid "remote HEAD refers to nonexistent ref, unable to checkout.\n"
+msgstr ""
+
+msgid ""
+"Your name and email address were configured automatically based\n"
+"on your username and hostname. Please check that they are accurate.\n=
"
+"You can suppress this message by setting them explicitly:\n"
+"\n"
+"    git config --global user.name \"Your Name\"\n"
+"    git config --global user.email you@example.com\n"
+"\n"
+"If the identity used for this commit is wrong, you can fix it with:\n=
"
+"\n"
+"    git commit --amend --author=3D'Your Name <you@example.com>'\n"
+msgstr ""
+
+msgid ""
+"You asked to amend the most recent commit, but doing so would make\n"
+"it empty. You can repeat your command with --allow-empty, or you can\=
n"
+"remove the commit entirely with \"git reset HEAD^\".\n"
+msgstr ""
+
+msgid "failed to unpack HEAD tree object"
+msgstr ""
+
+msgid "interactive add failed"
+msgstr ""
+
+msgid "unable to write new_index file"
+msgstr ""
+
+msgid "cannot do a partial commit during a merge."
+msgstr ""
+
+msgid "cannot read the index"
+msgstr ""
+
+msgid "unable to write temporary index file"
+msgstr ""
+
+msgid "could not parse HEAD commit"
+msgstr ""
+
+#, c-format
+msgid "invalid commit: %s"
+msgstr ""
+
+msgid "malformed --author parameter"
+msgstr ""
+
+#, c-format
+msgid "(reading log message from standard input)\n"
+msgstr ""
+
+msgid "could not read log from standard input"
+msgstr ""
+
+#, c-format
+msgid "could not read log file '%s'"
+msgstr ""
+
+msgid "commit has empty message"
+msgstr ""
+
+msgid "could not read MERGE_MSG"
+msgstr ""
+
+msgid "could not read SQUASH_MSG"
+msgstr ""
+
+#, c-format
+msgid "could not read '%s'"
+msgstr ""
+
+#, c-format
+msgid "could not open '%s'"
+msgstr ""
+
+msgid "could not write commit template"
+msgstr ""
+
+#, c-format
+msgid ""
+"#\n"
+"# It looks like you may be committing a MERGE.\n"
+"# If this is not correct, please remove the file\n"
+"#\t%s\n"
+"# and try again.\n"
+"#\n"
+msgstr ""
+
+#, c-format
+msgid ""
+"\n"
+"# Please enter the commit message for your changes."
+msgstr ""
+
+#, c-format
+msgid ""
+" Lines starting\n"
+"# with '#' will be ignored, and an empty message aborts the commit.\n=
"
+msgstr ""
+
+#, c-format
+msgid ""
+" Lines starting\n"
+"# with '#' will be kept; you may remove them yourself if you want to.=
\n"
+"# An empty message aborts the commit.\n"
+msgstr ""
+
+#, c-format
+msgid "%s# Author:    %s\n"
+msgstr ""
+
+#, c-format
+msgid "%s# Committer: %s\n"
+msgstr ""
+
+msgid "Cannot read index"
+msgstr ""
+
+msgid "Error building trees"
+msgstr ""
+
+#, c-format
+msgid "Please supply the message using either -m or -F option.\n"
+msgstr ""
+
+#, c-format
+msgid "No existing author found with '%s'"
+msgstr ""
+
+#, c-format
+msgid "Invalid untracked files mode '%s'"
+msgstr ""
+
+msgid "Using both --reset-author and --author does not make sense"
+msgstr ""
+
+msgid "You have nothing to amend."
+msgstr ""
+
+msgid "You are in the middle of a merge -- cannot amend."
+msgstr ""
+
+msgid "Only one of -c/-C/-F can be used."
+msgstr ""
+
+msgid "Option -m cannot be combined with -c/-C/-F."
+msgstr ""
+
+msgid "--reset-author can be used only with -C, -c or --amend."
+msgstr ""
+
+#, c-format
+msgid "could not lookup commit %s"
+msgstr ""
+
+#, c-format
+msgid "could not parse commit %s"
+msgstr ""
+
+msgid "Only one of --include/--only/--all/--interactive can be used."
+msgstr ""
+
+msgid "No paths with --include/--only does not make sense."
+msgstr ""
+
+msgid "Clever... amending the last one with dirty index."
+msgstr ""
+
+msgid "Explicit paths specified without -i nor -o; assuming --only pat=
hs..."
+msgstr ""
+
+#, c-format
+msgid "Invalid cleanup mode %s"
+msgstr ""
+
+msgid "Paths with -a does not make sense."
+msgstr ""
+
+msgid "Paths with --interactive does not make sense."
+msgstr ""
+
+msgid "couldn't look up newly created commit"
+msgstr ""
+
+msgid "could not parse newly created commit"
+msgstr ""
+
+msgid "detached HEAD"
+msgstr ""
+
+msgid " (root-commit)"
+msgstr ""
+
+#, c-format
+msgid "could not open '%s' for reading"
+msgstr ""
+
+#, c-format
+msgid "Corrupt MERGE_HEAD file (%s)"
+msgstr ""
+
+msgid "could not read MERGE_MODE"
+msgstr ""
+
+#, c-format
+msgid "could not read commit message: %s"
+msgstr ""
+
+#, c-format
+msgid "Aborting commit due to empty commit message.\n"
+msgstr ""
+
+msgid "failed to write commit object"
+msgstr ""
+
+msgid "cannot lock HEAD ref"
+msgstr ""
+
+msgid "cannot update HEAD ref"
+msgstr ""
+
+msgid ""
+"Repository has been updated, but unable to write\n"
+"new_index file. Check that disk is not full or quota is\n"
+"not exceeded, and then \"git reset HEAD\" to recover."
+msgstr ""
+
+#, c-format
+msgid "'%s': not a regular file or symlink"
+msgstr ""
+
+#, c-format
+msgid "invalid option: %s"
+msgstr ""
+
+msgid "Not a git repository"
+msgstr ""
+
+msgid "No HEAD commit to compare with (yet)"
+msgstr ""
+
+#, c-format
+msgid "invalid object '%s' given."
+msgstr ""
+
+#, c-format
+msgid "more than %d trees given: '%s'"
+msgstr ""
+
+#, c-format
+msgid "more than two blobs given: '%s'"
+msgstr ""
+
+#, c-format
+msgid "unhandled object '%s' given."
+msgstr ""
+
+msgid "Couldn't find remote ref HEAD"
+msgstr ""
+
+#, c-format
+msgid "object %s not found"
+msgstr ""
+
+msgid "[up to date]"
+msgstr ""
+
+#.
+#. * If this is the head, and it's not okay to update
+#. * the head, and the old value of the head isn't empty...
+#.
+#, c-format
+msgid "! %-*s %-*s -> %s  (can't fetch in current branch)"
+msgstr ""
+
+msgid "[rejected]"
+msgstr ""
+
+msgid "[tag update]"
+msgstr ""
+
+msgid "  (unable to update local ref)"
+msgstr ""
+
+#, c-format
+msgid "cannot open %s: %s\n"
+msgstr ""
+
+msgid "branch"
+msgstr ""
+
+msgid "tag"
+msgstr ""
+
+msgid "remote branch"
+msgstr ""
+
+#, c-format
+msgid "From %.*s\n"
+msgstr ""
+
+#, c-format
+msgid ""
+"some local refs could not be updated; try running\n"
+" 'git remote prune %s' to remove any old, conflicting branches"
+msgstr ""
+
+msgid "could not run rev-list"
+msgstr ""
+
+#, c-format
+msgid "failed write to rev-list: %s"
+msgstr ""
+
+#, c-format
+msgid "failed to close rev-list's stdin: %s"
+msgstr ""
+
+#, c-format
+msgid "   (%s will become dangling)\n"
+msgstr ""
+
+#, c-format
+msgid "   (%s has become dangling)\n"
+msgstr ""
+
+msgid "[deleted]"
+msgstr ""
+
+msgid "(none)"
+msgstr ""
+
+#, c-format
+msgid "Refusing to fetch into current branch %s of non-bare repository=
"
+msgstr ""
+
+#, c-format
+msgid "Don't know how to fetch from %s"
+msgstr ""
+
+#, c-format
+msgid "Option \"%s\" value \"%s\" is not valid for %s"
+msgstr ""
+
+#, c-format
+msgid "Option \"%s\" is ignored for %s\n"
+msgstr ""
+
+#, c-format
+msgid "Fetching %s\n"
+msgstr ""
+
+#, c-format
+msgid "Could not fetch %s"
+msgstr ""
+
+msgid ""
+"No remote repository specified.  Please, specify either a URL or a\n"
+"remote name from which new revisions should be fetched."
+msgstr ""
+
+msgid "You need to specify a tag name."
+msgstr ""
+
+msgid "fetch --all does not take a repository argument"
+msgstr ""
+
+msgid "fetch --all does not make sense with refspecs"
+msgstr ""
+
+#, c-format
+msgid "No such remote or remote group: %s"
+msgstr ""
+
+msgid "Fetching a group and specifying refspecs does not make sense"
+msgstr ""
+
+#, c-format
+msgid "grep: failed to create thread: %s"
+msgstr ""
+
+#, c-format
+msgid "'%s': unable to read %s"
+msgstr ""
+
+#, c-format
+msgid "'%s': %s"
+msgstr ""
+
+#, c-format
+msgid "'%s': short read %s"
+msgstr ""
+
+#, c-format
+msgid "Failed to chdir: %s"
+msgstr ""
+
+#, c-format
+msgid "unable to read tree (%s)"
+msgstr ""
+
+#, c-format
+msgid "unable to grep from object of type %s"
+msgstr ""
+
+#, c-format
+msgid "switch `%c' expects a numerical value"
+msgstr ""
+
+#, c-format
+msgid "cannot open '%s'"
+msgstr ""
+
+msgid "no pattern given."
+msgstr ""
+
+msgid "cannot mix --fixed-strings and regexp"
+msgstr ""
+
+#, c-format
+msgid "bad object %s"
+msgstr ""
+
+msgid "--open-files-in-pager only works on the worktree"
+msgstr ""
+
+msgid "--cached cannot be used with --no-index."
+msgstr ""
+
+msgid "--no-index cannot be used with revs."
+msgstr ""
+
+msgid "both --cached and trees are given."
+msgstr ""
+
+#, c-format
+msgid "Could not make %s writable by group"
+msgstr ""
+
+#, c-format
+msgid "insanely long template name %s"
+msgstr ""
+
+#, c-format
+msgid "cannot stat '%s'"
+msgstr ""
+
+#, c-format
+msgid "cannot stat template '%s'"
+msgstr ""
+
+#, c-format
+msgid "cannot opendir '%s'"
+msgstr ""
+
+#, c-format
+msgid "cannot readlink '%s'"
+msgstr ""
+
+#, c-format
+msgid "insanely long symlink %s"
+msgstr ""
+
+#, c-format
+msgid "cannot symlink '%s' '%s'"
+msgstr ""
+
+#, c-format
+msgid "cannot copy '%s' to '%s'"
+msgstr ""
+
+#, c-format
+msgid "ignoring template %s"
+msgstr ""
+
+#, c-format
+msgid "insanely long template path %s"
+msgstr ""
+
+#, c-format
+msgid "templates not found %s"
+msgstr ""
+
+#, c-format
+msgid "not copying templates of a wrong format version %d from '%s'"
+msgstr ""
+
+#, c-format
+msgid "insane git directory %s"
+msgstr ""
+
+#. TRANSLATORS: The first '%s' is either "Reinitialized
+#. existing" or "Initialized empty", the second " shared" or
+#. "", and the last '%s%s' is the verbatim directory name.
+#, c-format
+msgid "%s%s Git repository in %s%s\n"
+msgstr ""
+
+msgid "Reinitialized existing"
+msgstr "Reinitialised existing"
+
+msgid "Initialized empty"
+msgstr "Initialised empty"
+
+msgid " shared"
+msgstr ""
+
+msgid "cannot tell cwd"
+msgstr ""
+
+#, c-format
+msgid "cannot mkdir %s"
+msgstr ""
+
+#, c-format
+msgid "cannot chdir to %s"
+msgstr ""
+
+#, c-format
+msgid ""
+"%s (or --work-tree=3D<directory>) not allowed without specifying %s (=
or --git-"
+"dir=3D<directory>)"
+msgstr ""
+
+msgid "Cannot access current working directory"
+msgstr ""
+
+#, c-format
+msgid "Cannot access work tree '%s'"
+msgstr ""
+
+#, c-format
+msgid "invalid --decorate option: %s"
+msgstr ""
+
+#, c-format
+msgid "unrecognized argument: %s"
+msgstr "unrecognised argument: %s"
+
+#, c-format
+msgid "Final output: %d %s\n"
+msgstr ""
+
+msgid "revision walk setup failed"
+msgstr ""
+
+#, c-format
+msgid "Could not read object %s"
+msgstr ""
+
+#, c-format
+msgid "Unknown type: %d"
+msgstr ""
+
+msgid "format.headers without value"
+msgstr ""
+
+msgid "name of output directory is too long"
+msgstr ""
+
+#, c-format
+msgid "Cannot open patch file %s"
+msgstr ""
+
+msgid "Need exactly one range."
+msgstr ""
+
+msgid "Not a range."
+msgstr ""
+
+msgid "Could not extract email from committer identity."
+msgstr ""
+
+msgid ""
+"*** SUBJECT HERE ***\n"
+"\n"
+"*** BLURB HERE ***\n"
+msgstr ""
+
+msgid "Cover letter needs email format"
+msgstr ""
+
+#, c-format
+msgid "insane in-reply-to: %s"
+msgstr ""
+
+msgid "Two output directories?"
+msgstr ""
+
+#, c-format
+msgid "bogus committer info %s"
+msgstr ""
+
+msgid "-n and -k are mutually exclusive."
+msgstr ""
+
+msgid "--subject-prefix and -k are mutually exclusive."
+msgstr ""
+
+msgid "--name-only does not make sense"
+msgstr ""
+
+msgid "--name-status does not make sense"
+msgstr ""
+
+msgid "--check does not make sense"
+msgstr ""
+
+msgid "standard output, or directory, which one?"
+msgstr ""
+
+#, c-format
+msgid "Could not create directory '%s'"
+msgstr ""
+
+msgid "Failed to create output files"
+msgstr ""
+
+#, c-format
+msgid ""
+"Could not find a tracked remote branch, please specify <upstream> man=
ually.\n"
+msgstr ""
+
+#, c-format
+msgid "Unknown commit %s"
+msgstr ""
+
+msgid "switch `m' requires a value"
+msgstr ""
+
+#, c-format
+msgid "Could not find merge strategy '%s'.\n"
+msgstr ""
+
+#, c-format
+msgid "Available strategies are:"
+msgstr ""
+
+#, c-format
+msgid "Available custom strategies are:"
+msgstr ""
+
+msgid "could not run stash."
+msgstr ""
+
+msgid "stash failed"
+msgstr ""
+
+#, c-format
+msgid "not a valid object: %s"
+msgstr ""
+
+msgid "read-tree failed"
+msgstr ""
+
+msgid " (nothing to squash)"
+msgstr ""
+
+#, c-format
+msgid "Squash commit -- not updating HEAD\n"
+msgstr ""
+
+#, c-format
+msgid "Could not write to '%s'"
+msgstr ""
+
+msgid "Writing SQUASH_MSG"
+msgstr ""
+
+msgid "Finishing SQUASH_MSG"
+msgstr ""
+
+#, c-format
+msgid "No merge message -- not updating HEAD\n"
+msgstr ""
+
+#, c-format
+msgid "'%s' does not point to a commit"
+msgstr ""
+
+#, c-format
+msgid "Bad branch.%s.mergeoptions string: %s"
+msgstr ""
+
+msgid "git write-tree failed to write a tree"
+msgstr ""
+
+msgid "failed to read the cache"
+msgstr ""
+
+msgid "Unable to write index."
+msgstr ""
+
+msgid "Not handling anything other than two heads merge."
+msgstr ""
+
+#, c-format
+msgid "Unknown option for merge-recursive: -X%s"
+msgstr ""
+
+#, c-format
+msgid "unable to write %s"
+msgstr ""
+
+#, c-format
+msgid "Wonderful.\n"
+msgstr ""
+
+msgid "In-index merge"
+msgstr ""
+
+#, c-format
+msgid "Merge made by %s."
+msgstr ""
+
+#, c-format
+msgid "Could not open '%s' for writing"
+msgstr ""
+
+#, c-format
+msgid "Automatic merge failed; fix conflicts and then commit the resul=
t.\n"
+msgstr ""
+
+#, c-format
+msgid "'%s' is not a commit"
+msgstr ""
+
+msgid ""
+"You have not concluded your merge (MERGE_HEAD exists).\n"
+"Please, commit your changes before you can merge."
+msgstr ""
+
+msgid "You have not concluded your merge (MERGE_HEAD exists)."
+msgstr ""
+
+msgid "You cannot combine --squash with --no-ff."
+msgstr ""
+
+msgid "You cannot combine --no-ff with --ff-only."
+msgstr ""
+
+msgid "Can merge only exactly one commit into empty head"
+msgstr ""
+
+msgid "Squash commit into empty head not supported yet"
+msgstr ""
+
+msgid "Non-fast-forward commit does not make sense into an empty head"
+msgstr ""
+
+#, c-format
+msgid "%s - not something we can merge"
+msgstr ""
+
+#.
+#. * If head can reach all the merge then we are up to date.
+#. * but first the most common case of merging one remote.
+#.
+msgid "Already up-to-date."
+msgstr ""
+
+#, c-format
+msgid "Updating %s..%s\n"
+msgstr ""
+
+msgid "Fast-forward"
+msgstr ""
+
+msgid " (no commit created; -m option ignored)"
+msgstr ""
+
+#, c-format
+msgid "Trying really trivial in-index merge...\n"
+msgstr ""
+
+#, c-format
+msgid "Nope.\n"
+msgstr ""
+
+msgid "Already up-to-date. Yeeah!"
+msgstr ""
+
+msgid "Not possible to fast-forward, aborting."
+msgstr ""
+
+#, c-format
+msgid "Rewinding the tree to pristine...\n"
+msgstr ""
+
+#, c-format
+msgid "Trying merge strategy %s...\n"
+msgstr ""
+
+#, c-format
+msgid "No merge strategy handled the merge.\n"
+msgstr ""
+
+#, c-format
+msgid "Merge with strategy %s failed.\n"
+msgstr ""
+
+#, c-format
+msgid "Using the %s to prepare resolving by hand.\n"
+msgstr ""
+
+#, c-format
+msgid "Automatic merge went well; stopped before committing as request=
ed\n"
+msgstr ""
+
+#, c-format
+msgid "Checking rename of '%s' to '%s'\n"
+msgstr ""
+
+msgid "bad source"
+msgstr ""
+
+msgid "can not move directory into itself"
+msgstr ""
+
+msgid "cannot move directory over file"
+msgstr ""
+
+#, c-format
+msgid "Huh? %.*s is in index?"
+msgstr ""
+
+msgid "source directory is empty"
+msgstr ""
+
+msgid "not under version control"
+msgstr ""
+
+msgid "destination exists"
+msgstr ""
+
+#, c-format
+msgid "%s; will overwrite!"
+msgstr ""
+
+msgid "Cannot overwrite"
+msgstr ""
+
+msgid "multiple sources for the same target"
+msgstr ""
+
+#, c-format
+msgid "%s, source=3D%s, destination=3D%s"
+msgstr ""
+
+#, c-format
+msgid "Renaming %s to %s\n"
+msgstr ""
+
+#, c-format
+msgid "renaming '%s' failed"
+msgstr ""
+
+msgid "tag shorthand without <tag>"
+msgstr ""
+
+msgid "--delete only accepts plain target ref names"
+msgstr ""
+
+msgid "You are not currently on a branch."
+msgstr ""
+
+#, c-format
+msgid "The current branch %s is not tracking anything."
+msgstr ""
+
+#, c-format
+msgid "The current branch %s is tracking multiple branches, refusing t=
o push."
+msgstr ""
+
+msgid ""
+"You didn't specify any refspecs to push, and push.default is \"nothin=
g\"."
+msgstr ""
+
+#, c-format
+msgid "Pushing to %s\n"
+msgstr ""
+
+#, c-format
+msgid "failed to push some refs to '%s'"
+msgstr ""
+
+#, c-format
+msgid ""
+"To prevent you from losing history, non-fast-forward updates were rej=
ected\n"
+"Merge the remote changes (e.g. 'git pull') before pushing again.  See=
 the\n"
+"'Note about fast-forwards' section of 'git push --help' for details.\=
n"
+msgstr ""
+
+#, c-format
+msgid "bad repository '%s'"
+msgstr ""
+
+msgid "No destination configured to push to."
+msgstr ""
+
+msgid "--all and --tags are incompatible"
+msgstr ""
+
+msgid "--all can't be combined with refspecs"
+msgstr ""
+
+msgid "--mirror and --tags are incompatible"
+msgstr ""
+
+msgid "--mirror can't be combined with refspecs"
+msgstr ""
+
+msgid "--all and --mirror are incompatible"
+msgstr ""
+
+msgid "--delete is incompatible with --all, --mirror and --tags"
+msgstr ""
+
+msgid "--delete doesn't make sense without any refs"
+msgstr ""
+
+msgid "mixed"
+msgstr ""
+
+msgid "soft"
+msgstr ""
+
+msgid "hard"
+msgstr ""
+
+msgid "merge"
+msgstr ""
+
+msgid "keep"
+msgstr ""
+
+msgid "You do not have a valid HEAD."
+msgstr ""
+
+msgid "Failed to find tree of HEAD."
+msgstr ""
+
+#, c-format
+msgid "Failed to find tree of %s."
+msgstr ""
+
+msgid "Could not write new index file."
+msgstr ""
+
+#, c-format
+msgid "HEAD is now at %s"
+msgstr ""
+
+msgid "Could not read index"
+msgstr ""
+
+msgid "Unstaged changes after reset:"
+msgstr ""
+
+#, c-format
+msgid "Reflog action message too long: %.*s..."
+msgstr ""
+
+#, c-format
+msgid "Cannot do a %s reset in the middle of a merge."
+msgstr ""
+
+#, c-format
+msgid "Failed to resolve '%s' as a valid ref."
+msgstr ""
+
+#, c-format
+msgid "Could not parse object '%s'."
+msgstr ""
+
+msgid "--patch is incompatible with --{hard,mixed,soft}"
+msgstr ""
+
+msgid "--mixed with paths is deprecated; use 'git reset -- <paths>' in=
stead."
+msgstr ""
+
+#, c-format
+msgid "Cannot do %s reset with paths."
+msgstr ""
+
+#, c-format
+msgid "%s reset is not allowed in a bare repository"
+msgstr ""
+
+#, c-format
+msgid "Could not reset index file to revision '%s'."
+msgstr ""
+
+#, c-format
+msgid ""
+"'%s' has staged content different from both the file and the HEAD\n"
+"(use -f to force removal)"
+msgstr ""
+
+#, c-format
+msgid ""
+"'%s' has changes staged in the index\n"
+"(use --cached to keep the file, or -f to force removal)"
+msgstr ""
+
+#, c-format
+msgid ""
+"'%s' has local modifications\n"
+"(use --cached to keep the file, or -f to force removal)"
+msgstr ""
+
+#, c-format
+msgid "not removing '%s' recursively without -r"
+msgstr ""
+
+#, c-format
+msgid "git rm: unable to remove %s"
+msgstr ""
+
+#, c-format
+msgid "tag name too long: %.*s..."
+msgstr ""
+
+#, c-format
+msgid "tag '%s' not found."
+msgstr ""
+
+#, c-format
+msgid "Deleted tag '%s' (was %s)\n"
+msgstr ""
+
+#, c-format
+msgid "could not verify the tag '%s'"
+msgstr ""
+
+msgid "committer info too long."
+msgstr ""
+
+msgid "could not run gpg."
+msgstr ""
+
+msgid "gpg did not accept the tag data"
+msgstr ""
+
+msgid "gpg failed to sign the tag"
+msgstr ""
+
+msgid ""
+"\n"
+"#\n"
+"# Write a tag message\n"
+"#\n"
+msgstr ""
+
+#, c-format
+msgid "signing key value too long (%.10s...)"
+msgstr ""
+
+msgid "unable to sign the tag"
+msgstr ""
+
+msgid "unable to write tag file"
+msgstr ""
+
+msgid "bad object type."
+msgstr ""
+
+msgid "tag header too big."
+msgstr ""
+
+#, c-format
+msgid "could not create file '%s'"
+msgstr ""
+
+msgid "no tag message?"
+msgstr ""
+
+#, c-format
+msgid "The tag message has been left in %s\n"
+msgstr ""
+
+msgid "-n option is only allowed with -l."
+msgstr ""
+
+msgid "--contains option is only allowed with -l."
+msgstr ""
+
+msgid "only one -F or -m option is allowed."
+msgstr ""
+
+#, c-format
+msgid "cannot read '%s'"
+msgstr ""
+
+#, c-format
+msgid "could not open or read '%s'"
+msgstr ""
+
+msgid "too many params"
+msgstr ""
+
+#, c-format
+msgid "'%s' is not a valid tag name."
+msgstr ""
+
+#, c-format
+msgid "tag '%s' already exists"
+msgstr ""
+
+#, c-format
+msgid "%s: cannot lock the ref"
+msgstr ""
+
+#, c-format
+msgid "%s: cannot update the ref"
+msgstr ""
+
+#, c-format
+msgid "Updated tag '%s' (was %s)\n"
+msgstr ""
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+msgid "See 'git help COMMAND' for more information on a specific comma=
nd."
+msgstr ""
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+msgid "TEST: A C test string"
+msgstr ""
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#, c-format
+msgid "TEST: A C test string %s"
+msgstr ""
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#, c-format
+msgid "TEST: Hello World!"
+msgstr ""
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#, c-format
+msgid "TEST: Old English Runes"
+msgstr ""
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#, c-format
+msgid "TEST: =E2=80=98single=E2=80=99 and =E2=80=9Cdouble=E2=80=9D quo=
tes"
+msgstr ""
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+msgid "TEST: A Shell test string"
+msgstr ""
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#, sh-format
+msgid "TEST: A Shell test $variable"
+msgstr ""
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+msgid "TEST: A Perl test string"
+msgstr ""
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#, perl-format
+msgid "TEST: A Perl test variable %s"
+msgstr ""
--=20
1.7.2.2.336.g704fc
