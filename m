From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: mercurial to git
Date: Sat, 17 Mar 2007 12:37:26 +0100
Message-ID: <45FBD2F6.30701@fs.ei.tum.de>
References: <20070306210629.GA42331@peter.daprodeges.fqdn.th-h.de> <20070306215459.GI18370@thunk.org> <20070306230802.GA17226@filer.fsl.cs.sunysb.edu> <20070307001105.GJ18370@thunk.org> <20070314111257.GA4526@peter.daprodeges.fqdn.th-h.de> <20070314132951.GE12710@thunk.org> <20070315094434.GA4425@peter.daprodeges.fqdn.th-h.de> <20070315210406.GA8568@thunk.org> <20070315220705.GD31087@peter.daprodeges.fqdn.th-h.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5604D5929DC00C3132E6A0BD"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 12:37:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSXEK-0002oQ-60
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 12:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbXCQLhd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 07:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752274AbXCQLhd
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 07:37:33 -0400
Received: from stella.fs.ei.tum.de ([129.187.54.7]:36607 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374AbXCQLhc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 07:37:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 1307928365
	for <git@vger.kernel.org>; Sat, 17 Mar 2007 12:37:30 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Q-DvoBrLEF1V for <git@vger.kernel.org>;
	Sat, 17 Mar 2007 12:37:29 +0100 (CET)
Received: from [62.216.207.131] (ppp-62-216-207-131.dynamic.mnet-online.de [62.216.207.131])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 93BA5282AF
	for <git@vger.kernel.org>; Sat, 17 Mar 2007 12:37:29 +0100 (CET)
User-Agent: Mail/News 1.5.0.4 (X11/20060619)
In-Reply-To: <20070315220705.GD31087@peter.daprodeges.fqdn.th-h.de>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42431>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5604D5929DC00C3132E6A0BD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Rocco Rutte wrote:
> With 'hg-fast-import' I meant something like git-fast-import where=20
> clients can feed in more raw data instead of preparing each commit on=20
> its own and comitting it.

I wrote something like that for fromcvs: <http://ww2.fs.ei.tum.de/~coreco=
de/hg/fromcvs?f=3D7992019d6861;file=3Dtohg.py>

it still communicates blobs via files, because that's what hg wants to se=
e.  performance is quite okay.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig5604D5929DC00C3132E6A0BD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF+9L5r5S+dk6z85oRAgdiAKCWJg0hP32eLvBHCoDdma31pIKDHQCfR7qs
h9dilP1xTl4P2e4zgGM5okA=
=oqmN
-----END PGP SIGNATURE-----

--------------enig5604D5929DC00C3132E6A0BD--
