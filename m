From: Jan Hudec <bulb@ucw.cz>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 20:34:55 +0100
Message-ID: <20071126193455.GC25784@efreet.light.src>
References: <200711252248.27904.jnareb@gmail.com> <fiet88$68n$1@ger.gmane.org> <2A34D324-48A4-49EF-9D4E-5B9469A0791D@lrde.epita.fr> <20071126185600.GA25784@efreet.light.src> <85prxw253u.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
Cc: Benoit Sigoure <tsuna@lrde.epita.fr>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 20:36:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwjkK-0005aZ-F0
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 20:35:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169AbXKZTfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 14:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754153AbXKZTfE
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 14:35:04 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:45582 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754134AbXKZTfB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 14:35:01 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id DBC5357635;
	Mon, 26 Nov 2007 20:34:59 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id jN0dz+0Dxwtd; Mon, 26 Nov 2007 20:34:57 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 6AD1E57295;
	Mon, 26 Nov 2007 20:34:57 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1IwjjL-0006rJ-5Y; Mon, 26 Nov 2007 20:34:55 +0100
Content-Disposition: inline
In-Reply-To: <85prxw253u.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66100>


--vEao7xgI/oilGqZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2007 at 20:12:37 +0100, David Kastrup wrote:
> Jan Hudec <bulb@ucw.cz> writes:
>=20
> > On Mon, Nov 26, 2007 at 18:10:10 +0100, Benoit Sigoure wrote:
> >> On Nov 26, 2007, at 5:46 PM, Andy Parkins wrote:
> >> While we're discussing bad names, as someone already pointed out, I ag=
ree=20
> >> it's sad that "git push" is almost always understood as being the oppo=
site=20
> >> of "git pull".
> >
> > Well, it is an oposite of pull. Compared to it, it is limited in that i=
t will
> > not do a merge and on the other hand extended to *also* be an oposite of
> > fetch, but still oposite of pull is push.
>=20
> With the same reasoning the opposite of a duck is a lobster, since a
> lobster has not only fewer wings, but also more legs.

No.

The basic pull/push actions are:

git pull: Bring the remote ref value here.
git push: Put the local ref value there.

Are those not oposites?

Than each command has it's different features on top of this -- pull merges
and push can push multiple refs -- but in the basic operation they are
oposites.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHSx/fRel1vVwhjGURAlroAJ0aG38OHcjepLiuAMHAV/T5u1KW3ACdGdIU
6GrG9yulibgWqvfxNv29QZA=
=AV6T
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--
