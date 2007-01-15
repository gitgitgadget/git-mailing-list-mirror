From: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
Subject: [PATCH] Document the -n option for git-log
Date: Mon, 15 Jan 2007 14:51:43 -0500
Message-ID: <11688907032343-git-send-email-jsipek@cs.sunysb.edu>
References: <11688207484174-git-send-email-jsipek@cs.sunysb.edu>
Cc: junkio@cox.net, "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Mon Jan 15 21:37:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6XsE-00081C-V8
	for gcvg-git@gmane.org; Mon, 15 Jan 2007 20:52:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbXAOTvw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 14:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbXAOTvw
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 14:51:52 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:50882 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbXAOTvw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 14:51:52 -0500
Received: from thor.fsl.cs.sunysb.edu (thor.fsl.cs.sunysb.edu [130.245.126.40])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l0FJpgSA025223;
	Mon, 15 Jan 2007 14:51:42 -0500
Received: from jsipek by thor.fsl.cs.sunysb.edu with local (Exim 4.63)
	(envelope-from <jsipek@dhcp42.fsl.cs.sunysb.edu>)
	id 1H6Xrr-0004zn-HA; Mon, 15 Jan 2007 14:51:43 -0500
To: git@vger.kernel.org
X-Mailer: git-send-email 1.5.0.rc1.g696b
In-Reply-To: <11688207484174-git-send-email-jsipek@cs.sunysb.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36878>

Signed-off-by: Josef 'Jeff' Sipek <jsipek@cs.sunysb.edu>
---
 Documentation/git-log.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index e9f746b..c7d6125 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -27,7 +27,7 @@ OPTIONS
 
 include::pretty-formats.txt[]
 
---max-count=<n>::
+-<n>, --max-count=<n>::
 	Limits the number of commits to show.
 
 <since>..<until>::
-- 
1.5.0.rc1.g696b
