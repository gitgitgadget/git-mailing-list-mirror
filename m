From: Tim Stoakes <tim@stoakes.net>
Subject: [PATCH] Fix typo in 'blame' documentation.
Date: Sun, 10 Feb 2008 14:49:08 +1030
Message-ID: <1202617148-22152-1-git-send-email-tim@stoakes.net>
Cc: gitster@pobox.com, Tim Stoakes <tim@stoakes.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 10 05:19:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO3fN-0002Yc-NS
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 05:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524AbYBJETM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 23:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753301AbYBJETL
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 23:19:11 -0500
Received: from hosted04.westnet.com.au ([203.10.1.217]:33668 "EHLO
	hosted04.westnet.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842AbYBJETK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 23:19:10 -0500
Received: from hosted04.westnet.com.au (hosted04.westnet.com.au [127.0.0.1])
	by hosted04.westnet.com.au (Postfix) with SMTP id 10AE221C410;
	Sun, 10 Feb 2008 13:19:08 +0900 (WST)
Received: from mail.stoakes.net (dsl-202-173-137-105.sa.westnet.com.au [202.173.137.105])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hosted04.westnet.com.au (Postfix) with ESMTP id 8226221E125;
	Sun, 10 Feb 2008 13:19:07 +0900 (WST)
Received: from noodle.stoakes.net (unknown [192.168.20.209])
	by mail.stoakes.net (Postfix) with ESMTP id A7B5E28C010;
	Sun, 10 Feb 2008 14:49:06 +1030 (CST)
Received: by noodle.stoakes.net (Postfix, from userid 1000)
	id 5F2467F1FF; Sun, 10 Feb 2008 14:49:08 +1030 (CST)
X-Mailer: git-send-email 1.5.4
X-PMX-Branch: TNG-Outgoing
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73310>

Signed-off-by: Tim Stoakes <tim@stoakes.net>
---
 Documentation/blame-options.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index ea1007b..c11bb7d 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -52,7 +52,7 @@ of lines before or after the line given by <start>.
 	When <rev> is not specified, the command annotates the
 	changes starting backwards from the working tree copy.
 	This flag makes the command pretend as if the working
-	tree copy has the contents of he named file (specify
+	tree copy has the contents of the named file (specify
 	`-` to make the command read from the standard input).
 
 -M|<num>|::
-- 
1.5.4
