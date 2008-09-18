From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: [TopGit PATCH] .gitignore += vim swap files
Date: Thu, 18 Sep 2008 20:29:28 +0400
Message-ID: <1221755370-6817-2-git-send-email-kirr@landau.phys.spbu.ru>
References: <1221755370-6817-1-git-send-email-kirr@landau.phys.spbu.ru>
Cc: Git Mailing List <git@vger.kernel.org>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Sep 18 19:19:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgNAA-0002JT-OE
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 19:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbYIRRSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 13:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754219AbYIRRSV
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 13:18:21 -0400
Received: from vs281.server4u.cz ([81.91.85.31]:35258 "EHLO vs281.server4u.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752361AbYIRRSU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 13:18:20 -0400
X-Greylist: delayed 2431 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Sep 2008 13:18:20 EDT
Received: from localhost ([127.0.0.1] helo=roro3)
	by vs281.server4u.cz with esmtp (Exim 4.69)
	(envelope-from <kirr@landau.phys.spbu.ru>)
	id 1KgMcM-000087-Tf; Thu, 18 Sep 2008 18:44:35 +0200
Received: from kirr by roro3 with local (Exim 4.69)
	(envelope-from <kirr@roro3>)
	id 1KgMNm-0001ne-2j; Thu, 18 Sep 2008 20:29:30 +0400
X-Mailer: git-send-email 1.6.0.2.250.g965aa
In-Reply-To: <1221755370-6817-1-git-send-email-kirr@landau.phys.spbu.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96222>

Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>
---
 .gitignore |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 8868f2d..aa39db4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -18,3 +18,5 @@ tg-import.txt
 tg-remote
 tg-remote.txt
 tg
+
+*.swp
-- 
1.6.0.2.250.g965aa
