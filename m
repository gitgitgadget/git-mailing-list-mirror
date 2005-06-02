From: Peter Hagervall <hager@cs.umu.se>
Subject: [PATCH] Spelling fixes for git tutorial
Date: Thu, 2 Jun 2005 09:39:21 +0200
Message-ID: <20050602073920.GA526@peppar.cs.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 09:38:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdkGw-0005Bx-8Z
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 09:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVFBHkI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 03:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVFBHjl
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 03:39:41 -0400
Received: from scrat.cs.umu.se ([130.239.40.18]:56250 "EHLO scrat.cs.umu.se")
	by vger.kernel.org with ESMTP id S261598AbVFBHjX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 03:39:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id 10A23180122;
	Thu,  2 Jun 2005 09:39:23 +0200 (CEST)
Received: from peppar.cs.umu.se (peppar.cs.umu.se [130.239.40.13])
	by scrat.cs.umu.se (Postfix) with ESMTP id 9940D180121;
	Thu,  2 Jun 2005 09:39:21 +0200 (CEST)
Received: by peppar.cs.umu.se (Postfix, from userid 12006)
	id 65E5B2EBAB; Thu,  2 Jun 2005 09:39:21 +0200 (MEST)
To: torvalds@osdl.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Virus-Scanned: by amavisd-new at cs.umu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Fix a few spellos in the otherwise excellent tutorial.

Signed-off-by: Peter Hagervall <hager@cs.umu.se>


diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -405,7 +405,7 @@ can do
 	git log
 
 which shows just the log messages, or if we want to see the log together
-whith the associated patches use the more complex (and much more
+with the associated patches use the more complex (and much more
 powerful)
 
 	git-whatchanged -p --root
@@ -423,10 +423,10 @@ With that, you should now be having some
 can explore on your own.
 
 
-	Copoying archives
+	Copying archives
 	-----------------
 
-Git arhives are normally totally self-sufficient, and it's worth noting
+Git archives are normally totally self-sufficient, and it's worth noting
 that unlike CVS, for example, there is no separate notion of
 "repository" and "working tree".  A git repository normally _is_ the
 working tree, with the local git information hidden in the ".git"
@@ -486,7 +486,7 @@ actual core git files. Such a repository
 repository.
 
 To create your own local live copy of such a "raw" git repository, you'd
-first create your own subdirectory for the project, adn then copy the
+first create your own subdirectory for the project, and then copy the
 raw repository contents into the ".git" directory. For example, to
 create your own copy of the git repository, you'd do the following
 
@@ -512,7 +512,7 @@ older version of a checked out tree you 
 file first, to tell git-checkout-cache to _force_ overwriting of any old
 files). 
 
-You have now successfully copied somebody elses (mine) remote
+You have now successfully copied somebody else's (mine) remote
 repository, and checked it out. 
 
 [ to be continued.. cvs2git, tagging versions, branches, merging.. ]
