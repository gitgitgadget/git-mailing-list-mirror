From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH] typofix for index-format.txt
Date: Tue, 28 Jul 2015 19:45:14 +0200 (CEST)
Message-ID: <210815239.171963.1438105514805.JavaMail.ngmail@webmail09.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, th.acker@arcor.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 19:45:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK8wO-0001hX-2T
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 19:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbbG1RpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 13:45:18 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:46116 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750886AbbG1RpQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jul 2015 13:45:16 -0400
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mx.arcor.de (Postfix) with ESMTP id 3mgllG6YwNzFnkc;
	Tue, 28 Jul 2015 19:45:14 +0200 (CEST)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id D637B28B84E;
	Tue, 28 Jul 2015 19:45:14 +0200 (CEST)
Received: from webmail09.arcor-online.net (webmail09.arcor-online.net [151.189.8.45])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 3mgllG5vZPz19km;
	Tue, 28 Jul 2015 19:45:14 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-12.arcor-online.net 3mgllG5vZPz19km
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1438105514; bh=+NdEzY6ZfxJjD5pMc2BgtACKAyj+SGjr9WUjartShpI=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=tisj1LIYujUbUTGNletanyjdWgfZfNbpKOkR05j6KpJQIxqK4JPgLwmb6xkbbobjS
	 KCzHBLySpzcHUcVnRK6i7LQ4T2JoXRNQ7I8yC+7eFNQRspjRemLgb8fmFC09Z90+RV
	 CBdLO2Msh2IiOve6Vk8ERct99Tc6WWmLnlIglN10=
Received: from [88.72.110.171] by webmail09.arcor-online.net (151.189.8.45) with HTTP (Arcor Webmail); Tue, 28 Jul 2015 19:45:14 +0200 (CEST)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 88.72.110.171
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274798>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/technical/index-format.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index b7093af..7392ff6 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -275,7 +275,7 @@ Git index format
 
     - The directory name terminated by NUL.
 
-    - A number of untrached file/dir names terminated by NUL.
+    - A number of untracked file/dir names terminated by NUL.
 
 The remaining data of each directory block is grouped by type:
 
-- 
1.9.5.msysgit.0
