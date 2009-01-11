From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] filter-branch: add git_commit_non_empty_tree and --prune-empty.
Date: Sun, 11 Jan 2009 12:18:00 +0100
Message-ID: <20090111111800.GA8032@artemis.corp>
References: <20081030132623.GC24098@artemis.corp> <1225445204-28000-1-git-send-email-madcoder@debian.org> <7viqr5wgl7.fsf@gitster.siamese.dyndns.org> <20081103092729.GE13930@artemis.corp> <20081103151826.GJ13930@artemis.corp> <76718490901091129q534ca981iac54e0653d76170d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Dxnq1zWXvFF0Q93v";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	pasky@suse.cz, srabbelier@gmail.com
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 11 12:19:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLyLt-0006lf-3N
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 12:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbZAKLSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 06:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbZAKLSH
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 06:18:07 -0500
Received: from pan.madism.org ([88.191.52.104]:49455 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbZAKLSG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 06:18:06 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id F25AD14A;
	Sun, 11 Jan 2009 12:18:01 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id B50252B100; Sun, 11 Jan 2009 12:18:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <76718490901091129q534ca981iac54e0653d76170d@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105165>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 09, 2009 at 07:29:15PM +0000, Jay Soffian wrote:
> On Mon, Nov 3, 2008 at 10:18 AM, Pierre Habouzit <madcoder@debian.org> wr=
ote:
> > On Mon, Nov 03, 2008 at 09:27:29AM +0000, Pierre Habouzit wrote:
> >> On Mon, Nov 03, 2008 at 04:58:44AM +0000, Junio C Hamano wrote:
>=20
> Bump, http://thread.gmane.org/gmane.comp.version-control.git/99440/
>=20
> (I'd like to see this included. Having a bunch of empty commits after
> using filter-branch to remove unwanted files from history is, er,
> sub-optimal, so seems like it might even be default behavior?)

Yeah I have that in my own git tree, and I meant to ask if something had
to be fixed for it to be accepted for some time, but always forget about
it.

Junio, do you think this could be accepted, or does it need some work ?

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklp1WcACgkQvGr7W6Hudhz28ACfVelUc4dS25gDWU03HhkmWKp7
eigAmwXg8FWsiJx6ymuqJ/ui97MEnXdN
=eWyR
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
