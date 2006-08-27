From: Pierre Habouzit <pierre.habouzit@m4x.org>
Subject: Re: [PATCH] git-daemon: more powerful base-path/user-path settings, using formats.
Date: Sun, 27 Aug 2006 18:26:45 +0200
Organization: Polytechnique.org
Message-ID: <200608271826.48155.pierre.habouzit@m4x.org>
References: <7vmz9vgqlm.fsf@assigned-by-dhcp.cox.net> <200608271340.32792.madcoder@debian.org> <ecsdqa$1pi$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1312548.Pq6IQR5JuX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 27 18:27:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHNTK-0005Yh-49
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 18:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWH0Q0v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 12:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWH0Q0v
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 12:26:51 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:65227 "EHLO
	mx1.polytechnique.org") by vger.kernel.org with ESMTP
	id S932165AbWH0Q0u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Aug 2006 12:26:50 -0400
Received: from hades.madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ssl.polytechnique.org (Postfix) with ESMTP id 74D85332C1;
	Sun, 27 Aug 2006 18:26:49 +0200 (CEST)
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KMail/1.9.3
In-Reply-To: <ecsdqa$1pi$1@sea.gmane.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
X-AV-Checked: ClamAV using ClamSMTP at djali.polytechnique.org (Sun Aug 27 18:26:49 2006 +0200 (CEST))
X-Spam-Flag: No, tests=bogofilter, spamicity=0.000152, queueID=B7BC4332E7
X-Org-Mail: pierre.habouzit.2000@polytechnique.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26104>

--nextPart1312548.Pq6IQR5JuX
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le dim 27 ao=C3=BBt 2006 17:30, Jakub Narebski a =C3=A9crit :
> Pierre Habouzit wrote:
> > Le dim 27 ao?t 2006 12:52, Junio C Hamano a =C3=A9crit :
> >> About vger potentially throwing things away, I use this script
> >> (called "taboo.perl") to check my messages before sending them
> >> out.
> >
> > that was not it, I was biten (again) by git-send-mail that uses
> > strftime (localized) to generate rfc822 dates, making them
> > unparseable :|
>
> Update your git, or use ./git-send-email.perl directly from git
> repository (from 'master' branch, as 'next' branch version uses
> Git.pm). Strftime was replaced by pure Perl to generate rfc2822 date
> some time ago...

I know that, I've done that on many of my system, but not the one where=20
I hack git ... how lame isn't it ? :)
=2D-=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--nextPart1312548.Pq6IQR5JuX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE8cfIvGr7W6HudhwRAnrlAJ9eNFrYD0UlAmGFyMgEMifrJxkoogCfa9Pt
KtzmS0uo86SUPYLeWqq90oY=
=g1GM
-----END PGP SIGNATURE-----

--nextPart1312548.Pq6IQR5JuX--
