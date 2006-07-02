From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: [PATCH] Minor documentation fixup.
Date: Sun, 2 Jul 2006 02:07:40 +0200
Message-ID: <200607020207.40552.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8";
  format=fixed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jul 02 02:07:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwpUY-0003Ht-Kl
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 02:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWGBAHL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 20:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWGBAHL
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 20:07:11 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:28563 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751163AbWGBAHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jul 2006 20:07:09 -0400
Received: from [10.3.4.253] (213.67.102.15) by pne-smtpout1-sn2.hy.skanova.net (7.2.075)
        id 44A2E86F000A5FF8 for git@vger.kernel.org; Sun, 2 Jul 2006 02:07:08 +0200
To: git@vger.kernel.org
User-Agent: StGIT/0.10
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23087>

From: Robin Rosenberg <robin.rosenberg@dewire.com>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>

---

 Documentation/git-commit.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 0fe66f2..517a86b 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -15,9 +15,9 @@ SYNOPSIS
 DESCRIPTION
 -----------
 Updates the index file for given paths, or all modified files if
-'-a' is specified, and makes a commit object.  The command
-VISUAL and EDITOR environment variables to edit the commit log
-message.
+'-a' is specified, and makes a commit object.  The command specified
+by either the VISUAL or EDITOR environment variables are used to edit
+the commit log message.
 
 Several environment variable are used during commits.  They are
 documented in gitlink:git-commit-tree[1].
