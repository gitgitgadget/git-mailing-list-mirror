From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/6] Rename INSTALL to EGIT_INSTALL
Date: Mon,  4 Aug 2008 19:47:12 -0700
Message-ID: <1217904436-1989-3-git-send-email-spearce@spearce.org>
References: <1217904436-1989-1-git-send-email-spearce@spearce.org>
 <1217904436-1989-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 04:48:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQCb2-0006ne-Al
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 04:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757505AbYHECrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 22:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756844AbYHECrV
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 22:47:21 -0400
Received: from george.spearce.org ([209.20.77.23]:45373 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756739AbYHECrT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 22:47:19 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id A7E7238420; Tue,  5 Aug 2008 02:47:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 283BD38368;
	Tue,  5 Aug 2008 02:47:18 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc1.250.g9b5e2
In-Reply-To: <1217904436-1989-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91411>

This document is entirely about how to install the EGit plugins
and has nothing to do with JGit itself.  Later if/when we split the
Git repository into two trees (one for jgit, one for egit) we can
rename this back to just plain INSTALL inside of the EGit repository.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 INSTALL => EGIT_INSTALL |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
 rename INSTALL => EGIT_INSTALL (98%)

diff --git a/INSTALL b/EGIT_INSTALL
similarity index 98%
rename from INSTALL
rename to EGIT_INSTALL
index 76be0a4..142526a 100644
--- a/INSTALL
+++ b/EGIT_INSTALL
@@ -1,5 +1,5 @@
 
-	EGit/JGit installation
+	EGit Installation
 
 PREREQUISITES
 
-- 
1.6.0.rc1.250.g9b5e2
