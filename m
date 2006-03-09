From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 2/3] Fix some inconsistencies in the docs
Date: Thu, 9 Mar 2006 17:24:37 +0100
Message-ID: <20060309162436.GC4484@c165.ib.student.liu.se>
References: <20060309161722.GA4484@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Mar 09 17:25:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHNwv-0006rn-TR
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 17:25:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422641AbWCIQYj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 11:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422639AbWCIQYi
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 11:24:38 -0500
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:11140 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S1422638AbWCIQYh
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Mar 2006 11:24:37 -0500
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id AB8184102; Thu,  9 Mar 2006 17:40:11 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1FHNwL-00062q-00; Thu, 09 Mar 2006 17:24:37 +0100
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060309161722.GA4484@c165.ib.student.liu.se>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17421>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 Documentation/git-grep.txt |    2 +-
 Documentation/git-mv.txt   |    2 +-
 Documentation/git-tag.txt  |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index bf4b592..fbd2394 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -3,7 +3,7 @@ git-grep(1)
 
 NAME
 ----
-git-grep - print lines matching a pattern
+git-grep - Print lines matching a pattern
 
 
 SYNOPSIS
diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index d242b39..21a8664 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -3,7 +3,7 @@ git-mv(1)
 
 NAME
 ----
-git-mv - Script used to move or rename a file, directory or symlink.
+git-mv - Move or rename a file, directory or symlink.
 
 
 SYNOPSIS
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index e1c76c6..45476c2 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -3,7 +3,7 @@ git-tag(1)
 
 NAME
 ----
-git-tag -  Create a tag object signed with GPG
+git-tag - Create a tag object signed with GPG
 
 
 SYNOPSIS
