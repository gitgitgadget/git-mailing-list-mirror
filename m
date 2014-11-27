From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: What's cooking in git.git (Nov 2014, #04; Wed, 26)
Date: Thu, 27 Nov 2014 18:39:01 +0000
Message-ID: <20141127183901.GD4744@vauxhall.crustytoothpaste.net>
References: <xmqqoarto8xy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C+ts3FVlLX8+P6JN"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 27 19:39:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xu3yD-0004cK-OB
	for gcvg-git-2@plane.gmane.org; Thu, 27 Nov 2014 19:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbaK0SjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2014 13:39:09 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:54833 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750895AbaK0SjI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Nov 2014 13:39:08 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9D7792808F;
	Thu, 27 Nov 2014 18:39:04 +0000 (UTC)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqqoarto8xy.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17-1-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260351>


--C+ts3FVlLX8+P6JN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2014 at 03:09:45PM -0800, Junio C Hamano wrote:
> * nd/untracked-cache (2014-10-27) 19 commits
>  - t7063: tests for untracked cache
>  - update-index: test the system before enabling untracked cache
>  - update-index: manually enable or disable untracked cache
>  - status: enable untracked cache
>  - untracked cache: mark index dirty if untracked cache is updated
>  - untracked cache: print stats with $GIT_TRACE_UNTRACKED_STATS
>  - untracked cache: avoid racy timestamps
>  - read-cache.c: split racy stat test to a separate function
>  - untracked cache: invalidate at index addition or removal
>  - untracked cache: load from UNTR index extension
>  - untracked cache: save to an index extension
>  - untracked cache: don't open non-existent .gitignore
>  - untracked cache: mark what dirs should be recursed/saved
>  - untracked cache: record/validate dir mtime and reuse cached output
>  - untracked cache: make a wrapper around {open,read,close}dir()
>  - untracked cache: invalidate dirs recursively if .gitignore changes
>  - untracked cache: initial untracked cache validation
>  - untracked cache: record .gitignore information and dir hierarchy
>  - dir.c: optionally compute sha-1 of a .gitignore file

You didn't comment on the status of this branch, and I'm interested.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--C+ts3FVlLX8+P6JN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUd2/FAAoJEL9TXYEfUvaLk0cQAIPy7QBOTQwjx2wB139CVhEf
ncXeg0oPP7YmxQTzCHBm+c0BqJuHuGLFd69bky8uAoKjb7DxQmF2Stlwb+YRPbog
qOV6Zonr+QpTpOB96kWjcj7+eCWguHzo9XWI+aQekCEBDIPyKnEW6Iky27et6ASV
KeBeXLKstqcr+KBkhfiL0cNSsX0STIzf3ij1RcTqFNe5E/zrHamC31rzQ+j9T6/I
b3EYWJmKJBMfr/WDKeWqxDCxXKLjGL9tgooiKvgM/vmcWcKWixn1lt6GTw0M0ZyF
8Oa4cW82zzr3L2PM4BdEklVjudd51MV8q1XkzMIypvOq6fi3Wz2LGnJLYY4Mv2l+
IPNz/D243XCh6n4MgodK/mPsAIqz/6jcSevCMaa1K2XFQ0REpCx3Mc/0WxVeMgUr
a6Yq9+ZY/7VD9d2EITyqIclmCKaIITaMFBl+yU8UCbgH/LAwuQNbFbrQCdlFyQXh
aCjk8iIL6oU+FuLCWia7rLMhkCaG/unb5eedlGhtCcFoKpedvQxHd0hzKOmJZFct
jYC8IFf7CJTUnoT4Vw2gwRL/aQ+JNE1FzPuQV6fIz6P5fl26WwzVlWJgMXIrJIXR
dCM+kSPVOElVBCz7eRxtR6TxkodJynsMK2zsYlfvAHcNhzypG7qaJCyKFgAjZF0q
jZsorEhA/wqLEuH/v9++
=ec/w
-----END PGP SIGNATURE-----

--C+ts3FVlLX8+P6JN--
