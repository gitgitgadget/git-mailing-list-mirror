From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] ignore git-rebase--interactive
Date: Tue, 26 Jun 2007 15:38:42 +0200
Message-ID: <20070626133842.GA16466@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 26 15:38:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3BFm-0007Yc-TV
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 15:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755312AbXFZNip (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 09:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755168AbXFZNip
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 09:38:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:54855 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755154AbXFZNio (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 09:38:44 -0400
Received: (qmail invoked by alias); 26 Jun 2007 13:38:43 -0000
Received: from pD9EBB580.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.181.128]
  by mail.gmx.net (mp041) with SMTP; 26 Jun 2007 15:38:43 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1/v5SAIXgrv+e/zHCppmLycLXvYnAX+LAWy44QpIf
	hAgw4Js6QaSKIv
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50963>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index e8b060c..a2a617d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -96,6 +96,7 @@ git-push
 git-quiltimport
 git-read-tree
 git-rebase
+git-rebase--interactive
 git-receive-pack
 git-reflog
 git-relink
-- 
1.5.2.2.1345.gbf4a0
