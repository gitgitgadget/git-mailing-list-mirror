From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 01/13] Call it "Git User Manual" and remove reference to
 very old Git version
Date: Sat, 24 Aug 2013 09:24:45 +0200 (CEST)
Message-ID: <119602113.1090836.1377329085278.JavaMail.ngmail@webmail08.arcor-online.net>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, wking@tremily.us, th.acker@arcor.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 24 09:24:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD8DL-0000xz-SC
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 09:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754821Ab3HXHYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 03:24:47 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:60936 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754605Ab3HXHYq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Aug 2013 03:24:46 -0400
Received: from mail-in-16-z2.arcor-online.net (mail-in-16-z2.arcor-online.net [151.189.8.33])
	by mx.arcor.de (Postfix) with ESMTP id 4F8CA272EE;
	Sat, 24 Aug 2013 09:24:45 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-16-z2.arcor-online.net (Postfix) with ESMTP id 49EA3212057;
	Sat, 24 Aug 2013 09:24:45 +0200 (CEST)
Received: from webmail08.arcor-online.net (webmail08.arcor-online.net [151.189.8.44])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 444D410C403;
	Sat, 24 Aug 2013 09:24:45 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-06.arcor-online.net 444D410C403
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1377329085; bh=nOf7AkWSzivoIcYC257q58LyCMiQi4Pi0ba6WqvLEXw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=Fn+ZLwkyf9865QuyFuIpuRigGr+U45oCi0nWjhMon5AxFgg9RpNqJrzQ5BnxclGct
	 p4oiVHfb+SjULw843WvTrpYLfIsTJdrONvg+2ESuQYaXa8UAB/DfDT0RAmmzIw7ruP
	 sa0VH3gaz5lWrN2/pec2AbxkoGI00VE36I6u+hEk=
Received: from [188.98.235.44] by webmail08.arcor-online.net (151.189.8.44) with HTTP (Arcor Webmail); Sat, 24 Aug 2013 09:24:45 +0200 (CEST)
In-Reply-To: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.235.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232868>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/user-manual.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index fe723e4..103ec9a 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1,6 +1,5 @@
-Git User's Manual (for version 1.5.3 or newer)
-______________________________________________
-
+Git User Manual
+_______________
 
 Git is a fast distributed revision control system.
 
-- 
1.8.3.msysgit.0


---
Thomas
