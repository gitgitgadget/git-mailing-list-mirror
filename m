From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 12/13] Remove irrelevant reference from "Tying it all
 together"
Date: Sat, 24 Aug 2013 09:35:58 +0200 (CEST)
Message-ID: <1749978317.1091238.1377329758522.JavaMail.ngmail@webmail08.arcor-online.net>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, wking@tremily.us, th.acker@arcor.de, jdl@jdl.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 24 09:36:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD8OC-0001pO-TQ
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 09:36:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755274Ab3HXHgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 03:36:00 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:35810 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754874Ab3HXHf7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Aug 2013 03:35:59 -0400
Received: from mail-in-20-z2.arcor-online.net (mail-in-20-z2.arcor-online.net [151.189.8.85])
	by mx.arcor.de (Postfix) with ESMTP id 8E49E197578;
	Sat, 24 Aug 2013 09:35:58 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-20-z2.arcor-online.net (Postfix) with ESMTP id 869166FAE6A;
	Sat, 24 Aug 2013 09:35:58 +0200 (CEST)
Received: from webmail08.arcor-online.net (webmail08.arcor-online.net [151.189.8.44])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 84A70197578;
	Sat, 24 Aug 2013 09:35:58 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-09.arcor-online.net 84A70197578
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1377329758; bh=Qf30lMbDUq4h7caf/n4iSqzZ9CQWeQ7geZg9c1XrN6U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=FKuAltm/ArEYo4R/+SAXZmSNPXSUTqYQMo2Uj5smP0T0U8Fv93IVdjjWrTIhQZRHX
	 qdpHFMwo1tGv6SV6V2BaupuWpxYeL1CEbQX8MP2bjBARjE/VS09Wi7MVyOOv3Kv013
	 xxsWhzcv6sNmqW9jW0IRjrd3lL5ve0CsdCEtbtBA=
Received: from [188.98.235.44] by webmail08.arcor-online.net (151.189.8.44) with HTTP (Arcor Webmail); Sat, 24 Aug 2013 09:35:58 +0200 (CEST)
In-Reply-To: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.235.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232879>


Sorry Jon, but this might not be of any help to new Git users ;)

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/user-manual.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 0d3f04e..08d8c91 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3908,8 +3908,7 @@ save the note about that state, in practice we tend to just write the
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
