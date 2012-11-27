From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v4 0/4] git-submodule add: Add --local-branch option
Date: Tue, 27 Nov 2012 14:04:00 -0500
Message-ID: <20121127190400.GA15213@odin.tremily.us>
References: <20121123175402.GH2806@odin.tremily.us>
 <cover.1353962698.git.wking@tremily.us> <20121127183125.GA4185@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=AhhlLboLdkugWU4S
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Nov 27 20:04:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdQSM-0003a2-J3
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 20:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754085Ab2K0TEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 14:04:15 -0500
Received: from vms173009pub.verizon.net ([206.46.173.9]:41714 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968Ab2K0TEO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 14:04:14 -0500
Received: from odin.tremily.us ([unknown] [72.76.144.216])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0ME500EKXUAOZJ20@vms173009.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 27 Nov 2012 13:04:04 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id BF8D96E0BF4; Tue,
 27 Nov 2012 14:04:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1354043040; bh=6vrKYw3UEQGz0WwRwdVuMv48FMHLA4bJ1F9HU7KSBtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oZFQbjif5JgrfsNtyTtdpd9jqBB1pwCIf6vVHx3B5wCiH6hFJ/6JIfaBOcLbkimMU
 zuIv1yo4R2SZMTWJnW6sce624/jz1koy5Xaa80++BQpKDaZ/pIXjKZr87eZTizIzFP
 /OAvKH8OlEineuCMhhC6XuQWsBiSPx3l1+ZIm2vY=
Content-disposition: inline
In-reply-to: <20121127183125.GA4185@book.hvoigt.net>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210585>


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2012 at 07:31:25PM +0100, Heiko Voigt wrote:
> I would prefer if we could squash all these commits together into
> one since it seems to me one logical step, using the new variable
> for update belongs together with its configuration on
> initialization.

Works for me.  I could also try to rework the patch boundaries if a
monolithic patch is not acceptable.  I agree that the current
documentation assignments are fairly arbitrary.  If I don't hear from
anyone in favor of keeping them separate, v5 will be monolithic.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQtQ6fAAoJEEUbTsx0l5OMUK4P/01LtPvZP04DpIgnzLrMQsbu
x746Yip/CSOVj3iaS3qtK5JLO6lhqHaFj//NOAgWwzHBdOFSEzpgeV26L/WpdnWv
MinODhK9L4B81SeCHiwsw7W6kuDSLrIx3MZ640CXMcmCSCDUQSjaG6dp8jJRrU+o
0rBdp5HN1AUz3QXJpkhHrv3hRS4m3aUSPb0wpcY1XW6xlr7iKGToPmmUHHJ5fD3d
Xqjis7i/KPIUDBGWzuTIYgUymO4mUOqfZAZRPmEyAx7tJyM0yI84fsj6V/JZzA3L
6nyKn0pAOJQiAOdZDx9E3jmpCAgsLrjal5qanZiLJ3ct/mCzqUMjCOEGOSnpW42f
j1izg5MWk6uLRAgLFB89MDGJDrQi5WBH5mTjQ+4+dTkdk0CohoKLffx5WWNAbbEZ
hrcBpySMdQ8edTu47Cur1I6807jAZkOXBXL13qBc/qegtQmnXt/lHkdcDyNnYRWM
LKib8GRiDukhl/nib3IAL9g2RX9++aRcTqAOMKYDhOvWVOnFIBKWYkKWgCrzhOYN
UEnUFXbstoEHRFhlENQDVZWismQMJnrY4J+ujRvcUjs+dDKbxUUNqxnw5GnjszCv
i61YcWfotfx0E4Z1OoTdVH8QGRl21wXBOznaLgZjfK2UDBltcgpri5xdWMBF64Vf
dT1zl22VapD0HffjLVjC
=Zy5H
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
