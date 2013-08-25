From: Thomas Ackermann <th.acker@arcor.de>
Subject: Aw: Re: [PATCH 08/13] Improve section "Manipulating branches"
Date: Sun, 25 Aug 2013 13:41:05 +0200 (CEST)
Message-ID: <697469569.483506.1377430865590.JavaMail.ngmail@webmail16.arcor-online.net>
References: <xmqqioyumoxr.fsf@gitster.dls.corp.google.com> <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
	<1973484790.1091060.1377329493472.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, wking@tremily.us
To: gitster@pobox.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Sun Aug 25 13:41:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDYh0-0002SC-9L
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 13:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756227Ab3HYLlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 07:41:08 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:41963 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755139Ab3HYLlH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Aug 2013 07:41:07 -0400
Received: from mail-in-17-z2.arcor-online.net (mail-in-17-z2.arcor-online.net [151.189.8.34])
	by mx.arcor.de (Postfix) with ESMTP id A01D83012E;
	Sun, 25 Aug 2013 13:41:05 +0200 (CEST)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-17-z2.arcor-online.net (Postfix) with ESMTP id 929BD10C031;
	Sun, 25 Aug 2013 13:41:05 +0200 (CEST)
Received: from webmail16.arcor-online.net (webmail16.arcor-online.net [151.189.8.70])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 89C96D7EFA;
	Sun, 25 Aug 2013 13:41:05 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-03.arcor-online.net 89C96D7EFA
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1377430865; bh=6GjCnba7pxaoUClZWgQYMgaV8pw8rFFUbG2RB8HCd2M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=f+xCXnUiD1vcyrtceRV6sKS1mtNVQR44aVvMBDM1C5FU3Yyc+IuxPkg/RuKOBJl8O
	 LwthLFT3BgNjPXd+sGiYMjnXXBdo7eQFkq2fVDLPijrJjMW0HQGsgW6c+yqDWkZcKU
	 wIIDLrvGEbcsmOPdcGn/E9lBlgnRUYg9kawajlVo=
Received: from [178.7.23.208] by webmail16.arcor-online.net (151.189.8.70) with HTTP (Arcor Webmail); Sun, 25 Aug 2013 13:41:05 +0200 (CEST)
In-Reply-To: <xmqqioyumoxr.fsf@gitster.dls.corp.google.com>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.23.208
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232950>

 
> 
> But is this correct?  I somehow thought that we check with the
> current or the upstream.
> 

You are correct. I will add this. Thanks.


---
Thomas
