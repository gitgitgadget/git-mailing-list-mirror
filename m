From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 4/4] Fix a typo in the "add" command's documentation
Date: Mon, 14 Nov 2005 11:51:02 -0500
Message-ID: <20051114165101.22202.91257.stgit@dexter.citi.umich.edu>
References: <20051114165007.22202.69803.stgit@dexter.citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Nov 14 17:53:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbhY0-0002xN-67
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 17:51:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbVKNQvE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 11:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbVKNQvD
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 11:51:03 -0500
Received: from citi.umich.edu ([141.211.133.111]:93 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751191AbVKNQvC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Nov 2005 11:51:02 -0500
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id E0FB21BB9A
	for <git@vger.kernel.org>; Mon, 14 Nov 2005 11:51:01 -0500 (EST)
To: git@vger.kernel.org
In-Reply-To: <20051114165007.22202.69803.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11821>

Signed-off-by: J. Bruce Fields <bfields@fieldses.org>
Signed-off-by: Chuck Lever <cel@netapp.com>
---

 stgit/commands/add.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/stgit/commands/add.py b/stgit/commands/add.py
index 999ce2b..fc9c5a7 100644
--- a/stgit/commands/add.py
+++ b/stgit/commands/add.py
@@ -27,7 +27,7 @@ from stgit import stack, git
 help = 'add files or directories to the repository'
 usage = """%prog [options] <files/dirs...>
 
-Add a the files or directories passed as arguments to the
+Add the files or directories passed as arguments to the
 repository. When a directory name is given, all the files and
 subdirectories are recursively added."""
 
