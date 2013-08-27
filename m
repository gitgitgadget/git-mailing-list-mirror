From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 10/11] Remove irrelevant reference from "Tying it all
 together"
Date: Tue, 27 Aug 2013 20:04:58 +0200 (CEST)
Message-ID: <240594913.34603.1377626698349.JavaMail.ngmail@webmail19.arcor-online.net>
References: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: martinvonz@gmail.com, jrnieder@gmail.com, th.acker@arcor.de,
	gitster@pobox.com, wking@tremily.us, philipoakley@iee.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 20:05:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VENdY-0001pE-P6
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 20:05:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414Ab3H0SE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 14:04:59 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:60631 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752919Ab3H0SE7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Aug 2013 14:04:59 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mx.arcor.de (Postfix) with ESMTP id 5E7605A467;
	Tue, 27 Aug 2013 20:04:58 +0200 (CEST)
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net [151.189.21.48])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 5C39E1F6028;
	Tue, 27 Aug 2013 20:04:58 +0200 (CEST)
Received: from webmail19.arcor-online.net (webmail19.arcor-online.net [151.189.8.77])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id 580DE3AE41E;
	Tue, 27 Aug 2013 20:04:58 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-08.arcor-online.net 580DE3AE41E
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1377626698; bh=iZ56rj4Ae3L39pY2VkUi5suiChRug++GImlpfazKm/M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=GcYBwtgqhFTcQrMZy71kYPdGu+s/pXAaSxC8ScBvKPa+NXgxzhQj68NlQBR36wLAO
	 015reBbfHD2FB1lt+etu+4nslXFOioW/mggerPjdIY0cQbUg6ZybB0Rm77kZqqitkT
	 2/W0Q6Fhgiarf+VaKpl73xh12CPz2EPyol34ksLw=
Received: from [178.7.16.225] by webmail19.arcor-online.net (151.189.8.77) with HTTP (Arcor Webmail); Tue, 27 Aug 2013 20:04:58 +0200 (CEST)
In-Reply-To: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.16.225
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233130>


Sorry Jon, but this might not be of any help to new Git users ;)

Acked-by: Jon Loeliger <jdl@jdl.com>
Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/user-manual.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 56bd088..9149846 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3924,8 +3924,7 @@ save the note about that state, in practice we tend to just write the
 result to the file pointed at by `.git/HEAD`, so that we can always see
 what the last committed state was.
 
-Here is an ASCII art by Jon Loeliger that illustrates how
-various pieces fit together.
+Here is a picture that illustrates how various pieces fit together:
 
 ------------
 
-- 
1.8.3.msysgit.0


---
Thomas
