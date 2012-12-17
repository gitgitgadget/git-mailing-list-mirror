From: Thomas Ackermann <th.acker@arcor.de>
Subject: Aw: Re: [PATCH] Move api-command.txt to the end of API list in
 api-index.txt
Date: Mon, 17 Dec 2012 10:43:52 +0100 (CET)
Message-ID: <1944303.2385893.1355737432979.JavaMail.ngmail@webmail11.arcor-online.net>
References: <7vwqwhpy0a.fsf@alter.siamese.dyndns.org> <1582223824.296627.1355560147565.JavaMail.ngmail@webmail08.arcor-online.net>
 <1479174763.154268.1350408444997.JavaMail.ngmail@webmail15.arcor-online.net>
 <1213313884.154031.1350407865830.JavaMail.ngmail@webmail15.arcor-online.net>
 <1702872710.62174.1355660592713.JavaMail.ngmail@webmail12.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Mon Dec 17 10:44:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkXF5-00013U-QV
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 10:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980Ab2LQJnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 04:43:55 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:46381 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751213Ab2LQJny (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Dec 2012 04:43:54 -0500
Received: from mail-in-13-z2.arcor-online.net (mail-in-13-z2.arcor-online.net [151.189.8.30])
	by mx.arcor.de (Postfix) with ESMTP id F1519304F0;
	Mon, 17 Dec 2012 10:43:52 +0100 (CET)
Received: from mail-in-15.arcor-online.net (mail-in-15.arcor-online.net [151.189.21.55])
	by mail-in-13-z2.arcor-online.net (Postfix) with ESMTP id 0176F14A568;
	Mon, 17 Dec 2012 10:43:53 +0100 (CET)
Received: from webmail11.arcor-online.net (webmail11.arcor-online.net [151.189.8.83])
	by mail-in-15.arcor-online.net (Postfix) with ESMTP id E77501AB51F;
	Mon, 17 Dec 2012 10:43:52 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-15.arcor-online.net E77501AB51F
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1355737432; bh=XyqwUrMbvEREqXoLfUHk0drTBgm9+6OBWkHVHiuyhoI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=EEgxmiUdOhzK/X99qNZjNIYmV6vcSh7gJQS2pysO43/sQfQDer9ZtUwH2Elu9fTRl
	 tY/lgHkOsFZo75SomI94LUpLT/1dLcsGEbVTg2Oq0ROv5gtPjHzCa2S516baxCWsYa
	 PiXqt08IDPYxXI1xB90OIQO8l7VqSvjow6L4f8M0=
Received: from [194.138.39.59] by webmail11.arcor-online.net (151.189.8.83) with HTTP (Arcor Webmail); Mon, 17 Dec 2012 10:43:52 +0100 (CET)
In-Reply-To: <7vwqwhpy0a.fsf@alter.siamese.dyndns.org>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 194.138.39.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211668>

 
OK; I would also prefer to have it in ./howto.
So please drop this patch; I will provide a new one.

----- Original Nachricht ----
Von:     Junio C Hamano <gitster@pobox.com>
An:      Thomas Ackermann <th.acker@arcor.de>
Datum:   16.12.2012 21:01
Betreff: Re: [PATCH] Move api-command.txt to the end of API list in
 api-index.txt

> Thomas Ackermann <th.acker@arcor.de> writes:
> 
> > - because it describes a different form of API than the other api-*
> documents
> 
> It makes me wonder if a more correct "fix" is to move this document
> to the ../howto/ hierarchy.
> 


---
Thomas
