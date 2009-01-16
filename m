From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] githooks.txt: add missing word
Date: Fri, 16 Jan 2009 21:36:06 +0100
Message-ID: <1232138166-30487-1-git-send-email-s-beyer@gmx.net>
Cc: gitster@pobox.com, Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 16 21:37:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNvRh-0003rD-OS
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 21:37:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760668AbZAPUgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 15:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758260AbZAPUgO
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 15:36:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:49224 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758259AbZAPUgN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 15:36:13 -0500
Received: (qmail invoked by alias); 16 Jan 2009 20:36:10 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp011) with SMTP; 16 Jan 2009 21:36:10 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+8YcwfYT68kTL3A8j6VpaXumQy0+SrcAwyZsB/Ud
	/eEsBMJdw4F6OA
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1LNvQE-0007wC-KR; Fri, 16 Jan 2009 21:36:06 +0100
X-Mailer: git-send-email 1.6.1.160.gecdb
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105992>

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 Documentation/githooks.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index e4d61d5..1fd512b 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -90,7 +90,7 @@ This hook is invoked by 'git-commit' right after preparing the
 default log message, and before the editor is started.
 
 It takes one to three parameters.  The first is the name of the file
-that the commit log message.  The second is the source of the commit
+that contains the commit log message.  The second is the source of the commit
 message, and can be: `message` (if a `-m` or `-F` option was
 given); `template` (if a `-t` option was given or the
 configuration option `commit.template` is set); `merge` (if the
-- 
1.6.1.160.gecdb
