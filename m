From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] shortlog: mention the "-e" option in the usage
Date: Wed, 9 Jan 2008 11:39:54 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801091139340.31053@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 09 12:40:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCZIU-00044Z-4z
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 12:40:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbYAILkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 06:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbYAILkK
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 06:40:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:33818 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751260AbYAILkI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 06:40:08 -0500
Received: (qmail invoked by alias); 09 Jan 2008 11:40:07 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp032) with SMTP; 09 Jan 2008 12:40:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+4GkkbolC4Xpe2bHPAAhbmTYlDTlr1rnYepbxtxI
	RRtHQRCcUcgRfU
X-X-Sender: gene099@racer.site
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69984>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-shortlog.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 3d8d709..fa8bc7d 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -8,7 +8,7 @@
 #include "mailmap.h"
 
 static const char shortlog_usage[] =
-"git-shortlog [-n] [-s] [<commit-id>... ]";
+"git-shortlog [-n] [-s] [-e] [<commit-id>... ]";
 
 static char *common_repo_prefix;
 static int email;
-- 
1.5.4.rc2.72.g74f4d
