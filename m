From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: What's cooking in git.git (Nov 2015, #04; Tue, 24)
Date: Sat, 28 Nov 2015 15:40:10 +0000
Message-ID: <20151128154010.GA15706@vauxhall.crustytoothpaste.net>
References: <20151125010722.GA23632@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 28 16:40:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a2hcM-0005w8-1M
	for gcvg-git-2@plane.gmane.org; Sat, 28 Nov 2015 16:40:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbbK1PkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2015 10:40:22 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47178 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751947AbbK1PkU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Nov 2015 10:40:20 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 646B0282C3;
	Sat, 28 Nov 2015 15:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1448725217;
	bh=sKQqRZaQvrF9PPrPSEUdFphvJOAfvq2511e/dT77Z7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m5RdAzyYb322gqQ1UAdgt8NTjSvI6SLlfNupSAHqLago56f9+I2ZphCaQBbROSMe7
	 6J+IE0attppFcJ6a2AYHMlR6A6kjlDQDjSWw+X1FIvh7kNeaUl1UrsoVYoXW6PV2Kb
	 DkjDwgLUiGnYMSi6nd7EbMRN7DZctNzTNGAuB4UYR8+ZYjmMAWqJT34/zXT7ad+trU
	 cr7IFTev5bkUwFsTLvL85nw5BA34Z7A8KBi/M9VUNymbUVn0qa3w3sWok/MwFgC+dT
	 Gg1wnfwotgsAET/paTfGzTvYXIsAOE4FylxdnfXylp5ZV3/SpmWE3/qzP7ABj9rk0a
	 umItIrNm1w8AfFc+drU83Djn4hqGS2BCsFJz0IF3/D69ouwLZ7teLooQNKDffl7Id0
	 o5j7PkrkCrWZXcQCZLIldqBaFh8t+HrL1iZ7CBCC50oeVJiTeMwKS0AMTIbs+ub8ws
	 keV7Ha6eFvBV/gM/WoNHN9DTMKsUhQhmTnXfytI5qBbtOAt3Fx4
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20151125010722.GA23632@sigill.intra.peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.2.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281786>


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2015 at 08:07:23PM -0500, Jeff King wrote:
> What's cooking in git.git (Nov 2015, #04; Tue, 24)
> --------------------------------------------------
> [New Topics]

I noticed the object_id series was missing from this list.  Was there
something that needed fixing or a reroll?
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.9 (GNU/Linux)

iQIcBAEBCgAGBQJWWcraAAoJEL9TXYEfUvaLcZIQAIT48ebg/J2ITsCkr+xQ4w+C
Mej/O+i2InfwrgesF2Da9I+aY82UHXXHtVs/XjegtHF7vYlmEomJfuYv74VQUebu
XiRqTVpK5eK78tNaDCMeoZmJL1FSGbQWh2CQhm5a+IYFaintUFuAu8gQNSoCu7n9
ZL30oUeF/N+ZGkeo1FlKS3+GKy6UcQt6yldASlNnhO/scYyd7BxuvW92Y7katzxj
s+RebrjkcwIp0lpMkENmi+lY8Mjzk2F2zt2YxTJwhrRWqyMS4g3jytp00qa2FR+E
mWJjHR7axK2h3nArNcVq5vygFcLSnY3P3BOUF5cb8hMTCSjvY76v/ujJsxMzZWhF
Re1cZ5X4kf5b5osOcr/SlH6hdt11u7HPHxd/TVVJ62eQ12GyGiHxo64V7Trt4wH4
VTfN9h0LzSSI7XF+huMOtErT+NhWtdA3qJdSRdgNBffUmiVOoVPrSKY+tAR+YKch
IWAYVx1Cy7J1YjCoQcyTV6RddpnyOK3MV0Nf8/teym1lb/LJjISmd1+xgUSbY6pf
2uJdJWYkNgY6uDlzG16WPP2oNvIiR9bFF3mWrO5WpL6iUBBhfmTy8IPQEVuTeWRx
tZCphYdBmzpwjOKItwAc1kKZelLq2UEdjc1icLdncAVkQBUCr1CX0dwPZAxGWm7I
zCy1uOWNtWdSK6By9pN7
=fXeq
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
