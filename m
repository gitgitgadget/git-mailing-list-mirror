From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [RFH] QGit: how to cram a patch in a crowded screen
Date: Mon, 4 Jun 2007 17:41:19 +0200
Message-ID: <20070604154119.GA3299@efreet.light.src>
References: <e5bfff550705260146q51350f40q1c80cfe8079f47c6@mail.gmail.com> <200705261034.53723.andyparkins@gmail.com> <e5bfff550705261344l604543e7h64c20c1fc0979f20@mail.gmail.com> <20070527153852.GA30365@efreet.light.src> <e5bfff550705270856o195b9075u1c99a05e79d69742@mail.gmail.com> <20070531195633.GA3252@efreet.light.src> <e5bfff550706020437i3f54d459rdbe9070fe03a28c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Pavel Roskin <proski@gnu.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 17:43:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvEin-00054x-A2
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 17:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756074AbXFDPnY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 11:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755441AbXFDPnY
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 11:43:24 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:53083 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753908AbXFDPnX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 11:43:23 -0400
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 3B72A57758;
	Mon,  4 Jun 2007 17:43:22 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HvEgJ-0001FJ-HU; Mon, 04 Jun 2007 17:41:19 +0200
Content-Disposition: inline
In-Reply-To: <e5bfff550706020437i3f54d459rdbe9070fe03a28c9@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49109>


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 02, 2007 at 13:37:03 +0200, Marco Costalba wrote:
> On 5/31/07, Jan Hudec <bulb@ucw.cz> wrote:
> >
> >I have to say that I like the gitk way better. There is the issue of
> >over-scrolling. I often want to quickly scan through the diff, so I scro=
ll
> >pretty quickly and it switches over when I reach the end.
> >
>=20
> Ok. "Smart Browsing" ;-)  patch series pushed to qgit4.
>=20
> Refer to patches logs for a little documentation.
>=20
> Please give feedback if this patch series it's not smart enough for you.

I think it feels quite good. And leaves room for additional pages. Ie. merge
could have the "interesting" (--cc) diff and diff against each parent in
turn.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGZDKfRel1vVwhjGURAp/dAJ94GVwpCI3D6teAQEAIdBWthMy2jgCeLgAm
4pxBMTib9JOaZuGvvJnHFv8=
=muKY
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
