From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v2 09/15] user-manual: Use 'git config --global user.*' for
 setup
Date: Sun, 10 Feb 2013 17:52:22 -0500
Message-ID: <20130210225222.GA8704@odin.tremily.us>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
 <b363f5b410098302a02af2d79b5b68ee79210be2.1360508415.git.wking@tremily.us>
 <7vip5zstsa.fsf@alter.siamese.dyndns.org>
 <20130210222508.GC8377@odin.tremily.us>
 <7vobfrrdjy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=17pEHd4RhPHOinZp
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:52:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4flU-0001Vz-Am
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 23:52:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757021Ab3BJWw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 17:52:28 -0500
Received: from vms173013pub.verizon.net ([206.46.173.13]:25426 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756775Ab3BJWw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 17:52:28 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI1000JA0VAHX50@vms173013.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 10 Feb 2013 16:52:23 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id B1928879D28; Sun,
 10 Feb 2013 17:52:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360536742; bh=jy1oCQY+SvZTP3z8jDohRgyNW6+Wa7HDZbcdN8pbM0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H7BAV3paCEpwEg7A1UguOE8zuoZ6H4ERfPT98uhVuu7CYOeY7wN0d9G+kzETwQuIJ
 FrOy8yz9G+vznfoGx4IZn8fgMyBGbsaGA4lgnUE2s1Pr/1VUPq33TqEVPh7MWeHJ9D
 uBs/sSyLgSVk1LMREINKv0TkvAK3qMXRFSVjCFpc=
Content-disposition: inline
In-reply-to: <7vobfrrdjy.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215964>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 10, 2013 at 02:48:01PM -0800, Junio C Hamano wrote:
> How about not saying anything and say "adds the following"?

Will do in v3.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRGCSkAAoJEEUbTsx0l5OM3jYP/0CLoTuExiPP7hS5zM9n1LOu
ylgzg346m0dog21MLqJvwU4OmVGMENbaeu3DhIi8o4WjEgtDtgHBfOS4g6/kfCxU
qzeWOvephJ7EVqSP6q4xf23X6fKquWZVe6nCtA6pZaNvRnM3G6Z6HylQGW2qV8fM
YtAph4a1MS7GnYIw50NHjww1sbWwbAsSbKVVvcupCmWZ9aD+zv/18EF3l3V9a7YO
vkk8aAoa9+9S4Yov8ok0O/JQVxHq/D20s2dDcseNAbs79QGMkeexruIZwIPEwx+T
fSrFPTR+JQFhzUVbQa3bY0jL4/RoB6Owo3b+KVCBKufWRTScIgU5RB/8X1FEeaui
W4j5XtXwZ5MzSm9kREc4WmNB+E6Z+Hn/VbQ7s9ptR3WDPPilFz68rmByKpg9MpUD
S9dqRs3d6X4YCtFXqAM2RW0ds8btnrOfXKouiXvWny5bxYbW3Rm+4O6W11uFGI0x
3vX7BBLg1ExuxABjFWg7r/YR9lIL2yDpKuv5W5twb/3ULZmkHDVr46qLmIkKLDap
KOLd45db0R62HQEJKLf5WlcrNzx6DeUawNOGy8nTnxn2RpZRwoR+FzyMw4P1rWqB
OV8BB/vcE4gPzGtKTJIzGN2O42G4L8hdFlWE/M3LRvawiz8zbgS4/l9cZXc/Dm2X
OxB3k69pI2y4zWHeZwXo
=8hp2
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
