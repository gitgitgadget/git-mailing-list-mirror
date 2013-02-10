From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v2 07/15] user-manual: Mention 'git remote add' for remote
 branch config
Date: Sun, 10 Feb 2013 17:22:54 -0500
Message-ID: <20130210222254.GB8377@odin.tremily.us>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
 <1e3996dff5c19010aca1458b202b14cbb54b5d80.1360508415.git.wking@tremily.us>
 <7vmwvbstw1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 00:23:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4gFQ-0008DR-ID
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 00:23:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755330Ab3BJXXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 18:23:24 -0500
Received: from vms173003pub.verizon.net ([206.46.173.3]:37588 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536Ab3BJXXY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 18:23:24 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI000LG2ZI7T840@vms173003.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 10 Feb 2013 16:23:00 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id CDE23879AF6; Sun,
 10 Feb 2013 17:22:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360534974; bh=JpQ5H1vr4Au2nYz9UTY24XwxHs0BIsA79336JPxg+tA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TaA0P5s/CZFvS4Udsm3mUNi2CA4H7ta/+P0FEdyIzrE/GnQ2oldg4X8pRSHSSUUMt
 mbqzjh+vFbzAZgAnO/r8ZDKvt4ksxj2oVbbtnjIho74bl60egFZTHpfCL3XSr6kWkc
 pWwIlkmj57qf04hCT6xyA4k6XkstCdIU4EI35pm8=
Content-disposition: inline
In-reply-to: <7vmwvbstw1.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215970>


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 10, 2013 at 02:09:50PM -0800, Junio C Hamano wrote:
> I'd suggest rewriting everything after "If there are other
> repositories that you also use frequently,..." of this section.
>=20
> Replace the first example after "for example, after" that uses
> "config remote.example.url" with the new text in your patch,
> [snip additional advice]

Will do in v3.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRGB29AAoJEEUbTsx0l5OMnxsP/jMxVCKy+1JAHq6NCCetu/Wh
h8AcIMf1B2FUM2sXPqDHuSm1PVYRYZyJbRsSb7/evT90chnftCpa0xcEpkSewsJj
obJ2whIE7UtR2RZLZNdvv2nGEbnY4ayf1iIrEZTMVSma5/FQ2YOxkFAXZVXBgfI+
UC9jJkcJJIGJHxYNZhiaZXxZbsUU3ypWPBneSo5DchMwN5kyBfjBmcNlVZ9ESZHK
rXNpcgtd2Yr/QHkE1TmZMn1nOYnNIDdJaKodoyn55OtOa/J+ht2mHfcd26QBnfxC
vgg3Fc24t2bSOKr1nP87L9icrB6R4jWF+NYdgqgPcmHT7iSOAaZNJS9R73qd4AWA
1XpN15PttiHSvb2oFrfaCgH22NefUi9JFcwkbStHtshjzh8FhBCyHXefmPcNy6tq
1Glhj+Hd8YkVxPKJoXJq2EvhEplGwffP3xInchNF1wsgkSK7IUjkmOPtSVziRYaw
0mz3trYej6UCK8+D5pf0Hs5gMgmskeY6dwViV3ZrR9R5cxFIYeHeUHobFB2HaeaU
Bl7jTLjxjxxEyQCJ2mDk3XhO2Z2wlAKdBDlKMeIOiMaQ02BBs9CcvMRBJ1r3yxh4
shfeFUDYhBaTkD9yuBpC7aRczJJYlkZj4HFB7tg7ccJjOLVr2VELrREsdcZfIMn2
tseTm6q3SPen3dXHRKnI
=syTJ
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
