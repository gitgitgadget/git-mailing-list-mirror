From: "Fernando J. Pereda" <ferdy@ferdyx.org>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Thu, 16 Feb 2006 11:42:24 +0100
Message-ID: <20060216104224.GA29192@ferdyx.org>
References: <43F1F5CB.10402@citi.umich.edu> <20060214160747.GA6350@diana.vm.bytemark.co.uk> <43F2445A.6020109@citi.umich.edu> <20060214222913.GK31278@pasky.or.cz> <43F2745D.4010800@vilain.net> <20060215003510.GA25715@spearce.org> <20060215041142.GA21048@fieldses.org> <20060215065411.GB26632@spearce.org> <7vbqx7bnz7.fsf@assigned-by-dhcp.cox.net> <b0943d9e0602160233i68fe5879y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Cc: Junio C Hamano <junkio@cox.net>,
	Shawn Pearce <spearce@spearce.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Sam Vilain <sam@vilain.net>, Petr Baudis <pasky@suse.cz>,
	Chuck Lever <cel@citi.umich.edu>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 16 11:42:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9gat-0007kW-C3
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 11:42:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWBPKmf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 05:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWBPKmf
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 05:42:35 -0500
Received: from 170.Red-213-96-222.staticIP.rima-tde.net ([213.96.222.170]:60549
	"EHLO smtp.ferdyx.org") by vger.kernel.org with ESMTP
	id S1751318AbWBPKmd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 05:42:33 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp.ferdyx.org (Postfix) with ESMTP id 1E2D28D366;
	Thu, 16 Feb 2006 11:42:29 +0100 (CET)
Received: from smtp.ferdyx.org ([127.0.0.1])
	by localhost (tungsteno [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 02829-10; Thu, 16 Feb 2006 11:42:26 +0100 (CET)
Received: from posidon.ferdyx.org (posidon.ferdyx.org [192.168.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ferdyx.org (Postfix) with ESMTP id 382FA8D30C;
	Thu, 16 Feb 2006 11:42:25 +0100 (CET)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	ferdy@ferdyx.org; Thu, 16 Feb 2006 11:42:25 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Mail-Followup-To: Catalin Marinas <catalin.marinas@gmail.com>,
	Junio C Hamano <junkio@cox.net>, Shawn Pearce <spearce@spearce.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Sam Vilain <sam@vilain.net>, Petr Baudis <pasky@suse.cz>,
	Chuck Lever <cel@citi.umich.edu>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <b0943d9e0602160233i68fe5879y@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at ferdyx.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16292>


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2006 at 10:33:12AM +0000, Catalin Marinas wrote:
> On 16/02/06, Junio C Hamano <junkio@cox.net> wrote:
> > By the way, please do *not* do this:
> >
> >     Mail-Followup-To: "J. Bruce Fields" <bfields@fieldses.org>,
> >             Sam Vilain <sam@vilain.net>, Petr Baudis <pasky@suse.cz>,...
> >             ...
>=20
> I think that's a "feature" of mutt that I couldn't understand. Every
> time I got this header and looked at the mail client, it was... mutt
> :-).

That's because you told mutt you are subscribed to that list, so mutt
won't add you to Mail-Followup-To:, so you don't get duplicates. If you
don't tell mutt you are subscribed to the list, It will add your own
addres there.

I think it is a nice feature, although it seems to annoy Junio :)

Cheers,
Ferdy

--=20
Fernando J. Pereda Garcimart=EDn
Gentoo Developer (Alpha,net-mail,mutt,git)
20BB BDC3 761A 4781 E6ED  ED0B 0A48 5B0C 60BD 28D4

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD9FcQCkhbDGC9KNQRAvQ6AJ98uUPkEYJXbTrsBF9TZLludaxx+QCeKApU
FvSkdmCQM6g1frRplfDD7pY=
=f6fJ
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
