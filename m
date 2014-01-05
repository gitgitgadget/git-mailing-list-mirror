From: Thomas Ackermann <th.acker@arcor.de>
Subject: Aw: Re: [PATCH] Improve user-manual html and pdf formatting
Date: Sun, 5 Jan 2014 09:22:30 +0100 (CET)
Message-ID: <1182656556.701681.1388910150664.JavaMail.ngmail@webmail16.arcor-online.net>
References: <20140104211834.GC12251@google.com> <352636633.1492236.1388826471175.JavaMail.ngmail@webmail10.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: jrnieder@gmail.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Sun Jan 05 09:22:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vziyj-0004aU-FT
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jan 2014 09:22:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbaAEIWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jan 2014 03:22:32 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:43951 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750816AbaAEIWc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jan 2014 03:22:32 -0500
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mx.arcor.de (Postfix) with ESMTP id 9EC5AAA33C;
	Sun,  5 Jan 2014 09:22:30 +0100 (CET)
Received: from mail-in-15.arcor-online.net (mail-in-15.arcor-online.net [151.189.21.55])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id 9D5F87FECC1;
	Sun,  5 Jan 2014 09:22:30 +0100 (CET)
Received: from webmail16.arcor-online.net (webmail16.arcor-online.net [151.189.8.70])
	by mail-in-15.arcor-online.net (Postfix) with ESMTP id 960231AB52E;
	Sun,  5 Jan 2014 09:22:30 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-15.arcor-online.net 960231AB52E
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1388910150; bh=5GD5wQi7zqV3qWyXlq90a4vVKj/1VmO4jsFRbC3HYsQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=fwyFsQpoU/ZPAi59K2HeH2EEFA0+jdvZ7T9/FcpnlgZuohX/JjZfcukGqdhwx5iig
	 oa8Rekq5dJtZk2dqb7za7tNalHburqGYn4Hd3/RIhdCIp6B9fm5TKpK5HeEJFafdjp
	 AnVd91v49IsgLTbQoMjUycTYrtt5TcpxTK18+zQI=
Received: from [188.99.35.168] by webmail16.arcor-online.net (151.189.8.70) with HTTP (Arcor Webmail); Sun, 5 Jan 2014 09:22:30 +0100 (CET)
In-Reply-To: <20140104211834.GC12251@google.com>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.99.35.168
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239958>

 
This originally was an UTF8-BOM in user-manual.txt and notepad++ was so clever
not to show it in the patch-file :-| Pasting this into my webmail then produced 
complete rubbish which I didn't noticed ...

----- Original Nachricht ----
Von:     Jonathan Nieder <jrnieder@gmail.com>
An:      Thomas Ackermann <th.acker@arcor.de>
Datum:   04.01.2014 22:18
Betreff: Re: [PATCH] Improve user-manual html and pdf formatting

> Hi,
> 
> Thomas Ackermann wrote:
> 
> > --- a/Documentation/user-manual.txt
> > +++ b/Documentation/user-manual.txt
> > @@ -1,5 +1,5 @@
> > -Git User Manual
> > +&#65279;Git User Manual
> 
> Why?
> 
> Puzzled,
> Jonathan
> 

---
Thomas
