From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: "git apply" can't add new files to repo ?
Date: Fri, 15 Jul 2011 22:21:12 +0200
Message-ID: <1310761272.7308.26.camel@centaur.lab.cmartin.tk>
References: <CAAnh3_-ayozWnHR-ViJ3zjXQvPQA1kd9spGV_TEU=-kFzBytvw@mail.gmail.com>
	 <1310758497.7308.20.camel@centaur.lab.cmartin.tk>
	 <7v4o2n1evs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-avsPOe5Jvnkn6laTSyKO"
Cc: Yang <teddyyyy123@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 15 22:21:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qhot5-0003Ob-4b
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 22:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121Ab1GOUVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 16:21:18 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:41094 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751639Ab1GOUVR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 16:21:17 -0400
Received: from [192.168.1.17] (brln-d9ba3451.pool.mediaWays.net [217.186.52.81])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 8258C461F5;
	Fri, 15 Jul 2011 22:21:15 +0200 (CEST)
In-Reply-To: <7v4o2n1evs.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.32.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177225>


--=-avsPOe5Jvnkn6laTSyKO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2011-07-15 at 13:13 -0700, Junio C Hamano wrote:
> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
> > git-apply is just a wrapper around the patch(1) utility.
>=20
> Huh?

That was a thinko; I've always considered git-apply to be little more
than patch(1), but it does look like it does much more. I should have
re-looked at the man page earlier.

Sorry for the noise,
   cmn

--=-avsPOe5Jvnkn6laTSyKO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOIKE4AAoJEHKRP1jG7ZzTXRIH/j8T8pHQbic4OIiuvXzBqvb/
Q63UxuUHGiz6JAIt4Dc3TETvC4ei3fBL/lMQVJkQEZhIvEfsGMEE/8GxVS5GLBRT
Xu2hby+CVEfTBqY07XyjTDzERBken7FLMrLvuQIx1yH/ue1OuwAMAgArNYd3LPtt
ixnjsVhFBtSr82tdcAPUwebN5dgyVtg3EBkS3z5sOFGnyqaRszui1RNIIeKktqgC
XElNECrED0x8UQ44+sLAYBPettlLFnvy0dhlYYO9h1foXAHZX7ihV0uYBHwXMNRM
azU0VaBCehJg5eBsiDSw76ONUri1AWPLgtFILKWlCQHeFHsF//NGl3x3hfLvC2g=
=0+Ue
-----END PGP SIGNATURE-----

--=-avsPOe5Jvnkn6laTSyKO--
