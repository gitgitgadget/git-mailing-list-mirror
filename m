From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Feature idea : notes to track status of a commit,
 which remotes it is shared to
Date: Tue, 19 Feb 2013 05:34:53 -0500
Message-ID: <20130219103453.GB4565@odin.tremily.us>
References: <20130219103042.GA4565@odin.tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=LyciRD1jyfeSSjG0
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>,
	Mildred Ki'Lya <mildred-ml@mildred.fr>
X-From: git-owner@vger.kernel.org Tue Feb 19 11:35:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7kXk-0005bR-H5
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 11:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681Ab3BSKe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 05:34:58 -0500
Received: from vms173013pub.verizon.net ([206.46.173.13]:60620 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932515Ab3BSKe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 05:34:56 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIG00JYZQQ5M620@vms173013.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 19 Feb 2013 04:34:54 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 8A6C08ABB69; Tue,
 19 Feb 2013 05:34:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361270093; bh=2pV3gnAvcUidNrrxYTm5whvEHQc8o21sCC9g135fbBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=cxtp/CDYjxKp67oy56QgsQfXb6gCN2NrTL9wYVW6Yym5pyannPG0mYWKGGlkv+loj
 ilyo5zkXbXzYjmjY7c1kjfBoHC0PqHQICupZKNEQ3zdh/5zTZXQLUmxqN1Kzj0+PL8
 v540A14voDeeC3QoOqEWlElJNhcqqg6AfazMJgfU=
Content-disposition: inline
In-reply-to: <20130219103042.GA4565@odin.tremily.us>
 <87bobgtxvk.fsf@pctrast.inf.ethz.ch>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216598>


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2013 at 11:13:19AM +0100, Thomas Rast wrote:
> It's much easier, if a bit slower, to just run
>=20
>   git branch -r --contains $commit

Ah, this would be better than looping in your hook ;).

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRI1VMAAoJEEUbTsx0l5OMuykP/R7bSf3llV1vyI87HMrf/jf/
zG0FoO9JeDlnKEG1HDbVxPVy/etaLOMdlSnlocXT/rNPqjTvo4wtZPHJ6UpVEA3b
d4+kP9jlfwER/093wVOpLznKpIDYx3iAk3Tqr9EXnPWnzt2PY1nOf1D72X9/i3tC
Q7wa7I7zMdhHxWD0sa44paS1xtYEtdxQ1r5zMKoCxaWbxV7PwNbGrcpoeOA1NTLB
e24YBMiiq1idjS3U3uEnfeE8c0gD8UajowOYSrYz3E4381jDJQty7wIck61RCb2p
/JL1PaVqgx8EVE+QZPx20uQlwxylBIBFNaidCwBY0ONy59/D4sbx2bpNFTE+RfhN
afGdGyN11P1Uoo3Uw3OWs/sYhy+qddcLEAnecCmhE18GlQRObvUITZcBynSLh4x6
Ejq+98MZGb01TOv0ZeYwzJrVv6zgYz/EJRzvmA7ssqmEkB+ZQMw9yeqDDr6NMuso
Knk3OjExbBOnaeyfDUQgGKlmMI+31Lx+kCc2h1n5lY12EBBRKN89kK4sMGuMtX0Z
+Yfo1uIS67ckCIkt35Q8+CV+Jv9aQDC3Vf+pQXJ++FjtdytS8213u1mCWrkyHtQ0
I4rsFlQS2EqPMvL39XpGSbDe3RWkMLkoJcLp4GmesA83BBrIpxb4PVPXBoxOvnpE
OoGWgYXuSdET2HUeHQ0D
=XCPj
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
