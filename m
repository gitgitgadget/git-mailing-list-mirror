From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 01/11] Call it "Git User Manual" and remove reference to
 very old Git version
Date: Tue, 27 Aug 2013 19:55:15 +0200 (CEST)
Message-ID: <1972849803.34382.1377626115372.JavaMail.ngmail@webmail19.arcor-online.net>
References: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: martinvonz@gmail.com, jrnieder@gmail.com, th.acker@arcor.de,
	gitster@pobox.com, wking@tremily.us, philipoakley@iee.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 19:55:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VENUH-0002o7-DK
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 19:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753466Ab3H0RzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 13:55:18 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:59897 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753003Ab3H0RzQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Aug 2013 13:55:16 -0400
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mx.arcor.de (Postfix) with ESMTP id 6BBE31975B6;
	Tue, 27 Aug 2013 19:55:15 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id 612C328BA5D;
	Tue, 27 Aug 2013 19:55:15 +0200 (CEST)
Received: from webmail19.arcor-online.net (webmail19.arcor-online.net [151.189.8.77])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 5926BE3C0D;
	Tue, 27 Aug 2013 19:55:15 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-05.arcor-online.net 5926BE3C0D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1377626115; bh=tgsfqIVMmMLPAFXGItXQoV4GxKsRuPfk0s0dHYiFB50=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=l21Yr/IELIpYiLe+4cdnCSY37OWorHAOtHR7Gns5d6MAUQNlB6jKPmjN214jaYvhB
	 AZlGBRFvfAgYtDWqMnH7ViMYnE4z1ITveO+MjEi52HAKsk/jfXImcYM8Q/8+ohMTC8
	 9uXWj8l8rX/qEjeKRukfRbgcUT5SZ0lVwlKzHWU8=
Received: from [178.7.16.225] by webmail19.arcor-online.net (151.189.8.77) with HTTP (Arcor Webmail); Tue, 27 Aug 2013 19:55:15 +0200 (CEST)
In-Reply-To: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.16.225
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233121>


Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
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
