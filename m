From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 1/3] Move ./technical/api-command.txt to
 ./howto/new-command.txt
Date: Fri, 21 Dec 2012 19:05:28 +0100 (CET)
Message-ID: <1121023011.286687.1356113128586.JavaMail.ngmail@webmail14.arcor-online.net>
References: <1595193006.286662.1356112971883.JavaMail.ngmail@webmail14.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: th.acker@arcor.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 21 19:05:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm6yi-0007TT-1J
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 19:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393Ab2LUSFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 13:05:31 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:57778 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751014Ab2LUSF3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Dec 2012 13:05:29 -0500
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mx.arcor.de (Postfix) with ESMTP id 9EC4F307B9
	for <git@vger.kernel.org>; Fri, 21 Dec 2012 19:05:28 +0100 (CET)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id 977666F2BF4;
	Fri, 21 Dec 2012 19:05:28 +0100 (CET)
Received: from webmail14.arcor-online.net (webmail14.arcor-online.net [151.189.8.67])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 94FD810C625;
	Fri, 21 Dec 2012 19:05:28 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-06.arcor-online.net 94FD810C625
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1356113128; bh=v8qB5FVfUpwk3gd2D1NHzH1FeQHeSnn/ErONysCH+j0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=qH4Dj9BKlDbYX7MqfuMGIG3NX6j6fW8QRCee6HMamkbaBSfepcphGXdsrOZ6sd8Ia
	 Fa6bOUa9zr+VQYImhsSjVIXAKh40NXaVqGTWRSMyL0Lk8RL9GXfODxmVLjaLyu1c7I
	 1/7YWr3y7H0mVshCgA+BmiUHxT7Qb/0RCxxhuzs0=
Received: from [178.7.24.61] by webmail14.arcor-online.net (151.189.8.67) with HTTP (Arcor Webmail); Fri, 21 Dec 2012 19:05:28 +0100 (CET)
In-Reply-To: <1595193006.286662.1356112971883.JavaMail.ngmail@webmail14.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.24.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211994>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/{technical/api-command.txt => howto/new-command.txt} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/{technical/api-command.txt => howto/new-command.txt} (100%)

diff --git a/Documentation/technical/api-command.txt b/Documentation/howto/new-command.txt
similarity index 100%
rename from Documentation/technical/api-command.txt
rename to Documentation/howto/new-command.txt
-- 
1.8.0.msysgit.0


---
Thomas
