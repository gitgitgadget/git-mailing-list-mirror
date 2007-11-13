From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] Add support for # in URLs in git-remote (was: Re: [PATCH]
   New script: git-changelog.perl - revised)
Date: Tue, 13 Nov 2007 15:56:33 -0800
Message-ID: <473A39B1.7050709@freedesktop.org>
References: <67837cd60711030826q6b3b5c00l5b228531ab6a323e@mail.gmail.com> <Pine.LNX.4.64.0711031526060.4362@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig70B8BF9C74E881DD97A78B54"
Cc: Ronald Landheer-Cieslak <ronald@landheer-cieslak.com>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 14 00:57:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is5cz-0008Om-IS
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 00:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755319AbXKMX4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 18:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756730AbXKMX4w
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 18:56:52 -0500
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:40153 "EHLO
	mail2.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754996AbXKMX4v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 18:56:51 -0500
Received: (qmail 29450 invoked from network); 13 Nov 2007 23:56:50 -0000
Received: from host-241-99.resnet.pdx.edu (HELO [131.252.241.99]) (josh@[131.252.241.99])
          (envelope-sender <josh@freedesktop.org>)
          by mail2.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <Johannes.Schindelin@gmx.de>; 13 Nov 2007 23:56:50 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.6 (X11/20071009)
In-Reply-To: <Pine.LNX.4.64.0711031526060.4362@racer.site>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64915>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig70B8BF9C74E881DD97A78B54
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin wrote:
> On Sat, 3 Nov 2007, Ronald Landheer-Cieslak wrote:
>> The attached patch adds support for # signs in URLs passed to git-remo=
te=20
>> add.
>=20
> NACK!
>=20
> Please be polite enough to read up on the _many_ emails on this list ab=
out=20
> this very subject.
>=20
> Not doing so just _wastes_ our time.
>=20
> Sorry for being so harsh, but this very subject easily cost me 20 hours=
 in=20
> total(!) in the last few weeks.

Perhaps this should go in the Git FAQ at
http://git.or.cz/gitwiki/GitFaq .  Does your message with Message-ID
<Pine.LNX.4.64.0710162228560.25221@racer.site>, subject "Re:
remote#branch", accurately describe the full problem with using #,
namely that refs can contain #?

Any other problems besides not having the ability to reference more
than one branch with this syntax?

- Josh Triplett


--------------enig70B8BF9C74E881DD97A78B54
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHOjmxGJuZRtD+evsRAgtWAJ40QlE14NnPLOm9HRnBo4crgN1aLACeNBYe
6dc0h/OO+0nfLm3O2EMsIpc=
=joaI
-----END PGP SIGNATURE-----

--------------enig70B8BF9C74E881DD97A78B54--
