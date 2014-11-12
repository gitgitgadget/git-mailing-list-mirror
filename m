From: Thomas Ackermann <th.acker@arcor.de>
Subject: Aw: Re: [PATCH] gittutorial.txt: remove reference to ancient Git
 version
Date: Wed, 12 Nov 2014 09:57:00 +0100 (CET)
Message-ID: <1325552150.191076.1415782620274.JavaMail.ngmail@webmail22.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Wed Nov 12 09:57:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoTji-0005se-Lt
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 09:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbaKLI5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 03:57:05 -0500
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:48274 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752112AbaKLI5C (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Nov 2014 03:57:02 -0500
Received: from mail-in-18-z2.arcor-online.net (mail-in-18-z2.arcor-online.net [151.189.8.35])
	by mx.arcor.de (Postfix) with ESMTP id 535942D6BB8;
	Wed, 12 Nov 2014 09:57:00 +0100 (CET)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-18-z2.arcor-online.net (Postfix) with ESMTP id 4987133B65A;
	Wed, 12 Nov 2014 09:57:00 +0100 (CET)
Received: from webmail22.arcor-online.net (webmail22.arcor-online.net [151.189.8.137])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 4113F10BD7D;
	Wed, 12 Nov 2014 09:57:00 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-06.arcor-online.net 4113F10BD7D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1415782620; bh=u25nHPDP1wrVHciINHUUGQrvWzDVGhMA47WnMeBx55M=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=tT41d2wcZEd6l9ImV0HJ73oc6WLmv39PuWfpN2q0o/Au1/QJSKlVcskz1bze9SWX8
	 wOOSoa7WJTUhauuCVVcX0CnJ0AwMipdApMMPQxiMR06NCSoyx5zkBSzpy6yI+r7NHA
	 FxJP9VZf+vAzu4/mRFlaA2sQyY+/ogtsFDCW6d/I=
Received: from [194.138.39.56] by webmail22.arcor-online.net (151.189.8.137) with HTTP (Arcor Webmail); Wed, 12 Nov 2014 09:57:00 +0100 (CET)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 194.138.39.56
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 
I also re-read the whole document and think it's still up-to-date
with Git 2.0. But I might have missed some subtler points.

Thomas

----- Original Nachricht ----
Von:     Junio C Hamano <gitster@pobox.com>
An:      Thomas Ackermann <th.acker@arcor.de>
Datum:   11.11.2014 23:51
Betreff: Re: [PATCH] gittutorial.txt: remove reference to ancient Git version

> 
> Yeah, sounds like going in the right direction.
> 
> Perhaps we should start doing a serious re-reading of this document
> and update the contents to suggest better ways that were invented
> to solve common problems since this document was written.
> 


---
Thomas
