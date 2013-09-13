From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH/RFC] Developer's Certificate of Origin: default to COPYING
Date: Thu, 12 Sep 2013 18:18:29 -0700
Message-ID: <20130913011829.GH31410@odin.tremily.us>
References: <CA+55aFzNUr8-LQ1JqCBboFktmJRB1ctxP3=huOt5H=GQRLFbow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RwGu8mu1E+uYXPWP"
Cc: Git Mailing List <git@vger.kernel.org>,
	"Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Richard Fontana <fontana@sharpeleven.org>,
	Mike Dolan <mdolan@linuxfoundation.org>,
	"Copenhaver, Karen" <kcopenhaver@choate.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Sep 13 03:25:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKI8l-0001MY-Dj
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 03:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755836Ab3IMBZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 21:25:39 -0400
Received: from qmta07.westchester.pa.mail.comcast.net ([76.96.62.64]:47405
	"EHLO qmta07.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754538Ab3IMBZi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Sep 2013 21:25:38 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Sep 2013 21:25:38 EDT
Received: from omta20.westchester.pa.mail.comcast.net ([76.96.62.71])
	by qmta07.westchester.pa.mail.comcast.net with comcast
	id QBNc1m0021YDfWL57RJYEc; Fri, 13 Sep 2013 01:18:32 +0000
Received: from odin.tremily.us ([50.159.125.102])
	by omta20.westchester.pa.mail.comcast.net with comcast
	id QRJW1m00b2CghKm3gRJWvl; Fri, 13 Sep 2013 01:18:32 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 85DFBB67BF7; Thu, 12 Sep 2013 18:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1379035109; bh=RHXwC5Ktyjo3J3texQ3a89naw1XsU8R0tXLIid1OEI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=PKKLIxNrUBIvy+nPnhbtCmNe0dsIeExId4ikI10xmy34MTXNM9cBNZnJCTso6YORu
	 VNnADTsrJd6VXOO1ymbNyAcyrGnmu+hSBXBCRWNv2boHCfxbvRkh893Un/DBIx3ork
	 Qx7uSO7cel/CqvTsQX09uKMyWckzz/5j7yp50qZ8=
Content-Disposition: inline
In-Reply-To: <CA+55aFzNUr8-LQ1JqCBboFktmJRB1ctxP3=huOt5H=GQRLFbow@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1379035112;
	bh=xc/4xHcFK0jPVWo/nAIeHmW6qQ0KHydbbit7fPxQgjI=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=A+1gpcemUPL9FsqqM1SWjos26Bl+NzAOK263BkzUo5psQTR5av6G4h6BnJETc4EZG
	 bSduJYiiNhSrzhxUVS6ehSDQkwutRSNo7+jqdX+qrGwenDzE6Ulm8A7S6yWjGHW9Dw
	 C/1/Falfc8dFG5CEaYnuyBNhogvAcldvRONN1ViOMPojnIe3/+0pLGWl6qr5RHOpS8
	 Beqgd001vE1F974n/1J/uchM4DTGxTu72mtQ5n/+xTDk06Z6lQFYR/jZE5l/8PmrGW
	 dR+07BUpcfoWXhVQo7biILay1yspQcn/B5M/yzbqYUxaSZfNg/GofSzVfcU+0SGqqO
	 CXmtr9o5FnN/A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234721>


--RwGu8mu1E+uYXPWP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2013 at 04:25:03PM -0700, Linus Torvalds wrote:
> On Thu, Sep 12, 2013 at 4:15 PM, Richard Hansen <rhansen@bbn.com> wrote:
> >
> > Is it worthwhile to poke a lawyer about this as a precaution?  (If so,
> > who?)  Or do we wait for a motivating event?
>=20
> I can poke the lawyer that was originally involved.

For what it's worth, there is an existing push to clarify the
licensing terms for the DCO [1].  Involved parties include Luis
Rodriguez, Richard Fontana, Bradley Kuhn, Mike Dolan, and Karen
Copenhaver.  Hopefully they'll have something to say after the New
Orleans LinuxCon.  The DCO licensing is not quite the same as changing
the DCO text, but they're probably closely related ;).

Cheers,
Trevor

[1]: http://thread.gmane.org/gmane.linux.kernel/1397613/focus=3D1400065

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--RwGu8mu1E+uYXPWP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSMmfiAAoJEKKfehoaNkbtt5EQALNVN01yKTTZ7Oe+IBkzIAMl
vINo3KDRdzW2f69+sCS+Mey+kigSPfkEIJh096qpnXLOu0gxUzdJNSX2TRzEwvA3
dzRRSAxJcCMwXi9qX5mg+G9chExaEPCG/oHZJVtxikMB6E1uN+zpwqyAohFzg5KQ
zv0WzHfqi26ddXIJLTaW4hNzu7PXka0m/5fk60ffpEnxA5uuXg48MLOWH4MSr8TX
D1z1GidRc+PDW+/ETUN2MYIbR+9pDwT5Rj76qs0WNoFGOfos4jUJpcWcBA0YEMAa
JL6yE3Rqph66fI0/vafAVZ8pzYQZ+ym4WM+uFDgLPOICABDD5XylgEFp0Z0tf8jM
wU/zZvIB+mo0uFDgfe26zyM9mcMAHpIpOOuzlXbS+i36U+P8ZfM6n/slnRAAkKWT
KXLlDSsCw7kWgK+VWozIx+oc0B6NjN+jBEwpJlbljWZi19OMU0RLcIVUl6WIpuI/
Ds/ObZ4Vm+/OVEWT97A3UNwMiFdrZw8WQ68tFLzlxPm4K134Ei2KR1VELZnn8r/H
addmcKZ8Dy0FcsR874PjN0cYKPdDtEdD1/wFEb2gXnPh2ZIAULA66JorRMGFl62R
EzEFgjPym8uu0+F1CPGVOzoxHiqNMUVLwmcTeW9r3DKGS4ls47O87SurMimBB11z
PRr5i0R+GGHSI6bEOzgU
=M2nY
-----END PGP SIGNATURE-----

--RwGu8mu1E+uYXPWP--
