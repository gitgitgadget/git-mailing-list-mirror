From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 4/4] revert: improve success message by adding abbreviated commit sha1
Date: Sat, 17 Jul 2010 22:17:02 +0200
Message-ID: <201007172217.02500.chriscool@tuxfamily.org>
References: <20100713232816.7738.78221.chriscool@tuxfamily.org> <20100715225141.GB7253@burratino>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 17 22:17:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaDov-0004io-CB
	for gcvg-git-2@lo.gmane.org; Sat, 17 Jul 2010 22:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760120Ab0GQURH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Jul 2010 16:17:07 -0400
Received: from smtp2f.orange.fr ([80.12.242.151]:29955 "EHLO smtp2f.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752426Ab0GQURG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jul 2010 16:17:06 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f08.orange.fr (SMTP Server) with ESMTP id 8C34180009B7;
	Sat, 17 Jul 2010 22:17:03 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f08.orange.fr (SMTP Server) with ESMTP id 7EB5D80009BA;
	Sat, 17 Jul 2010 22:17:03 +0200 (CEST)
Received: from style.localnet (ANantes-156-1-132-203.w90-12.abo.wanadoo.fr [90.12.251.203])
	by mwinf2f08.orange.fr (SMTP Server) with ESMTP id 3B46680009B7;
	Sat, 17 Jul 2010 22:17:03 +0200 (CEST)
X-ME-UUID: 20100717201703242.3B46680009B7@mwinf2f08.orange.fr
User-Agent: KMail/1.13.2 (Linux/2.6.32-23-generic; KDE/4.4.2; x86_64; ; )
In-Reply-To: <20100715225141.GB7253@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151199>

On Friday 16 July 2010 00:51:41 Jonathan Nieder wrote:
> Christian Couder wrote:
> > Instead of "Finished one cherry-pick." or "Finished one
> > revert.", we now print "Finished cherry-pick commit
> > <abbreviated sha1>."
>=20
> =E2=80=9CFinished cherry-pick of commit f67ab8.=E2=80=9D sounds more =
better to my ear.
>=20
> 	Finished cherry-pick of foo.
> 	Finished cherry-pick of bar.
> 	Finished cherry-pick of baz.
> 	etc
>=20
> is a lot saner than
>=20
> 	Finished one cherry-pick.
> 	Finished one cherry-pick.
> 	Finisehd one cherry-pick.
> 	etc
>=20
> Thanks for making it happen.

Thanks for your review and your patches to improve my patches!
And thanks to Junio for picking up everything!

Best regards,
Christian.
