From: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <carlos@cmartin.tk>
Subject: Re: git bash
Date: Fri, 17 Jun 2011 16:18:22 +0200
Message-ID: <20110617141822.GD7751@centaur.lab.cmartin.tk>
References: <4DFB5C37.1090606@micronengineering.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Cc: git@vger.kernel.org
To: Massimo Manca <massimo.manca@micronengineering.it>
X-From: git-owner@vger.kernel.org Fri Jun 17 16:18:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXZsS-0007e1-HF
	for gcvg-git-2@lo.gmane.org; Fri, 17 Jun 2011 16:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758646Ab1FQOSX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jun 2011 10:18:23 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:57922 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756785Ab1FQOSW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2011 10:18:22 -0400
Received: from centaur.lab.cmartin.tk (brln-4db9e046.pool.mediaWays.net [77.185.224.70])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id E5F15461DB;
	Fri, 17 Jun 2011 16:17:48 +0200 (CEST)
Received: (nullmailer pid 8248 invoked by uid 1000);
	Fri, 17 Jun 2011 14:18:22 -0000
Mail-Followup-To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <carlos@cmartin.tk>,
	Massimo Manca <massimo.manca@micronengineering.it>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <4DFB5C37.1090606@micronengineering.it>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175947>


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 17, 2011 at 03:52:55PM +0200, Massimo Manca wrote:
> Hi all,
> I am using git on Linux Ubuntu, Windows Vista, , Windows 7 and Windows
> XP (several o.s. to develop sw).
> In my notebook under Vista if I use bash on mi physical HD (it is
> divided in C:, F:, H:) it works, if I try to open a bash console on an

Assuming you mean that git doesn't work (rather than bash), could you
provide a transcript of what you think went wrong?

> external HD (or USB or SD memories) and also on network shared drives it
> doesn't work.

Are these filsystems FAT32 by any chance. You may need to turn on a
couple of compatibility options like case-insensitivity and filemode.

   cmn
--=20
Carlos Mart=C3=ADn Nieto | http://cmartin.tk

"=C2=BFC=C3=B3mo voy a decir bobadas si soy mudo?" -- CACHAI

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN+2IuAAoJEHKRP1jG7ZzT8LgIAI7iJj0HLizsXk+rK8DkZNVl
J+c/e7VXSHZUgSHIsy0duCmaeXagaOSc56LQHJ+Bu6VFoOHkBpGz4sKpvN/7U9OE
G1wepVuJTUqwGqi7IlYrrBf6vaQe+7OXlLZNbh/wW7RSXJuL7X71hABfbGKBVktt
p0cPZlnZbPAmBt1F8vptZJhNZ/s0qP3XgdzN+7kjRx5OwGMzsmeJZQ3EBoZ0SHRl
QdbqGGhhwZt1dX0X11UpC/6k/50A9uvCAum9GNlquIm8vZmHkuozs6KohbpUsmTV
y+NKAXqjK8zNInYN9iXXEHV4f4/OsX9kBMebHsXysm5g+KYocg3kcMDpa8KiYuQ=
=si0e
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
