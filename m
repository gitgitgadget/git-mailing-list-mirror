From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the security-testing tree with the
 tree
Date: Thu, 30 Jun 2011 19:30:23 +1000
Message-ID: <20110630193023.6056d48e.sfr@canb.auug.org.au>
References: <20110630142910.2fea4257.sfr@canb.auug.org.au>
	<20110630072559.GA4048@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__30_Jun_2011_19_30_23_+1000_FPHb.q8Ju=toAu/n"
Cc: James Morris <jmorris@namei.org>, linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@vger.kernel.org,
	Linus <torvalds@linux-foundation.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
	<u.kleine-koenig@pengutronix.de>
X-From: linux-next-owner@vger.kernel.org Thu Jun 30 11:30:38 2011
Return-path: <linux-next-owner@vger.kernel.org>
Envelope-to: glkn-linux-next@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-next-owner@vger.kernel.org>)
	id 1QcDa1-0001rK-Bx
	for glkn-linux-next@lo.gmane.org; Thu, 30 Jun 2011 11:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426Ab1F3Jag (ORCPT <rfc822;glkn-linux-next@m.gmane.org>);
	Thu, 30 Jun 2011 05:30:36 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:46207 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753322Ab1F3Jaf (ORCPT <rfc822;linux-next@vger.kernel.org>);
	Thu, 30 Jun 2011 05:30:35 -0400
Received: from canb.auug.org.au (ash.rothwell.emu.id.au [IPv6:2402:b800:7003:7010:223:14ff:fe30:c8e4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtps.tip.net.au (Postfix) with ESMTPSA id B5612144BCA;
	Thu, 30 Jun 2011 19:30:30 +1000 (EST)
In-Reply-To: <20110630072559.GA4048@pengutronix.de>
X-Mailer: Sylpheed 3.1.1 (GTK+ 2.24.4; i486-pc-linux-gnu)
Sender: linux-next-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-next.vger.kernel.org>
X-Mailing-List: linux-next@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176481>

--Signature=_Thu__30_Jun_2011_19_30_23_+1000_FPHb.q8Ju=toAu/n
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Thu, 30 Jun 2011 09:25:59 +0200 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@p=
engutronix.de> wrote:
>
> Long history short: James probably used -s ours or similar and it's fine
> not to merge that commit into next :-)

Ah ha!  Thanks for the explanation.  My mind was clearly not up to it
today. :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__30_Jun_2011_19_30_23_+1000_FPHb.q8Ju=toAu/n
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJODEIvAAoJEDMEi1NhKgbsaZUH/i64CxxpGaK5mgQXAs0w+dy3
zg+QMPOvWlztgiJxPSAHTghGcr1sZaeSUZA1qyWGjrt+FQ4mnAjX1UH7JYXTonav
BaQyXJuVyNQ5Y/EXpIgkRapttS0ExRwBrxPyxC32WCFAD1yqYOlgA15L8yC5RzdY
zIWBnRaF7pfPMQKHE+bSAf7YZTtL5FDTOhnhi5uYP85tPQJo8KTmiic7gAhrBDAC
PLf4ZQbtzXtOmSgpz0CwPWNqG16GBJUYLfwmBCQ8m6gdHIjR1IX+5pXrnWQtyWEy
6qu9mvW6N23QfeDLaafbjNR1gyQsm3WeyXPrKiiMNEyhOsaldkxWQMf7/rbuMJE=
=jEb5
-----END PGP SIGNATURE-----

--Signature=_Thu__30_Jun_2011_19_30_23_+1000_FPHb.q8Ju=toAu/n--
