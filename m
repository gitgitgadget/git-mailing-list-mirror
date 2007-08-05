From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add 'test-absolute-path' to .gitignore
Date: Sun, 5 Aug 2007 06:14:02 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708050613470.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 07:14:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHYS1-0006dV-Be
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 07:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224AbXHEFOh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 01:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752360AbXHEFOg
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 01:14:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:45756 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752220AbXHEFOf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 01:14:35 -0400
Received: (qmail invoked by alias); 05 Aug 2007 05:14:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 05 Aug 2007 07:14:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18p7F51YU8pHH9QepLjB4/g4XuggJVt6W/+vlkV7K
	Q41wiXEVn4SUln
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54949>


Noticed by Randal Schwartz.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 20ee642..63c918c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -148,6 +148,7 @@ git-write-tree
 git-core-*/?*
 gitk-wish
 gitweb/gitweb.cgi
+test-absolute-path
 test-chmtime
 test-date
 test-delta
-- 
1.5.3.rc4.1.g7805
