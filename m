From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [PATCH] Add git-quiltimport to .gitignore.
Date: Tue, 23 May 2006 10:10:09 +0200
Message-ID: <20060523081009.GA4038@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue May 23 10:10:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiRy4-0005k3-8d
	for gcvg-git@gmane.org; Tue, 23 May 2006 10:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWEWIKM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 04:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWEWIKM
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 04:10:12 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:36069 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S1751304AbWEWIKL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 04:10:11 -0400
Received: (qmail 4537 invoked by uid 5842); 23 May 2006 10:10:09 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20574>

From: Peter Eriksen <s022018@student.dtu.dk>
Date: Mon, 22 May 2006 15:46:25 +0200

Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>


---

24b65a30015aeddc9e1e90432e34b144cf8a3f30
 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

24b65a30015aeddc9e1e90432e34b144cf8a3f30
diff --git a/.gitignore b/.gitignore
index b5959d6..199cc31 100644
--- a/.gitignore
+++ b/.gitignore
@@ -77,6 +77,7 @@ git-prune
 git-prune-packed
 git-pull
 git-push
+git-quiltimport
 git-read-tree
 git-rebase
 git-receive-pack
-- 
1.3.3.g288c
