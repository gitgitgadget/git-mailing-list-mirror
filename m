From: Alan Hourihane <alanh@fairlite.co.uk>
Subject: Re: new platform & S_IFGITLINK problem
Date: Mon, 02 Aug 2010 17:14:41 +0100
Message-ID: <1280765681.15734.1202.camel@jetpack.demon.co.uk>
References: <1272756555.13488.1314.camel@jetpack.demon.co.uk>
	 <7vfx2b2ft5.fsf@alter.siamese.dyndns.org>
	 <1279815812.7796.5499.camel@jetpack.demon.co.uk>
	 <7vwrsjcvx6.fsf@alter.siamese.dyndns.org>
	 <1280080833.3622.4772.camel@jetpack.demon.co.uk>
	 <AANLkTikcLk_W_guvBd3s15CY9xz6utmZASb67ndbt4=o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 18:14:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ofxf8-0004hl-EC
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 18:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753668Ab0HBQOp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 12:14:45 -0400
Received: from fairlite.demon.co.uk ([80.176.228.186]:58657 "EHLO
	fairlite.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178Ab0HBQOo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 12:14:44 -0400
Received: from localhost (unknown [127.0.0.1])
	by fairlite.demon.co.uk (Postfix) with ESMTP id 0E33C20890E;
	Mon,  2 Aug 2010 16:14:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at demon.co.uk
Received: from fairlite.demon.co.uk ([127.0.0.1])
	by localhost (server.demon.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eiiOKKhxXaNG; Mon,  2 Aug 2010 17:14:41 +0100 (BST)
Received: from [192.168.0.50] (jetpack.demon.co.uk [192.168.0.50])
	by fairlite.demon.co.uk (Postfix) with ESMTP id DCDDC20890D;
	Mon,  2 Aug 2010 17:14:41 +0100 (BST)
In-Reply-To: <AANLkTikcLk_W_guvBd3s15CY9xz6utmZASb67ndbt4=o@mail.gmail.com>
X-Mailer: Evolution 2.28.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152421>

On Mon, 2010-08-02 at 16:11 +0000, =C6var Arnfj=F6r=F0 Bjarmason wrote:
> On Sun, Jul 25, 2010 at 18:00, Alan Hourihane <alanh@fairlite.co.uk> =
wrote:
> > On Sun, 2010-07-25 at 10:29 -0700, Junio C Hamano wrote:
> >> Alan Hourihane <alanh@fairlite.co.uk> writes:
> >>
> >> > Is there any ETA on fixing this up ?
> >>
> >> I don't think so, as I didn't see anybody who has a testable syste=
m
> >> volunteered to do this nor heard that somebody started doing it.
> >
> > O.k. Looks like I'll have to take it on over the long term.
>=20
> I've been adding smoke support to Git so that you could set up a cron
> job that automatically sent us failure reports on your platform. Then
> someone could fix this without your help.
>=20
> Here's the preliminary smoke patch:
>=20
>     http://github.com/avar/git/compare/git:pu...git-smoke-v2
>=20
> Would you be willing to run a smoker on FreeMiNT?

Sure. I'll give it a shot.

Alan.
