From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: [PATCH 1/2] Documentation: Remove deprecated --mixed option in git-reset synopsis
Date: Sat, 16 Feb 2008 17:48:45 +0100
Message-ID: <1203180526-12020-1-git-send-email-pdebie@ai.rug.nl>
Cc: Pieter de Bie <pdebie@ai.rug.nl>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 16 17:49:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQQEB-0002B2-Ak
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 17:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755479AbYBPQsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 11:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755219AbYBPQsu
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 11:48:50 -0500
Received: from smtp-2.orange.nl ([193.252.22.242]:14769 "EHLO smtp-2.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751350AbYBPQst (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 11:48:49 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6109.orange.nl (SMTP Server) with ESMTP id 32B567000088
	for <git@vger.kernel.org>; Sat, 16 Feb 2008 17:48:48 +0100 (CET)
Received: from localhost.localdomain (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6109.orange.nl (SMTP Server) with ESMTP id 011E0700008B;
	Sat, 16 Feb 2008 17:48:46 +0100 (CET)
X-ME-UUID: 20080216164847465.011E0700008B@mwinf6109.orange.nl
X-Mailer: git-send-email 1.5.4.3.gb183
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74047>

And while we're at it, use the dashless git call

Signed-off-by: Pieter de Bie <pdebie@ai.rug.nl>
---
 Documentation/git-reset.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index a4e0a77..2b24641 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -8,8 +8,8 @@ git-reset - Reset current HEAD to the specified state
 SYNOPSIS
 --------
 [verse]
-'git-reset' [--mixed | --soft | --hard] [-q] [<commit>]
-'git-reset' [--mixed] [-q] [<commit>] [--] <paths>...
+'git reset' [--mixed | --soft | --hard] [-q] [<commit>]
+'git reset' [-q] [<commit>] [--] <paths>...
 
 DESCRIPTION
 -----------
-- 
1.5.4.3.gb183
