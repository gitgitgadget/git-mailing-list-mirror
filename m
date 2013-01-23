From: Thomas Ackermann <th.acker@arcor.de>
Subject: Aw: Re: [PATCH v3 3/6] Change 'git' to 'Git' whenever the whole
 system is referred to #2
Date: Wed, 23 Jan 2013 09:58:22 +0100 (CET)
Message-ID: <50804391.814945.1358931502165.JavaMail.ngmail@webmail07.arcor-online.net>
References: <7v38xsjzxg.fsf@alter.siamese.dyndns.org> <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
 <2009548606.632825.1358795980319.JavaMail.ngmail@webmail20.arcor-online.net>
 <CAJDDKr4fnUp_35ni72XJS_NSp4jxbvQPENLnk3AhFv2FBg3DTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, davvid@gmail.com
To: gitster@pobox.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Wed Jan 23 09:58:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxwAP-0004vn-5I
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 09:58:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005Ab3AWI6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 03:58:24 -0500
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:38416 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753972Ab3AWI6X (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jan 2013 03:58:23 -0500
Received: from mail-in-13-z2.arcor-online.net (mail-in-13-z2.arcor-online.net [151.189.8.30])
	by mx.arcor.de (Postfix) with ESMTP id 363F13AE542;
	Wed, 23 Jan 2013 09:58:22 +0100 (CET)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-13-z2.arcor-online.net (Postfix) with ESMTP id 2A1A214BBF4;
	Wed, 23 Jan 2013 09:58:22 +0100 (CET)
Received: from webmail07.arcor-online.net (webmail07.arcor-online.net [151.189.8.8])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 22F1C1081D5;
	Wed, 23 Jan 2013 09:58:22 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-07.arcor-online.net 22F1C1081D5
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1358931502; bh=2q5GZxfh3EA1YFLLbjeAEjEMSO9cs2F81ahTxKLmj2Q=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=QTuCKzauTCKpF21on4Sh0jj498xVi9ypCugb6tl7xnxrnF7NQi6RpW0fZt7iwbXVs
	 VZCep6wOyqnJfYx4qSJPB0ScHAdgUo4FGsSbf+V0zA5IOPBK88KiclePpiMefLGeRo
	 pJHHJUKlI7XXKX7CYlYhv4xBnLgo7+4y5AFXDUXs=
Received: from [194.138.39.56] by webmail07.arcor-online.net (151.189.8.8) with HTTP (Arcor Webmail); Wed, 23 Jan 2013 09:58:22 +0100 (CET)
In-Reply-To: <7v38xsjzxg.fsf@alter.siamese.dyndns.org>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 194.138.39.56
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214302>

 > 
> Thomas, I do not want to see many rounds of entire rerolls of this
> series on the list (nobody will look at the whole series multiple
> times with fine toothed comb).  I do not think you want to do that
> either.  Can you collect remaining fixups like David's message, turn
> them into patch form when you have collected enough to be reviewed
> in one sitting (say, a patchfile at around 200 lines), and send them
> over to the list to apply on top of the tree of that commit?
> 
Sure!


---
Thomas
