From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH] user-manual: Fix the interactive rebase example commit
 range
Date: Sun, 24 Mar 2013 16:22:08 -0400
Message-ID: <20130324202208.GK4343@odin.tremily.us>
References: <7vobfg3tw8.fsf@alter.siamese.dyndns.org>
 <c29df638e260ab104bf940cc41ce5d75713707a8.1364127610.git.wking@tremily.us>
 <CAPig+cS5_YLpNO559ZFTg8SAVrOPAaUmhA6tKOeMG+hv3D3SPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=DozTQjXnjm3C9Xhk
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 21:22:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJrR8-0003FI-W6
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 21:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754733Ab3CXUWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 16:22:11 -0400
Received: from vms173015pub.verizon.net ([206.46.173.15]:32977 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754692Ab3CXUWK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 16:22:10 -0400
Received: from odin.tremily.us ([unknown] [72.68.93.192])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MK6001F2LWWN770@vms173015.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 24 Mar 2013 15:22:09 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 4C107939089; Sun,
 24 Mar 2013 16:22:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1364156528; bh=BBX8v1aV5QvoDwQLB8h0ve/SS9nUcjyYBueyWGKksFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=muEs22aRHwqkA5sS5cFWiS8Xrk2LjyqEwju+hjo6n2aFWFPrbFrshaavVi4fmphgy
 QInmcy74Phw5x2+2rTTJt0ycMs458BlLaPTGL3qJR0odWV/JJGq1a5p08G5srUDSqn
 QGoemQ7vmHrJWu2MvbZxY0yxEb5LnucN8TQeUU/g=
Content-disposition: inline
In-reply-to: <CAPig+cS5_YLpNO559ZFTg8SAVrOPAaUmhA6tKOeMG+hv3D3SPA@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218976>


--DozTQjXnjm3C9Xhk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2013 at 04:00:17PM -0400, Eric Sunshine wrote:
> On Sun, Mar 24, 2013 at 8:23 AM, W. Trevor King <wking@tremily.us> wrote:
> > I also reworded the example commit summaries (onelines), because I
> > think my initial mistake may have been to to misinterpreting "this
>=20
> s/to to/due to/

Oops, thanks :).

--DozTQjXnjm3C9Xhk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRT2BvAAoJEEUbTsx0l5OMf5MP/Rk1o6dTIEvsMsndAFyvWB46
8CYBop0BzLJawupgXZCHVgvXWkPGkLVQYQ8jDacGEoRm2TZYaKNCsmd74LBC+4V6
nLtX0Ppn/1PG3h2ZIGenf13H67BUYWN8UCJXoCvPM7/ZXZ2RjtEJPABmv+NRVkSK
EugaaEm51uhMkulDkE+x/r3yNtd9Bk3xZlzcYy/ywMqUbqImqqURLL9syCUPMjX7
E2ZDhI42qOeoeHUrtcQawMWtazB5qLrD/qTrq8d5McXiDAt34KP32tP/yQ3p+15O
Lk4GytG8qoMJE7FgYjNIn+vdFjLMrQqkNUsLWY4vWjUTb/gICtDJgffKRBbxLwgI
CxDlq4W5AQDo/gfovQjC4HnOTnoM4UlF3omRMv9iGFfEKkRRAOaDsP6btSB2RxVF
eXmptoNyLUNse7PFo5qVSYPq3UfQl07Y1exn6fCkusSmUalrDtOwDg4pHjDdHyNq
wEiPB/nYRAdHA9SgSRwqm13gIbICw50Ae7Ks/yGvyeEK3cLRyrRFQ0+rs1qEWg3p
udtOREYyE3+M+g9VuKiaNznmc6QFF/hJO6Xn1uABCAA6CB82/lPQ2UR5OQCMHUKy
6hIZI5JNREIfWffzXcuS/G7bBGQrE2KSXXvFjBlrXtLp/9DL3JW6+mhXOWrOBYXB
Ks38F7M7P8kRX/o7Fgm+
=g7r/
-----END PGP SIGNATURE-----

--DozTQjXnjm3C9Xhk--
