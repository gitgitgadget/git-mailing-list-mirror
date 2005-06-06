From: "McMullan, Jason" <jason.mcmullan@timesys.com>
Subject: Re: Database consistency after a successful pull
Date: Mon, 06 Jun 2005 14:30:56 -0400
Message-ID: <1118082657.8970.42.camel@jmcmullan.timesys>
References: <Pine.LNX.4.21.0506061000531.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
	boundary="=-T/CAf6lhT7tLaGzfRmg1";
	micalg=pgp-sha1;
	protocol="application/pgp-signature"
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"GIT Mailling list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 06 20:29:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfMJv-0006pP-29
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 20:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVFFSbG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 14:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVFFSbG
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 14:31:06 -0400
Received: from mail.timesys.com ([65.117.135.102]:56167 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261554AbVFFSa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2005 14:30:58 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Received: from jmcmullan by owa.timesys.com; 06 Jun 2005 14:30:57 -0400
In-Reply-To: <Pine.LNX.4.21.0506061000531.30848-100000@iabervon.org>
X-Mailer: Evolution 2.0.4-3mdk 
Content-Class: urn:content-classes:message
X-Mailer: Evolution 2.0.4-3mdk 
Date: Mon, 6 Jun 2005 14:23:57 -0400
Message-ID: <1118082657.8970.42.camel@jmcmullan.timesys>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Database consistency after a successful pull
thread-index: AcVqxOcQC16pUCzJTSSTOFK2LyjcSQ==
To: "Daniel Barkalow" <barkalow@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-T/CAf6lhT7tLaGzfRmg1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-06-06 at 12:21 -0400, Daniel Barkalow wrote:
> [snip snip]
>
> My bias is to call a database consistent with only deltas having the
> referents; the rest goes towards completeness, since you have and can rea=
d
> everything that you have anything for (but may not be able to do some
> particular operation).

Now, if we had consistent URIs for the .git/branches/* files, we could
do 'lazy-pull' and really have our cake and eat it too.

--=20
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation


--=-T/CAf6lhT7tLaGzfRmg1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCpJZg8/0vJ5szK6kRAsQ4AJwOKdbXXiOW32ASrcBPr+sSR++xFgCdHpAr
eauZJlnbS6hJSIwvnBTFlqI=
=/tSn
-----END PGP SIGNATURE-----

--=-T/CAf6lhT7tLaGzfRmg1--
