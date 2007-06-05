From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] add git-filter-branch to .gitignore
Date: Tue, 5 Jun 2007 15:26:12 +0200
Message-ID: <20070605132612.GA5262@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 15:26:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvZ3J-000259-6M
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 15:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758438AbXFEN0Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 09:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758872AbXFEN0Q
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 09:26:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:46871 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758438AbXFEN0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 09:26:16 -0400
Received: (qmail invoked by alias); 05 Jun 2007 13:26:14 -0000
Received: from pD9EBB5EC.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.181.236]
  by mail.gmx.net (mp047) with SMTP; 05 Jun 2007 15:26:14 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX18YNLJwTdcY8IJ/6RE+c61y+OEzcwY8rgn/oVa4ml
	WtS1Apf5fXmI8x
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49197>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 15aed70..ff907de 100644
--- a/.gitignore
+++ b/.gitignore
@@ -40,6 +40,7 @@ git-fast-import
 git-fetch
 git-fetch--tool
 git-fetch-pack
+git-filter-branch
 git-findtags
 git-fmt-merge-msg
 git-for-each-ref
-- 
1.5.2.1.122.g91581
