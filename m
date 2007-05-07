From: Jeff King <peff@peff.net>
Subject: [PATCH] Documentation: don't reference non-existent 'git-cvsapplycommit'
Date: Mon, 7 May 2007 01:28:34 -0400
Message-ID: <20070507052834.GA30988@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 07 07:28:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkvmJ-0001qg-H2
	for gcvg-git@gmane.org; Mon, 07 May 2007 07:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019AbXEGF2j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 01:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754032AbXEGF2j
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 01:28:39 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1709 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754019AbXEGF2i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 01:28:38 -0400
Received: (qmail 320 invoked from network); 7 May 2007 05:28:29 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 7 May 2007 05:28:29 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 07 May 2007 01:28:34 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46416>


Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-cvsexportcommit.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.txt
index 555b823..fd7f540 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -25,7 +25,7 @@ by default.
 
 Supports file additions, removals, and commits that affect binary files.
 
-If the commit is a merge commit, you must tell git-cvsapplycommit what parent
+If the commit is a merge commit, you must tell git-cvsexportcommit what parent
 should the changeset be done against. 
 
 OPTIONS
-- 
1.5.2.rc2.694.g2202
