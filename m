From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH 2/4] update-hook: show the contents of the tag message for annotated tags
Date: Tue, 20 Mar 2007 13:41:54 +0100
Message-ID: <20070320124154.GB22773@admingilde.org>
References: <200703201058.38519.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 13:42:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTdf5-0002qu-Ix
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 13:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933187AbXCTMl4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 08:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933312AbXCTMl4
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 08:41:56 -0400
Received: from mail.admingilde.org ([213.95.32.147]:33091 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933187AbXCTMlz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 08:41:55 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HTdf0-0007SU-RJ; Tue, 20 Mar 2007 13:41:54 +0100
Content-Disposition: inline
In-Reply-To: <200703201058.38519.andyparkins@gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42739>


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, Mar 20, 2007 at 10:58:38AM +0000, Andy Parkins wrote:
>   git cat-file tag $newrev | tail -q -n +5
>=20
> Which is dangerously reliant on the format of the tag object being four
> header lines then the message.

I think you can split at the blank line after the header.

--=20
Martin Waitz

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFF/9aSj/Eaxd/oD7IRAryuAJ9+yZGb7lLt7MF1jBKYJEp4dpr0nwCeJ+wY
2U9e6FwegiqbMdVioJ8G9Dw=
=ILvt
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--
