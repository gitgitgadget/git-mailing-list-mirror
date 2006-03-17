From: smurf@smurf.noris.de
Subject: Re: git-cvsimport "you may need to merge manually"
Date: Fri, 17 Mar 2006 08:26:02 +0100
Message-ID: <20060317072602.GH14562@smurf.noris.de>
References: <86veud23v0.fsf@blue.stonehenge.com> <7vu09x7puo.fsf@assigned-by-dhcp.cox.net> <86r75122yj.fsf@blue.stonehenge.com> <7vk6at7o06.fsf@assigned-by-dhcp.cox.net> <86fylh20x6.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M/SuVGWktc5uNpra"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 17 08:34:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FK9U9-0000bK-QH
	for gcvg-git@gmane.org; Fri, 17 Mar 2006 08:34:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560AbWCQHey (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Mar 2006 02:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752563AbWCQHey
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Mar 2006 02:34:54 -0500
Received: from run.smurf.noris.de ([192.109.102.41]:7582 "EHLO smurf.noris.de")
	by vger.kernel.org with ESMTP id S1752560AbWCQHey (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Mar 2006 02:34:54 -0500
Received: from smurf by smurf.noris.de with local (Exim 4.60)
	(envelope-from <smurf@smurf.noris.de>)
	id 1FK9LW-0002QB-5N; Fri, 17 Mar 2006 08:26:02 +0100
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Content-Disposition: inline
In-Reply-To: <86fylh20x6.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17662>


--M/SuVGWktc5uNpra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Randal L. Schwartz:
> Yeah, this doesn't make sense.  It used to "Just Work".  I can
> certainly add "git reset --hard" to my workflow, if that's the real
> work around.  And if so, the manpage should document that.
>=20
The real workaround is not to import into live branches,
which is not a git-cvs-specific problem, so I didn't add that
to its manpage.

I'm not opposed to an appropriate patch if you think its necessary.
If you do, keep in mind that there are other git-*import scripts out
there which presumably have the same problem. ;-)

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
That which is good to be done, cannot be done too soon; and if it is
neglected to be done early, it will frequently happen that it will not be d=
one
at all.
					-- Bishop Mant

--M/SuVGWktc5uNpra
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEGmSK8+hUANcKr/kRAg7vAJ44LmUeUDen/v91JDo5+3VqcCztoACfd4ae
D6HLwT/tkkwyjYGJxspBiMA=
=0Oqi
-----END PGP SIGNATURE-----

--M/SuVGWktc5uNpra--
