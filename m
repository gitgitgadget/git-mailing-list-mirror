From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v2 0/4] Update linux-2.6.git location and related examples
Date: Sun, 30 Jun 2013 06:48:23 -0400
Message-ID: <20130630104823.GD25463@odin.tremily.us>
References: <7vppvhye6s.fsf@alter.siamese.dyndns.org>
 <cover.1371911897.git.wking@tremily.us>
 <20130630010532.GB25463@odin.tremily.us>
 <7vfvw0l6d9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=AbQceqfdZEv+FvjW
Cc: Git <git@vger.kernel.org>, David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 30 12:48:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtFBK-0004VG-2g
	for gcvg-git-2@plane.gmane.org; Sun, 30 Jun 2013 12:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916Ab3F3Ksa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jun 2013 06:48:30 -0400
Received: from vms173021pub.verizon.net ([206.46.173.21]:64193 "EHLO
	vms173021pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636Ab3F3Ks3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jun 2013 06:48:29 -0400
Received: from odin.tremily.us ([unknown] [72.68.95.119])
 by vms173021.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MP700BYTCOOG050@vms173021.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 30 Jun 2013 05:48:25 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id B8312A7903F; Sun,
 30 Jun 2013 06:48:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1372589303; bh=jR4cq0wc5RVaRCoqUL+Kwg/4KR+gyUiv98wPIyAjiJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PhCmvfNxpmM0x/98nO2JA2dTts0ohBTf917Lh34Yg7UFv4ERydNbQtX6S7Sp1fAe/
 egf8Ng6fmqS0CIH3xaxkzyrv6nP817XydRqrPuv1/EcLVkNZ7Q93uymXfRxpq7qvQq
 HNBJe+hSyEpdbFmiY2/x80rdtqeuuA4WhsVpid+Y=
Content-disposition: inline
In-reply-to: <7vfvw0l6d9.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229264>


--AbQceqfdZEv+FvjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2013 at 06:44:34PM -0700, Junio C Hamano wrote:
> "W. Trevor King" <wking@tremily.us> writes:
>=20
> > On Sat, Jun 22, 2013 at 10:46:23AM -0400, W. Trevor King wrote:
> >> David and Junio mentioned that I'd missed a few 2.6 references in my
> >> initial pass.  Here's a second attempt that does some deeper
> >> reworking of the effected sections.
> >
> > No comments after a week, so I'm giving this patch series a bump ;).
>=20
> Hmph, didn't I queue them on 'pu' already?

Oops, that would be my first time having a patch series queued without
comment ;).  Sorry for the noise.

Thanks,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--AbQceqfdZEv+FvjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR0Az0AAoJEKKfehoaNkbt5Y4QAKpIcO3AfRfkZUL7SYPYIz+4
SaV6NgoEqyxTXcvJoND7sc4eNyvwdQi/+MJPN5jdwEYS+KsAzMbBKnmluPWmZQr/
0v7VlwWRE0WZwIfCa62D6yfxsJPRQ30o1WZguA7zM7QE/8u53RKz2Snvqjdhs7ew
VOP6J8XSA3s4x59gTVG27NgL+R8yogzNAjbAYPYj2P6wtPbLiNSVbrAc8U+W5AQD
B1av3g0WB1nCyZ0uh5ivvRQ7te4ik9ZS6hY32f1OkTHGsSqIoED/fEvJxBS2VV2v
C5SYXKlCAtMFuaHFI9/vp0PYGIFRgLqOi0hMMUn8TvZLXfIbndMoO4npApvl57jD
Wl56b8NAgQtiZ2ez0y9plPVg4XZbUiWU9mvAE9nHbAFFRjJ1W6luk7zwxJfqk99e
vZyUJbS2RLTJxwQOm2aQYs8HuKzMUlvsBsOOrpFjop5WkO0UfMSlD9myIr/m4id6
9VrCgxc1nA7GDmm5YvI1u4F2nIAvnJzcbqru8FoeuEY7E07ZlRl/nfSat+ckrMtn
zNPiV6RqH7gU/2UsRCIT0UcdcX8u3Dx+boZ6wtsH+yjCO5uVkXFM53lShiAeWjUH
87shk1yyz4bLu9LzZRmEuP9TC07q0clsAPc8Gy+OgPtPivcgH2Flpc9AJBGXaJn4
xrDxjtybARWh0KinVMY8
=fAEV
-----END PGP SIGNATURE-----

--AbQceqfdZEv+FvjW--
