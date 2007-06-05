From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Documentation typo.
Date: Wed,  6 Jun 2007 00:25:56 +0200
Message-ID: <11810823561507-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <pierre.habouzit@m4x.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jun 06 00:26:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvhTZ-0008Mi-UI
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 00:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759344AbXFEWZ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 18:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763270AbXFEWZ6
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 18:25:58 -0400
Received: from pan.madism.org ([88.191.52.104]:38248 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759344AbXFEWZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 18:25:57 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 1E344B838;
	Wed,  6 Jun 2007 00:25:57 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id E1A967A1D; Wed,  6 Jun 2007 00:25:56 +0200 (CEST)
X-Mailer: git-send-email 1.5.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49232>

From: Pierre Habouzit <pierre.habouzit@m4x.org>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 Documentation/pull-fetch-param.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index 8d4e950..5bcdbc8 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -4,7 +4,7 @@
 
 <refspec>::
 	The canonical format of a <refspec> parameter is
-	`+?<src>:<dst>`; that is, an optional plus `+`, followed
+	`\+?<src>:<dst>`; that is, an optional plus `+`, followed
 	by the source ref, followed by a colon `:`, followed by
 	the destination ref.
 +
-- 
1.5.2.1
