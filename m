From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: C99
Date: Sat, 4 Apr 2015 20:36:13 +0000
Message-ID: <20150404203612.GD10125@vauxhall.crustytoothpaste.net>
References: <1428097515.31333.2.camel@ubuntu>
 <xmqqfv8gg9bp.fsf@gitster.dls.corp.google.com>
 <1428107083.31333.11.camel@ubuntu>
 <20150404190400.GB10125@vauxhall.crustytoothpaste.net>
 <xmqqtwwvejzg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d01dLTUuW90fS44H"
Cc: David Turner <dturner@twopensource.com>,
	git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 22:36:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeUo3-0005UI-NY
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 22:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbbDDUgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2015 16:36:23 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:55323 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752648AbbDDUgW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Apr 2015 16:36:22 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:3964:791d:262f:be03])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 989C72808D;
	Sat,  4 Apr 2015 20:36:16 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	git mailing list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <xmqqtwwvejzg.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16.0-4-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266785>


--d01dLTUuW90fS44H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 04, 2015 at 01:06:43PM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > So it isn't as much of a "we don't want to move to C99" as much as "we
> > aren't yet willing to drop support for older versions of MSVC".
>=20
> I do not particularly like that 'we' in that sentence, which would
> give a false impression to people that we all want to switch and
> MSVC is the only thing that is holding us back.

Okay, I should have clarified my statement.  I appreciate the
correction.

Some people would like to move to C99, and so far the major objections
I've heard have been that MSVC doesn't support it and that C99's
benefits are unclear.  I didn't meant to speak for others in that we
should or should not, and there might be other objections I don't recall
or haven't heard.

I seem to recall Peff wanting to use variadic macros at some point,
although I can't recall specifically where.  We also already use hacks
to implement some of the features and hope that compilers will DTRT.

All the major compilers I'm aware of other than MSVC support C99, at
least well enough to do the things we'd likely end up doing.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--d01dLTUuW90fS44H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVIEs8AAoJEL9TXYEfUvaL55wQAIyyTWaXrGR3PonJuGUrWI23
5zvpr+qTN3dUXKojo9DhPojm/gFk7KkpomqUHlir/Hu0YSus06IIvRsnRXisxTBY
aGJDJwN8HzqMUgNVVlQYMKz0yOKK6QFlApyF21eRLgmafEccezYRUsdjamva6dgd
+UWS+LMGPnDyfVG3a9snWKuNXQEXFP/Xttm1219zeYrEpAFTrk2ti9ac5tNWXSmO
KtfaxC6YH753VoRp+1f9HShHCxiW8YcY3TQBMKGKeYHTMKaG4PeGSA+V/jnfzinn
AsVEdSLQeCgEgpmG/ElQebPK0LC8nv/8kRBBUDuhsEkTXKsVQlJSgTfrHvklH3Dz
zPhK2IZDn6Eo7jX8m9hwUXrESmslK/MNX2a2pymvf6pLf4PrsQWuyccXxoVB7c6j
dRPb0IiudL4MxgzJ2EstNnxPctNt6DXMr1K8/skOz0CE+VfIDqOfDQQaJg9/roA+
x3S7KOv7a9VpqGxIsQ6osUM8shuz9nvXjUjQTyy2KYqVeSfX4Ug5DgIZJkL/Pd1D
pwKwBeWmbGj00Wxxnb+joeEr9pvvj9xFVLRLaaWZLoiHXC6SKAkpfauZMLBCMwUu
sFZMCxw11xdVerTFBvrEppRjCbxaPE+6HBsI0wS7p+++VVsR5fAqGn2Xvb3CW4zX
ulT4TolAWZWzjXdMuj23
=4FRC
-----END PGP SIGNATURE-----

--d01dLTUuW90fS44H--
