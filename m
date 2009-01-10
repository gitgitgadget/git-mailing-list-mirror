From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: What's cooking in git.git (Jan 2009, #01; Mon, 05)
Date: Sat, 10 Jan 2009 14:08:11 +0100
Message-ID: <20090110130811.GU21154@genesis.frugalware.org>
References: <7vbpulnduj.fsf@gitster.siamese.dyndns.org> <2c6b72b30901092015l2405627aqf928e43c12eabc3c@mail.gmail.com> <7vr63by9cw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="69hkJlzLli1+5obl"
Cc: Jonas Fonseca <jonas.fonseca@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 14:09:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLdau-00006v-2m
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 14:09:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbZAJNIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 08:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbZAJNIP
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 08:08:15 -0500
Received: from virgo.iok.hu ([212.40.97.103]:47802 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853AbZAJNIO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 08:08:14 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 7AB4F580C2;
	Sat, 10 Jan 2009 14:08:13 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id CD80A4465E;
	Sat, 10 Jan 2009 14:08:11 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id F08F411B8630; Sat, 10 Jan 2009 14:08:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vr63by9cw.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105101>


--69hkJlzLli1+5obl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 09, 2009 at 10:15:59PM -0800, Junio C Hamano <gitster@pobox.com=
> wrote:
> >   > git diff | git apply -R -
> >   fatal: can't open patch '-': No such file or directory
>=20
> Thanks.  I think this patch would fix it.

My bad, I did not test with explicit '-'.

Thanks for the fix!

--69hkJlzLli1+5obl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklonbsACgkQe81tAgORUJZt9wCfRNn6JwmtsQTKmAGRqE/Zn7qN
2VAAnjpiWL8stmM83PLIlZlb91WjX1SN
=/qO5
-----END PGP SIGNATURE-----

--69hkJlzLli1+5obl--
