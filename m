From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/6] Updated egit INSTALL document to mention Eclipse 3.4.0
Date: Mon,  4 Aug 2008 19:47:11 -0700
Message-ID: <1217904436-1989-2-git-send-email-spearce@spearce.org>
References: <1217904436-1989-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 04:48:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQCb1-0006ne-Lp
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 04:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757492AbYHECrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 22:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757434AbYHECrU
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 22:47:20 -0400
Received: from george.spearce.org ([209.20.77.23]:45370 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756844AbYHECrS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 22:47:18 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 3C42138445; Tue,  5 Aug 2008 02:47:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 95BFA38419;
	Tue,  5 Aug 2008 02:47:17 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc1.250.g9b5e2
In-Reply-To: <1217904436-1989-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91410>

Eclipse 3.4.0 is now final.  Also we require at least 3.3.1, but
we really prefer 3.4.0.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 INSTALL |    2 +-
 README  |    3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/INSTALL b/INSTALL
index bb303c1..76be0a4 100644
--- a/INSTALL
+++ b/INSTALL
@@ -6,7 +6,7 @@ PREREQUISITES
 In order to install the Git Eclipse plugin you need to have the following
 things.
 
-- Eclipse version 3.2.1 or later (works up to 3.4 M1).
+- Eclipse version 3.3.1, or 3.4.0
 
 - Java 6. Java 1.5.0_11 and later seems to work. The reason is that
   the garbage collection does not do a good enough job when using memory
diff --git a/README b/README
index af601e8..a10b8d4 100644
--- a/README
+++ b/README
@@ -94,8 +94,7 @@ three for packaging.
 
             == COMPATIBILITY                   ==
 
-- Eclipse 3.2.1 is the minimum Eclipse version. Expect this to change
-  in future versions.
+- Eclipse 3.3.1 is the minimum Eclipse version, 3.4 is preferred.
 
 - Newer version of EGit/JGit may implement new functionality, remove
   existing functions and change others without other notice than what
-- 
1.6.0.rc1.250.g9b5e2
