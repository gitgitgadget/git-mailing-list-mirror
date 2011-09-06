From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Tracking database changes.
Date: Wed, 07 Sep 2011 00:18:09 +0200
Message-ID: <1315347508.6080.4.camel@centaur.lab.cmartin.tk>
References: <CAFSYZ5RjJYHByTMPu6LiM6awGitt3WqnVrLU34mA9t7O1MVHDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-cxUD4aKVjhORAhM32BgE"
Cc: git@vger.kernel.org
To: Rodrigo =?ISO-8859-1?Q?Cort=E9s?= <rcortes.ing@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 07 00:19:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R13yz-0002eE-H2
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 00:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910Ab1IFWS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 18:18:59 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:36527 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750958Ab1IFWS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 18:18:58 -0400
Received: from [192.168.0.2] (e179033233.adsl.alicedsl.de [85.179.33.233])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 6F77A46170;
	Wed,  7 Sep 2011 00:18:02 +0200 (CEST)
In-Reply-To: <CAFSYZ5RjJYHByTMPu6LiM6awGitt3WqnVrLU34mA9t7O1MVHDQ@mail.gmail.com>
X-Mailer: Evolution 3.0.3- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180843>


--=-cxUD4aKVjhORAhM32BgE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2011-09-06 at 18:55 -0300, Rodrigo Cort=C3=A9s wrote:
> Is there a way to use git to track database changes?

That question is too generic to receive a useful answer. You could do a
nightly dump of the database contents and commit that file. Whether that
will give you anything useful is a different matter.

Cheers,
   cmn


--=-cxUD4aKVjhORAhM32BgE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOZpwhAAoJEHKRP1jG7ZzTz6sIAKWaU5kLh1YcPiOjI4OU7Ee2
bZ4mIdbu0SE4Dtxkm+Q6TJabNlFiFGsDHcndiu5b0R9R1KOSsg5aFITZJZe5BIjG
0PqLbZy5sSSdE3PZFVULqKq2WsT4xAuA8u7mrt3gZ0dKwwJIfEj6jkC6fJg6YDuZ
7OD87PrR9m9CxrbCV65HPAOv6VVbTDho8ChR1pz0+iXyvr89FrlkYZXX4JxFCBmt
w6F/o3MIa5OUMB3OKXk7+FGqyDWYSHvnnEGEb2DrMl4K65YWCASjqe1tmRCDoeas
PBjz4fNcHwzvIJfwPZ5vPHoDwxv31OtTCfIwZOk7AedZOhnpVRv+yFAnx5zivJQ=
=98zx
-----END PGP SIGNATURE-----

--=-cxUD4aKVjhORAhM32BgE--
