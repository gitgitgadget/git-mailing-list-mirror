From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: rev-parse doesn't take pwd into consideration
Date: Tue, 27 May 2008 00:14:41 +0100
Message-ID: <20080526231441.GA2508@bit.office.eurotux.com>
References: <7vhcckddov.fsf@gitster.siamese.dyndns.org> <20080526195812.GA23396@bit.office.eurotux.com> <200805262135.m4QLZtpq023003@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Cc: gitster@pobox.com, git@vger.kernel.org
To: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Tue May 27 01:15:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0lul-0008Mu-Jb
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 01:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755547AbYEZXOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 19:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755376AbYEZXOs
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 19:14:48 -0400
Received: from os.eurotux.com ([216.75.63.6]:45863 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754919AbYEZXOs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 19:14:48 -0400
Received: (qmail 23582 invoked from network); 26 May 2008 23:14:46 -0000
Received: from nc.eurotux.com (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 26 May 2008 23:14:46 -0000
Content-Disposition: inline
In-Reply-To: <200805262135.m4QLZtpq023003@mi0.bluebottle.com>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82973>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2008 at 06:35:10AM +0900, =E3=81=97=E3=82=89=E3=81=84=E3=81=
=97=E3=81=AA=E3=81=AA=E3=81=93 wrote:
> Quoting Junio C Hamano <gitster@pobox.com> writes:
>=20
> > This was discussed to death.  Check the list archive.
>=20
> Junio, sometimes I think you are being very mean.  I am reasonably sure y=
ou meant this one, but why didn't you give a pointer for him?
>=20
> http://thread.gmane.org/gmane.comp.version-control.git/68786/focus=3D68852

Well, that clears things up. Thanks again.

I've thought of changing only the git-show command, but I've since
realized that it will imply changing critical code used by every
command.

So I'll be content with git-showrel. :)

Best regards,
Luciano Rocha

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=C3=A1tica, S.A. <http://www.eurotux.com/>

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkg7RGEACgkQinSul6a7oB/95wCfb6h8Rk6kS9w/LueIMxIwgeFh
gqEAnjgDc0U9DQQymSHjnYXxqrhDM/tD
=KiK9
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
