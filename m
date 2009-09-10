From: Todd Zullinger <tmz@pobox.com>
Subject: Re: obnoxious CLI complaints
Date: Wed, 9 Sep 2009 21:25:32 -0400
Message-ID: <20090910012531.GU4297@inocybe.localdomain>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com>
 <m3fxavvl5k.fsf@localhost.localdomain>
 <ef38762f0909091709t7336d86dkd2f175e5b3a6a3f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="xBksgq8vS1Y/N3cr"
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Brendan Miller <catphive@catphive.net>
X-From: git-owner@vger.kernel.org Thu Sep 10 03:25:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlYPx-0002P2-KI
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 03:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753876AbZIJBZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 21:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753740AbZIJBZg
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 21:25:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53594 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320AbZIJBZf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 21:25:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 40A562C5F1;
	Wed,  9 Sep 2009 21:25:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=zHDuzfU8B4zYH7OQ0F+cD73Ncbw=; b=yNargM+
	78jSVOGjweWa3nK1FFpbttbktbtk7pJYN9tXlixLHx+nCpzWff7kTnUiWoT3OgFf
	fqFyolgj7ZX8TZEJXwDmrMHFyrJVC5Q+Dh5qrTe69aU0+68AwbE+fWdGVJDYsNOP
	61vpCeuR/CmHIHorlW7FWwJtf7cIluUZYzVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=sasl; b=d3KhyeSVr2J27iFD6ClcftP3K4n7jteHj
	+jUZaFp7W12v2+POy6UdDtN6COpx88HM9yKFPWztj9ELaouvQrV5ZO0FNFF4FSvG
	RGz/zgnubWR758xgamVqlg3rZzSuIETBJpuL1nOcedfrFvWdzzixHETCqQG0kViM
	6JZ6m1tHo4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 264D92C5F0;
	Wed,  9 Sep 2009 21:25:35 -0400 (EDT)
Received: from inocybe.localdomain (unknown [98.117.9.179]) (using TLSv1 with
 cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B4FCD2C5EF; Wed,  9 Sep
 2009 21:25:32 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <ef38762f0909091709t7336d86dkd2f175e5b3a6a3f@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Pobox-Relay-ID: D6C91FB0-9DA8-11DE-8ADC-A13518FFA523-09356542!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128094>


--xBksgq8vS1Y/N3cr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Brendan Miller wrote:
> On Wed, Sep 9, 2009 at 2:54 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> Brendan Miller <catphive@catphive.net> writes:
>> First question: which git version do you use?
>
> It sounds like a bunch of things have been fixed in yet to be released
> versions. That's great.

If I am not mistaken, support for cloning an empty repo was available
in 1.6.2, which was released in March.

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Drugs may lead to nowhere, but at least it's the scenic route.


--xBksgq8vS1Y/N3cr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBCAAtBQJKqFWDJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjWkYH/35V9aARZR0wjdmCHzNoyObO0boJpoEQLTRI
JSYjtWqJbShQ4dTQg8AQPuTLHt7SbNYcsRWh5WVu1UGMEpdKZnffqzpHv1x+idTn
VGileoot6EiMUZFS4tB5ut2CfvLHTnBYDz8Gbzr+ho0e3Yr8Xlu0vwYrzhNUgvum
7I00FOGLY+C155uICNivPTny98w05la7bF2fOTo/8JRAwXvCaMjeSLMmLTsSC+Q+
ih8z5w8FfaLN1ybFgTlx9E8mXOAdaVPpQJ91q+IIzy2O+CFBiIjQeLnPhrsR/22M
lXMorX6ODixZ4WeVkvJM2aYn3WBsmjhjDItOoDf8zTHhaSzihh4=
=qLkM
-----END PGP SIGNATURE-----

--xBksgq8vS1Y/N3cr--
