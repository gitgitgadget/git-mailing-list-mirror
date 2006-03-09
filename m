From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 3/3] Remove trailing dot after short description
Date: Thu, 9 Mar 2006 17:24:50 +0100
Message-ID: <20060309162450.GD4484@c165.ib.student.liu.se>
References: <20060309161722.GA4484@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Mar 09 17:25:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHNwu-0006rn-BB
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 17:25:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422639AbWCIQYx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 11:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422648AbWCIQYx
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 11:24:53 -0500
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:11652 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S1422639AbWCIQYv
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Mar 2006 11:24:51 -0500
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id F11634102; Thu,  9 Mar 2006 17:40:24 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1FHNwY-00063D-00; Thu, 09 Mar 2006 17:24:50 +0100
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060309161722.GA4484@c165.ib.student.liu.se>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17422>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 Documentation/git-add.txt               |    2 +-
 Documentation/git-applypatch.txt        |    2 +-
 Documentation/git-branch.txt            |    2 +-
 Documentation/git-check-ref-format.txt  |    2 +-
 Documentation/git-checkout.txt          |    2 +-
 Documentation/git-cherry-pick.txt       |    2 +-
 Documentation/git-cherry.txt            |    2 +-
 Documentation/git-clone-pack.txt        |    2 +-
 Documentation/git-clone.txt             |    2 +-
 Documentation/git-count-objects.txt     |    2 +-
 Documentation/git-daemon.txt            |    2 +-
 Documentation/git-describe.txt          |    2 +-
 Documentation/git-diff-stages.txt       |    2 +-
 Documentation/git-diff.txt              |    2 +-
 Documentation/git-fetch-pack.txt        |    2 +-
 Documentation/git-fetch.txt             |    2 +-
 Documentation/git-format-patch.txt      |    2 +-
 Documentation/git-get-tar-commit-id.txt |    2 +-
 Documentation/git-hash-object.txt       |    2 +-
 Documentation/git-http-push.txt         |    2 +-
 Documentation/git-lost-found.txt        |    2 +-
 Documentation/git-ls-remote.txt         |    2 +-
 Documentation/git-ls-tree.txt           |    2 +-
 Documentation/git-mailinfo.txt          |    2 +-
 Documentation/git-mailsplit.txt         |    2 +-
 Documentation/git-mv.txt                |    2 +-
 Documentation/git-name-rev.txt          |    2 +-
 Documentation/git-pack-objects.txt      |    2 +-
 Documentation/git-pack-redundant.txt    |    2 +-
 Documentation/git-patch-id.txt          |    2 +-
 Documentation/git-peek-remote.txt       |    2 +-
 Documentation/git-pull.txt              |    2 +-
 Documentation/git-push.txt              |    2 +-
 Documentation/git-rebase.txt            |    2 +-
 Documentation/git-relink.txt            |    2 +-
 Documentation/git-repo-config.txt       |    2 +-
 Documentation/git-request-pull.txt      |    2 +-
 Documentation/git-reset.txt             |    2 +-
 Documentation/git-rev-parse.txt         |    2 +-
 Documentation/git-revert.txt            |    2 +-
 Documentation/git-rm.txt                |    2 +-
 Documentation/git-send-pack.txt         |    2 +-
 Documentation/git-sh-setup.txt          |    2 +-
 Documentation/git-shortlog.txt          |    2 +-
 Documentation/git-show-branch.txt       |    2 +-
 Documentation/git-show.txt              |    2 +-
 Documentation/git-status.txt            |    2 +-
 Documentation/git-stripspace.txt        |    2 +-
 Documentation/git-unpack-objects.txt    |    2 +-
 Documentation/git-upload-pack.txt       |    2 +-
 Documentation/git-verify-pack.txt       |    2 +-
 Documentation/git-verify-tag.txt        |    2 +-
 Documentation/git-whatchanged.txt       |    2 +-
 53 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 5b7c354..ae24547 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -3,7 +3,7 @@ git-add(1)
 
 NAME
 ----
-git-add - Add files to the index file.
+git-add - Add files to the index file
 
 SYNOPSIS
 --------
diff --git a/Documentation/git-applypatch.txt b/Documentation/git-applypatch.txt
index 5b9037d..2b1ff14 100644
--- a/Documentation/git-applypatch.txt
+++ b/Documentation/git-applypatch.txt
@@ -3,7 +3,7 @@ git-applypatch(1)
 
 NAME
 ----
-git-applypatch - Apply one patch extracted from an e-mail.
+git-applypatch - Apply one patch extracted from an e-mail
 
 
 SYNOPSIS
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index b1bc827..4cd0cb9 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -3,7 +3,7 @@ git-branch(1)
 
 NAME
 ----
-git-branch - Create a new branch, or remove an old one.
+git-branch - Create a new branch, or remove an old one
 
 SYNOPSIS
 --------
diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index f7f84c6..7dc1bdb 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -3,7 +3,7 @@ git-check-ref-format(1)
 
 NAME
 ----
-git-check-ref-format - Make sure ref name is well formed.
+git-check-ref-format - Make sure ref name is well formed
 
 SYNOPSIS
 --------
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index df9a618..556e733 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -3,7 +3,7 @@ git-checkout(1)
 
 NAME
 ----
-git-checkout - Checkout and switch to a branch.
+git-checkout - Checkout and switch to a branch
 
 SYNOPSIS
 --------
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 4f323fa..bfa950c 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -3,7 +3,7 @@ git-cherry-pick(1)
 
 NAME
 ----
-git-cherry-pick - Apply the change introduced by an existing commit.
+git-cherry-pick - Apply the change introduced by an existing commit
 
 SYNOPSIS
 --------
diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
index af87966..9a5e371 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -3,7 +3,7 @@ git-cherry(1)
 
 NAME
 ----
-git-cherry - Find commits not merged upstream.
+git-cherry - Find commits not merged upstream
 
 SYNOPSIS
 --------
diff --git a/Documentation/git-clone-pack.txt b/Documentation/git-clone-pack.txt
index 39906fc..09f43ee 100644
--- a/Documentation/git-clone-pack.txt
+++ b/Documentation/git-clone-pack.txt
@@ -3,7 +3,7 @@ git-clone-pack(1)
 
 NAME
 ----
-git-clone-pack - Clones a repository by receiving packed objects.
+git-clone-pack - Clones a repository by receiving packed objects
 
 
 SYNOPSIS
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 684e4bd..9ac54c2 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -3,7 +3,7 @@ git-clone(1)
 
 NAME
 ----
-git-clone - Clones a repository.
+git-clone - Clones a repository
 
 
 SYNOPSIS
diff --git a/Documentation/git-count-objects.txt b/Documentation/git-count-objects.txt
index 36888d9..47216f4 100644
--- a/Documentation/git-count-objects.txt
+++ b/Documentation/git-count-objects.txt
@@ -3,7 +3,7 @@ git-count-objects(1)
 
 NAME
 ----
-git-count-objects - Reports on unpacked objects.
+git-count-objects - Reports on unpacked objects
 
 SYNOPSIS
 --------
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 2cc6075..924a676 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -3,7 +3,7 @@ git-daemon(1)
 
 NAME
 ----
-git-daemon - A really simple server for git repositories.
+git-daemon - A really simple server for git repositories
 
 SYNOPSIS
 --------
diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index 0efe82a..7a253ea 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -3,7 +3,7 @@ git-describe(1)
 
 NAME
 ----
-git-describe - Show the most recent tag that is reachable from a commit.
+git-describe - Show the most recent tag that is reachable from a commit
 
 
 SYNOPSIS
diff --git a/Documentation/git-diff-stages.txt b/Documentation/git-diff-stages.txt
index 28c60fc..3273918 100644
--- a/Documentation/git-diff-stages.txt
+++ b/Documentation/git-diff-stages.txt
@@ -3,7 +3,7 @@ git-diff-stages(1)
 
 NAME
 ----
-git-diff-stages - Compares content and mode of blobs between stages in an unmerged index file.
+git-diff-stages - Compares content and mode of blobs between stages in an unmerged index file
 
 
 SYNOPSIS
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index ca41634..890931c 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -3,7 +3,7 @@ git-diff(1)
 
 NAME
 ----
-git-diff - Show changes between commits, commit and working tree, etc.
+git-diff - Show changes between commits, commit and working tree, etc
 
 
 SYNOPSIS
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index 913b75b..bff9aa6 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -3,7 +3,7 @@ git-fetch-pack(1)
 
 NAME
 ----
-git-fetch-pack - Receive missing objects from another repository.
+git-fetch-pack - Receive missing objects from another repository
 
 
 SYNOPSIS
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index a67dc34..a9e86fd 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -3,7 +3,7 @@ git-fetch(1)
 
 NAME
 ----
-git-fetch - Download objects and a head from another repository.
+git-fetch - Download objects and a head from another repository
 
 
 SYNOPSIS
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 9ac0636..7c467c5 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -3,7 +3,7 @@ git-format-patch(1)
 
 NAME
 ----
-git-format-patch - Prepare patches for e-mail submission.
+git-format-patch - Prepare patches for e-mail submission
 
 
 SYNOPSIS
diff --git a/Documentation/git-get-tar-commit-id.txt b/Documentation/git-get-tar-commit-id.txt
index 30b1fbf..48805b6 100644
--- a/Documentation/git-get-tar-commit-id.txt
+++ b/Documentation/git-get-tar-commit-id.txt
@@ -3,7 +3,7 @@ git-get-tar-commit-id(1)
 
 NAME
 ----
-git-get-tar-commit-id - Extract commit ID from an archive created using git-tar-tree.
+git-get-tar-commit-id - Extract commit ID from an archive created using git-tar-tree
 
 
 SYNOPSIS
diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index 0924931..04e8d00 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -3,7 +3,7 @@ git-hash-object(1)
 
 NAME
 ----
-git-hash-object - Computes object ID and optionally creates a blob from a file.
+git-hash-object - Computes object ID and optionally creates a blob from a file
 
 
 SYNOPSIS
diff --git a/Documentation/git-http-push.txt b/Documentation/git-http-push.txt
index c7066d6..7e1f894 100644
--- a/Documentation/git-http-push.txt
+++ b/Documentation/git-http-push.txt
@@ -3,7 +3,7 @@ git-http-push(1)
 
 NAME
 ----
-git-http-push - Push missing objects using HTTP/DAV.
+git-http-push - Push missing objects using HTTP/DAV
 
 
 SYNOPSIS
diff --git a/Documentation/git-lost-found.txt b/Documentation/git-lost-found.txt
index 03156f2..f52a9d7 100644
--- a/Documentation/git-lost-found.txt
+++ b/Documentation/git-lost-found.txt
@@ -3,7 +3,7 @@ git-lost-found(1)
 
 NAME
 ----
-git-lost-found - Recover lost refs that luckily have not yet been pruned.
+git-lost-found - Recover lost refs that luckily have not yet been pruned
 
 SYNOPSIS
 --------
diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 66fe60f..ae4c1a2 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -3,7 +3,7 @@ git-ls-remote(1)
 
 NAME
 ----
-git-ls-remote - Look at references other repository has.
+git-ls-remote - Look at references other repository has
 
 
 SYNOPSIS
diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index b92a8b2..5bf6d8b 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -3,7 +3,7 @@ git-ls-tree(1)
 
 NAME
 ----
-git-ls-tree - Lists the contents of a tree object.
+git-ls-tree - Lists the contents of a tree object
 
 
 SYNOPSIS
diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index 8890754..ea0a065 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -3,7 +3,7 @@ git-mailinfo(1)
 
 NAME
 ----
-git-mailinfo - Extracts patch from a single e-mail message.
+git-mailinfo - Extracts patch from a single e-mail message
 
 
 SYNOPSIS
diff --git a/Documentation/git-mailsplit.txt b/Documentation/git-mailsplit.txt
index e0703e9..209e36b 100644
--- a/Documentation/git-mailsplit.txt
+++ b/Documentation/git-mailsplit.txt
@@ -3,7 +3,7 @@ git-mailsplit(1)
 
 NAME
 ----
-git-mailsplit - Totally braindamaged mbox splitter program.
+git-mailsplit - Totally braindamaged mbox splitter program
 
 SYNOPSIS
 --------
diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index 21a8664..207c43a 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -3,7 +3,7 @@ git-mv(1)
 
 NAME
 ----
-git-mv - Move or rename a file, directory or symlink.
+git-mv - Move or rename a file, directory or symlink
 
 
 SYNOPSIS
diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index e37b0b8..6870708 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -3,7 +3,7 @@ git-name-rev(1)
 
 NAME
 ----
-git-name-rev - Find symbolic names for given revs.
+git-name-rev - Find symbolic names for given revs
 
 
 SYNOPSIS
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 567dabf..4991f88 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -3,7 +3,7 @@ git-pack-objects(1)
 
 NAME
 ----
-git-pack-objects - Create a packed archive of objects.
+git-pack-objects - Create a packed archive of objects
 
 
 SYNOPSIS
diff --git a/Documentation/git-pack-redundant.txt b/Documentation/git-pack-redundant.txt
index a81cb97..8fb0659 100644
--- a/Documentation/git-pack-redundant.txt
+++ b/Documentation/git-pack-redundant.txt
@@ -3,7 +3,7 @@ git-pack-redundant(1)
 
 NAME
 ----
-git-pack-redundant - Program used to find redundant pack files.
+git-pack-redundant - Program used to find redundant pack files
 
 
 SYNOPSIS
diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
index c8bd197..723b8cc 100644
--- a/Documentation/git-patch-id.txt
+++ b/Documentation/git-patch-id.txt
@@ -3,7 +3,7 @@ git-patch-id(1)
 
 NAME
 ----
-git-patch-id - Generate a patch ID.
+git-patch-id - Generate a patch ID
 
 SYNOPSIS
 --------
diff --git a/Documentation/git-peek-remote.txt b/Documentation/git-peek-remote.txt
index 915d3f8..a00060c 100644
--- a/Documentation/git-peek-remote.txt
+++ b/Documentation/git-peek-remote.txt
@@ -3,7 +3,7 @@ git-peek-remote(1)
 
 NAME
 ----
-git-peek-remote - Lists the references in a remote repository.
+git-peek-remote - Lists the references in a remote repository
 
 
 SYNOPSIS
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 20175f4..51577fc 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -3,7 +3,7 @@ git-pull(1)
 
 NAME
 ----
-git-pull - Pull and merge from another repository.
+git-pull - Pull and merge from another repository
 
 
 SYNOPSIS
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 6f4a48a..d5b5ca1 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -3,7 +3,7 @@ git-push(1)
 
 NAME
 ----
-git-push - Update remote refs along with associated objects.
+git-push - Update remote refs along with associated objects
 
 
 SYNOPSIS
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f037d12..4d5b546 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -3,7 +3,7 @@ git-rebase(1)
 
 NAME
 ----
-git-rebase - Rebase local commits to new upstream head.
+git-rebase - Rebase local commits to new upstream head
 
 SYNOPSIS
 --------
diff --git a/Documentation/git-relink.txt b/Documentation/git-relink.txt
index 6240535..aca6012 100644
--- a/Documentation/git-relink.txt
+++ b/Documentation/git-relink.txt
@@ -3,7 +3,7 @@ git-relink(1)
 
 NAME
 ----
-git-relink - Hardlink common objects in local repositories.
+git-relink - Hardlink common objects in local repositories
 
 SYNOPSIS
 --------
diff --git a/Documentation/git-repo-config.txt b/Documentation/git-repo-config.txt
index 00efde5..26759a8 100644
--- a/Documentation/git-repo-config.txt
+++ b/Documentation/git-repo-config.txt
@@ -3,7 +3,7 @@ git-repo-config(1)
 
 NAME
 ----
-git-repo-config - Get and set options in .git/config.
+git-repo-config - Get and set options in .git/config
 
 
 SYNOPSIS
diff --git a/Documentation/git-request-pull.txt b/Documentation/git-request-pull.txt
index 2463ec9..478a5fd 100644
--- a/Documentation/git-request-pull.txt
+++ b/Documentation/git-request-pull.txt
@@ -3,7 +3,7 @@ git-request-pull(1)
 
 NAME
 ----
-git-request-pull - Generates a summary of pending changes.
+git-request-pull - Generates a summary of pending changes
 
 SYNOPSIS
 --------
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index b4e737e..b7b9798 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -3,7 +3,7 @@ git-reset(1)
 
 NAME
 ----
-git-reset - Reset current HEAD to the specified state.
+git-reset - Reset current HEAD to the specified state
 
 SYNOPSIS
 --------
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 29b5789..8b95df0 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -3,7 +3,7 @@ git-rev-parse(1)
 
 NAME
 ----
-git-rev-parse - Pick out and massage parameters.
+git-rev-parse - Pick out and massage parameters
 
 
 SYNOPSIS
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index e27c680..71f7815 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -3,7 +3,7 @@ git-revert(1)
 
 NAME
 ----
-git-revert - Revert an existing commit.
+git-revert - Revert an existing commit
 
 SYNOPSIS
 --------
diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index d8a5afa..c9c3088 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -3,7 +3,7 @@ git-rm(1)
 
 NAME
 ----
-git-rm - Remove files from the working tree and from the index.
+git-rm - Remove files from the working tree and from the index
 
 SYNOPSIS
 --------
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 577f06a..08e0705 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -3,7 +3,7 @@ git-send-pack(1)
 
 NAME
 ----
-git-send-pack - Push missing objects packed.
+git-send-pack - Push missing objects packed
 
 
 SYNOPSIS
diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.txt
index 6ef59ac..6742c9b 100644
--- a/Documentation/git-sh-setup.txt
+++ b/Documentation/git-sh-setup.txt
@@ -3,7 +3,7 @@ git-sh-setup(1)
 
 NAME
 ----
-git-sh-setup - Common git shell script setup code.
+git-sh-setup - Common git shell script setup code
 
 SYNOPSIS
 --------
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index bf8db8b..54fb922 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -3,7 +3,7 @@ git-shortlog(1)
 
 NAME
 ----
-git-shortlog - Summarize 'git log' output.
+git-shortlog - Summarize 'git log' output
 
 
 SYNOPSIS
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index e474cd0..d3b6e62 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -3,7 +3,7 @@ git-show-branch(1)
 
 NAME
 ----
-git-show-branch - Show branches and their commits.
+git-show-branch - Show branches and their commits
 
 SYNOPSIS
 --------
diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index 9c359a4..2b4df3f 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -3,7 +3,7 @@ git-show(1)
 
 NAME
 ----
-git-show - Show one commit with difference it introduces.
+git-show - Show one commit with difference it introduces
 
 
 SYNOPSIS
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 753fc08..e446f48 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -3,7 +3,7 @@ git-status(1)
 
 NAME
 ----
-git-status - Show working tree status.
+git-status - Show working tree status
 
 
 SYNOPSIS
diff --git a/Documentation/git-stripspace.txt b/Documentation/git-stripspace.txt
index 528a1b6..3a03dd0 100644
--- a/Documentation/git-stripspace.txt
+++ b/Documentation/git-stripspace.txt
@@ -3,7 +3,7 @@ git-stripspace(1)
 
 NAME
 ----
-git-stripspace - Filter out empty lines.
+git-stripspace - Filter out empty lines
 
 
 SYNOPSIS
diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
index 31ea34d..1828062 100644
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -3,7 +3,7 @@ git-unpack-objects(1)
 
 NAME
 ----
-git-unpack-objects - Unpack objects from a packed archive.
+git-unpack-objects - Unpack objects from a packed archive
 
 
 SYNOPSIS
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index 3d8f8ef..4795e98 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -3,7 +3,7 @@ git-upload-pack(1)
 
 NAME
 ----
-git-upload-pack - Send missing objects packed.
+git-upload-pack - Send missing objects packed
 
 
 SYNOPSIS
diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
index d032280..4962d69 100644
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -3,7 +3,7 @@ git-verify-pack(1)
 
 NAME
 ----
-git-verify-pack - Validate packed git archive files.
+git-verify-pack - Validate packed git archive files
 
 
 SYNOPSIS
diff --git a/Documentation/git-verify-tag.txt b/Documentation/git-verify-tag.txt
index b8a73c4..0f9bdb5 100644
--- a/Documentation/git-verify-tag.txt
+++ b/Documentation/git-verify-tag.txt
@@ -3,7 +3,7 @@ git-verify-tag(1)
 
 NAME
 ----
-git-verify-tag - Check the GPG signature of tag.
+git-verify-tag - Check the GPG signature of tag
 
 SYNOPSIS
 --------
diff --git a/Documentation/git-whatchanged.txt b/Documentation/git-whatchanged.txt
index 6c150b0..f02f939 100644
--- a/Documentation/git-whatchanged.txt
+++ b/Documentation/git-whatchanged.txt
@@ -3,7 +3,7 @@ git-whatchanged(1)
 
 NAME
 ----
-git-whatchanged - Show logs with difference each commit introduces.
+git-whatchanged - Show logs with difference each commit introduces
 
 
 SYNOPSIS
