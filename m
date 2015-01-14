From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] bash completion: allow git stash store options completion
Date: Wed, 14 Jan 2015 19:03:46 +0000
Message-ID: <20150114190345.GC32115@vauxhall.crustytoothpaste.net>
References: <1421171612-12058-1-git-send-email-kuleshovmail@gmail.com>
 <xmqq7fwqed7b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sHrvAb52M6C8blB9"
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 20:04:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBTEV-00062P-LZ
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 20:04:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108AbbANTDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 14:03:54 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:57238 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754099AbbANTDx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jan 2015 14:03:53 -0500
Received: from vauxhall.crustytoothpaste.net (63-253-185-227.ip.mcleodusa.net [63.253.185.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 938DE2808F;
	Wed, 14 Jan 2015 19:03:52 +0000 (UTC)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Alexander Kuleshov <kuleshovmail@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqq7fwqed7b.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.18.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: 0.163 () BAYES_00,RDNS_DYNAMIC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262413>


--sHrvAb52M6C8blB9
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2015 at 10:40:40AM -0800, Junio C Hamano wrote:
>Alexander Kuleshov <kuleshovmail@gmail.com> writes:
>
>> This patch adds bash completion for git stash 'store' subcommand
>> which apperead at bd514cad (stash: introduce 'git stash store', 18 Jun 2=
013)
>>
>> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
>> ---
>
>Hmph.  The "create" and "store" subcommands are not end-user facing;
>they are meant to be used in scripts.  I am not sure if we want to
>complete them in the first place.  I know "create" already is in the
>list of completion candidates, but I wonder if adding "store" is
>making things worse.

For what it's worth, I'll often sketch out a script at the command line=20
before putting it in a file (either because I realize I'll need to do=20
the same thing again or I want to share it with others), so I think this=20
might be a useful addition.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--sHrvAb52M6C8blB9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUtr2RAAoJEL9TXYEfUvaLD2gP/0j+iomiUqFUdUNPUvqQwfFK
9ZJtz8fflx1pDBz0dTQap2ezKOCVX6bJDU7UQdnaX5oas3zg2PRkKb7nMadJAHtP
ZBGBeWZ6k29G/w8i9tYXhxTHs57SDXS69n8wRodN/j9iMFBAf3q3oIrBF4Bm/m/V
lgR78Mn8ljS2d256m6FQVhDL6DKP/mfUkoP+6h6kE+OuOgxYXmWKGhoNMwoEPYcL
iQ5XvTeoaQC8Yi5aLZaP2juifMVYcyptJRA0uSXXGOGyvSFTBHktVg1AuJrbfBG3
AxkIrz45T1NilDnhXJqoEMi6zn0TUuS2YkQJp38R6nFSHKvLfb7jq0YXWK2bYnuQ
VibaH8gaSrqBkWQuP3GJBCyMz60I3yHVDkQA/KHtYYWvzltxUai34uB8Ee7BfXsL
z8GH7wNJui1OLZGhba0TpH/D6LrC0mfkRKh1rXcGiQHYPrQAezIV1oK0+Hef69G/
uaIrPgCfXoSQzSTr722Mbn++ONt80EAcknUlRW/cucCXS6KgFvbz4zcrIgwfrbBs
h1hq1m3Paxs21nB9wRKYiJPdr7AYoZqGyr9PXSg1fqVxze1CPcp1398s3+39clrs
6InrsvQdsiFMuMnel425JK6zCrSo9g0TUbUeyqRbHkGBV+QkWEy4DoPMO6KClsc2
nytwdCy/sUFupmfqf/ol
=DdiN
-----END PGP SIGNATURE-----

--sHrvAb52M6C8blB9--
