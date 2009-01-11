From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] filter-branch: add git_commit_non_empty_tree and --prune-empty.
Date: Sun, 11 Jan 2009 15:55:37 +0100
Message-ID: <20090111145537.GB18484@artemis.corp>
References: <20081030132623.GC24098@artemis.corp> <1225445204-28000-1-git-send-email-madcoder@debian.org> <7viqr5wgl7.fsf@gitster.siamese.dyndns.org> <20081103092729.GE13930@artemis.corp> <20081103151826.GJ13930@artemis.corp> <76718490901091129q534ca981iac54e0653d76170d@mail.gmail.com> <20090111111800.GA8032@artemis.corp> <alpine.DEB.1.00.0901111433580.3586@pacific.mpi-cbg.de> <20090111142732.GA18484@artemis.corp> <bd6139dc0901110640l148b00dctd667572e28908f9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="v9Ux+11Zm5mwPlX6";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	pasky@suse.cz
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 11 15:57:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM1ka-0002UI-DY
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 15:57:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754468AbZAKOzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 09:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753625AbZAKOzm
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 09:55:42 -0500
Received: from pan.madism.org ([88.191.52.104]:60804 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753593AbZAKOzl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 09:55:41 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 157DD3C4ED;
	Sun, 11 Jan 2009 15:55:39 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id E52B02B100; Sun, 11 Jan 2009 15:55:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <bd6139dc0901110640l148b00dctd667572e28908f9f@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105185>


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2009 at 02:40:04PM +0000, Sverre Rabbelier wrote:
> On Sun, Jan 11, 2009 at 15:27, Pierre Habouzit <madcoder@debian.org> wrot=
e:
> >> And I suggested to merge the tests with Sverre's patch.  That suggesti=
on
> >> also went unaddressed.
> >
> > I can't find any mails from Sverre in the same thread, but maybe I'm not
> > searching in the proper place...
>=20
> I think my patch is in a different thread as it was a
> documentation-only patch, no?

No I've found it, it was sent by Petr which explains why I didn't find a
mail from _you_ :P

Will sent a patch reworked to have a special paragraph the way you
wanted, but using my additions instead.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklqCGkACgkQvGr7W6Hudhz4vgCeNwQRdEfk4uDoAns4gBdmKBvJ
2oAAn1/2gE9mlN4yQnS9aRcRSbaw5Wfg
=tuad
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
