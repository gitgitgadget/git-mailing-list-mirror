From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Fwd: Compiling git 1.8.1.4 on 64bit centos 5.6
Date: Sat, 23 Feb 2013 10:44:48 -0500
Message-ID: <20130223154448.GB32406@odin.tremily.us>
References: <CA+B9=JLWASmrK_TNTkJxRH1cZrVjhXN8kKmCZcnHgKXwX9WUiA@mail.gmail.com>
 <CA+B9=JLaZ5P+H-b-A6Xo-TRMcQYwGawjD-G62m8asnC0qMwmdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=wq9mPyueHGvFACwf
Cc: git@vger.kernel.org
To: Darren Oakey <you@darrenoakey.info>
X-From: git-owner@vger.kernel.org Sat Feb 23 16:45:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9HIE-0000Vj-Cy
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 16:45:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759220Ab3BWPpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 10:45:08 -0500
Received: from vms173015pub.verizon.net ([206.46.173.15]:50946 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759221Ab3BWPpG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 10:45:06 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIO006V9JQPHG30@vms173015.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 23 Feb 2013 09:44:50 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id E6BD08C015E; Sat,
 23 Feb 2013 10:44:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361634288; bh=Iyep83quKQ+bkWGnrfmTfrlocqjPFXXPVM8aXAHT66Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LyOaVgs2r+m61ziDaThw8QNr0fUPrgSe/pw7v7IUDJRnel1aa4c+SC8FlUNhpoCzy
 aGqQGk3iZo18Y3lbTi3+HnJW0VI/9hPuksYYnJWb2n7JA/Fy1xYB6Aoi87TyChqQBm
 fehTXpkCU/GfhSUBtzgzx91ubv+nZ1MvzqySSqM4=
Content-disposition: inline
In-reply-to: <CA+B9=JLaZ5P+H-b-A6Xo-TRMcQYwGawjD-G62m8asnC0qMwmdg@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216900>


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 24, 2013 at 12:13:11AM +1100, Darren Oakey wrote:
> If I compile without static, it works - but the shared libraries
> aren't found when it's run from the web host.  If I try running the
> 32bit version on the 64bit host, it doesn't find some library

This is a shot in the dark, but are you sure you have static versions
of the libraries in questions (*.a) installed?

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRKOPuAAoJEEUbTsx0l5OMXm8P+wVa9yCjbCTilGI2XBUM8mAw
xNXRO+2cd2mn6/a86l7j+ihTERUiypcIy5FJXszRDAtalwCXNYvTyRBEpXqZ3OmC
yC/4KY/z3SBgVJTpvGhKn3skLhB8T5DQfAqdyC0dlD1mbDGN8E7N2cFH2STnao7N
8ZSpSZXKSeZSLYMn2xfler27vvGyAcBlHJy6TWx3F+6oumiD/tH9naY1U+wFhI3M
G95bwKMV21fEP+XFdp2k3MNYkrnKFytp9LwWuQYm4l0woqgQGzx/rlpdWGDoZoVk
NQ41aQHb2/9QVImBN7+eaIM8gb8bt/dc4EIJhoqZsBHloSuJETEbb3KDJQPQ5q1z
Uxtpg5NqO7bRGtSR8772IDTzWEcGMDCtucmTTIzlwlxZsp7jOMp+NVzZ/7lIKjon
rDwisi02tfuEbCfqQjXyeZa2jRMFiwLBxh5hkM0Ww5GmBaq5GHur1oqqChEv0OAF
9oB2DGOpgS7be6Jh7tF9b2BHlehGKhm4L4A+am1MBCIFHsV9LsvU2m4A2VRCLQgs
BRjoAPmB9xvwUgesXuI7l51K3W2JjivjYT1qnJLorJB1Z9xlVGJdWPP54YBfkn8P
W5f+ZdGryoj8wwHZCRSS1sDatcgrYeGQtyCX3szNwrfZzmVPAmRLEe9d/SppOxr5
Dl7pXtgiUsM4kSAIJEkF
=gPmX
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
