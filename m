From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 01 Nov 2007 22:44:50 +0100
Message-ID: <20071101214450.GC7161@artemis.corp>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org> <7vmytycykt.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.999.0711011129460.3342@woody.linux-foundation.org> <916BE4AD-5BD9-48E6-8026-B1AC7387E28D@adacore.com> <7v4pg5btis.fsf@gitster.siamese.dyndns.org> <20071101204755.GA15842@glandium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="ALfTUftag+2gvp1h";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>,
	Geert Bosch <bosch@adacore.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 22:45:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inhqd-0005Lf-09
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 22:45:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753474AbXKAVox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 17:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753500AbXKAVox
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 17:44:53 -0400
Received: from pan.madism.org ([88.191.52.104]:47024 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753086AbXKAVow (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 17:44:52 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 4391327F93;
	Thu,  1 Nov 2007 22:44:51 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id F10C0324697; Thu,  1 Nov 2007 22:44:50 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Mike Hommey <mh@glandium.org>, Junio C Hamano <gitster@pobox.com>,
	Geert Bosch <bosch@adacore.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071101204755.GA15842@glandium.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63016>


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 01, 2007 at 08:47:55PM +0000, Mike Hommey wrote:
> On Thu, Nov 01, 2007 at 01:27:55PM -0700, Junio C Hamano wrote:
> > Geert Bosch <bosch@adacore.com> writes:
> >=20
> > > I often type "make clean" as well many "git xyz" commands
> > > during development, and so it happens that at times, I type
> > > "git clean" by accident.
> >=20
> > Happened to me once.  I hate that command.
>=20
> Speaking of hateful commands, git stash clear is one of them.
> I tend to type git stash clean, which creates a "clean" stash...

  I agree, the most itching issue is that usually, this action in git is
called `prune'. So it's inconsistant. I would have much prefered that
git stash would take its actions as options so that if you mistakenly
type a wrong command, the options parsers sees that and fails.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHKkjSvGr7W6HudhwRAloXAJ4uOamd+1j7rgOQeQsJBkmCaZOxRgCeI4Ao
G76GXgclNjktCfmKSstXaP0=
=TE5c
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
