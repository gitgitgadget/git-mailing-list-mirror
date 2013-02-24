From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH 12/13] Documentation/Makefile: update git guide links
Date: Sun, 24 Feb 2013 09:58:31 -0500
Message-ID: <20130224145831.GL1361@odin.tremily.us>
References: <1361660761-1932-1-git-send-email-philipoakley@iee.org>
 <1361660761-1932-13-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=5LiOUhUlsRX0HDkW
Cc: GitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 15:59:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9d2f-0005yD-7r
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 15:59:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757792Ab3BXO6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 09:58:40 -0500
Received: from vms173021pub.verizon.net ([206.46.173.21]:50373 "EHLO
	vms173021pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755439Ab3BXO6j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 09:58:39 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173021.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIQ004ULC9K5260@vms173021.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 24 Feb 2013 08:58:37 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id D4E9A8C0D7D; Sun,
 24 Feb 2013 09:58:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361717911; bh=5q1h2n59SSpOPsJcMv3dQ1ByTaSFiFJvliV+4q28b6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TJYh4vNfum5z7umNF8C11jj1cpXOokLUwM7p6EejMYf/KNUaAeH0F0Wgi5GT9Dpwe
 JcPnzAA4YTGpBoLXYl+qZK+eoLprWVFCQev4pMquHk3b6W9L16D9TybvD+OlYPWqZj
 HrNlZWVbl6bSruOLTzeDbGJmBROjhgws4sYmjUS0=
Content-disposition: inline
In-reply-to: <1361660761-1932-13-git-send-email-philipoakley@iee.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216992>


--5LiOUhUlsRX0HDkW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 23, 2013 at 11:06:00PM +0000, Philip Oakley wrote:
>  OBSOLETE_HTML =3D git-remote-helpers.html
> +OBSOLETE_HTML =3D everyday.html
> +OBSOLETE_HTML =3D user-manual.html
>  DOC_HTML=3D$(MAN_HTML) $(OBSOLETE_HTML)

Should be '+=3D' instead of '=3D'.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--5LiOUhUlsRX0HDkW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRKiqWAAoJEEUbTsx0l5OMpeUQAIIFpUrgPd77JNZss+GWBtg4
OGdBlzT3DiRSj1p53+cxXkMYYrN6HaiOZxzztjF7eiSABbXmvBevTdw/fYQSms93
Gvc7tU1t/F126mLbPdun0+POLjJxYXoxe4SpVHtv9300zECFYkabrp46EuaMVAtn
gbfxNPfQg5+vov9KtCxBygraS0G13I4wtKDheXNa+UIZtb0yzmUjpvtv+lwNSqpX
gWY9CpROSGXk3q9whJd9JvXU5m4X/wuZ8aJ2IqyGgj2B36XoRN+978bwD/L552/1
qbM61eA82NAiQBal61Ie562yJAgUI6G9wYLml6iYXEKrSxCXCTPItCPSpDKi69lB
3N09eotWnyDdbl+VzZAhNf58fhdEF/hgaxPerbzTr8Cubi2zHpHbqHd5LAQ7cdhU
bE/HlD9jXd6+OGERBY9eWXtYW71pYD2zHYW6QK0nqfE1Sm/cMSdm4AjlcYFsBUWw
0Frs0RmM8fNvwHl5sJFxiW1VPYLbTx37uCcCE0JTfkmBUWqyvT0xr73p3IWRvFfe
jmc/+Sr++RHGXjeKCHBv7fVx33E1Qhn/Tr5dHgeCiknm1fMHoOT88N4OH4cocw0q
l6A2sjkr3vjgYWUmp9fu94w5w10j9xpUpG6c3HovjO2M3xonwEJErT1ySnlwSFIb
hYVbd45ylgT3Tp8rgvNa
=01md
-----END PGP SIGNATURE-----

--5LiOUhUlsRX0HDkW--
