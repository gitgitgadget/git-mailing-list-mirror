From: Rene Moser <mail@renemoser.net>
Subject: [CLOSED FIXED] Bug: file named - on git commit
Date: Mon, 28 Jan 2013 12:19:37 +0100
Message-ID: <51065EC9.5030308@renemoser.net>
References: <51065540.1090007@renemoser.net> <87txq11sbk.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2OSSGJPAHDFQQAGWPIJRK"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 28 12:20:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzml4-0000Tp-6B
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 12:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756639Ab3A1LTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 06:19:51 -0500
Received: from renemoser.net ([88.198.132.86]:44408 "EHLO mx1.resmo.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756314Ab3A1LTr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 06:19:47 -0500
Received: from [192.168.123.40] (adsl-89-217-73-126.adslplus.ch [89.217.73.126])
	by mx1.resmo.ch (Postfix) with ESMTPSA id C04552D6804E
	for <git@vger.kernel.org>; Mon, 28 Jan 2013 12:19:45 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <87txq11sbk.fsf@pctrast.inf.ethz.ch>
X-Enigmail-Version: 1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214832>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2OSSGJPAHDFQQAGWPIJRK
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/28/2013 12:05 PM, Thomas Rast wrote:
> This was fixed by Junio around 4682d85 (diff-index.c: "git diff" has no=

> need to read blob from the standard input, 2012-06-27), which is
> included starting with v1.7.12 and the v1.7.11.3 maint release.  Please=

> upgrade.

Thanks.



------enig2OSSGJPAHDFQQAGWPIJRK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlEGXskACgkQHXu/ROUxaMfLEwCfR0hhJYgbaipIrsvg4mPNz29c
5R4Anjx1/wEYCvkRinDEQvkMDM0AAP15
=VwLJ
-----END PGP SIGNATURE-----

------enig2OSSGJPAHDFQQAGWPIJRK--
