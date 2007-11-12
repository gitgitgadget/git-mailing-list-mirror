From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 12 Nov 2007 15:53:34 +0100
Message-ID: <20071112145334.GB343@artemis.corp>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org> <7vmytycykt.fsf@gitster.siamese.dyndns.org> <7vr6j6ve90.fsf@gitster.siamese.dyndns.org> <7vir4d40sw.fsf@gitster.siamese.dyndns.org> <7vwsso3poo.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711121203150.4362@racer.site> <20071112122652.GC20482@artemis.corp> <Pine.LNX.4.64.0711121232370.4362@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="p4qYPpj5QlsIQJ0K";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 15:53:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irafg-0000PY-Fa
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 15:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbXKLOxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 09:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbXKLOxg
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 09:53:36 -0500
Received: from pan.madism.org ([88.191.52.104]:44590 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751170AbXKLOxf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 09:53:35 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id E569329B41;
	Mon, 12 Nov 2007 15:53:34 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 8D58814738F; Mon, 12 Nov 2007 15:53:34 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711121232370.4362@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64631>


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 12, 2007 at 12:33:19PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Mon, 12 Nov 2007, Pierre Habouzit wrote:
>=20
> > On Mon, Nov 12, 2007 at 12:21:34PM +0000, Johannes Schindelin wrote:
> >=20
> > > On Sun, 11 Nov 2007, Junio C Hamano wrote:
> > >=20
> > > > * js/rebase-detached (Thu Nov 8 18:19:08 2007 +0000) 1 commit
> > > >  + rebase: operate on a detached HEAD
> > >=20
> > > Note: this might have a subtle bug when the last patch in the series=
=20
> > > failed.  If I was not too tired this morning (which might well have=
=20
> > > been the case), rebase could not switch back to the branch correctly=
=20
> > > with this.
> >=20
> >   OOOH so this was what happened to me today then. I did a rebase, ther=
e=20
> > was a commit to skip, the last one, and I ended up on a detached head.=
=20
> > As I didn't had my coffee yet, I assumed this was my fault and did=20
> > something stupid. So after all it seems it wasn't the case then :)
>=20
> Thanks for acknowleding, and sorry for the bug.

  well, shit happens, I'm running next especially to spot those :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHOGjuvGr7W6HudhwRAttWAJ422OtJcvb5vHFZ37XZ+GHDhSc/MgCfd45q
/B9zblxnCzuQd5D7SnyXJ9I=
=nyWl
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
