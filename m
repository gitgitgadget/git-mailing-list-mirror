From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: [PATCH] ReleaseNotes: git-gui is not installed in $PATH
Date: Sat,  9 Aug 2008 00:22:25 +0200
Message-ID: <1218234145-33268-1-git-send-email-pdebie@ai.rug.nl>
Cc: Pieter de Bie <pdebie@ai.rug.nl>
To: Git Mailinglist <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 09 00:23:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRaMy-0001E3-KG
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 00:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757709AbYHHWWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 18:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757147AbYHHWWd
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 18:22:33 -0400
Received: from smtp-4.orange.nl ([193.252.22.249]:46980 "EHLO smtp-4.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753919AbYHHWWc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 18:22:32 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6308.online.nl (SMTP Server) with ESMTP id B5A161C00083;
	Sat,  9 Aug 2008 00:22:30 +0200 (CEST)
Received: from localhost.localdomain (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6308.online.nl (SMTP Server) with ESMTP id 6D3B91C00082;
	Sat,  9 Aug 2008 00:22:26 +0200 (CEST)
X-ME-UUID: 20080808222230447.6D3B91C00082@mwinf6308.online.nl
X-Mailer: git-send-email 1.6.0.rc1.288.g5b89f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91720>


Signed-off-by: Pieter de Bie <pdebie@ai.rug.nl>
---
 Documentation/RelNotes-1.6.0.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/RelNotes-1.6.0.txt b/Documentation/RelNotes-1.6.0.txt
index 614a3be..e6a425a 100644
--- a/Documentation/RelNotes-1.6.0.txt
+++ b/Documentation/RelNotes-1.6.0.txt
@@ -5,7 +5,7 @@ User visible changes
 --------------------
 
 With the default Makefile settings, most of the programs are now
-installed outside your $PATH, except for "git", "gitk", "git-gui" and
+installed outside your $PATH, except for "git", "gitk" and
 some server side programs that need to be accessible for technical
 reasons.  Invoking a git subcommand as "git-xyzzy" from the command
 line has been deprecated since early 2006 (and officially announced in
-- 
1.6.0.rc1.288.g5b89f
