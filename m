From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH] Documentation/submodule: Fix submodule.<name> -> .<path>
 typos
Date: Fri, 28 Mar 2014 10:01:30 -0700
Message-ID: <20140328170130.GI25485@odin.tremily.us>
References: <f86f6b48f1c840d50d00c591a296821e0a18ee0d.1395954229.git.wking@tremily.us>
 <5334B0F4.60103@web.de>
 <20140328020648.GB25485@odin.tremily.us>
 <5335A976.6050908@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FK65GREB+Evh/hTL"
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 28 18:01:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTa9y-0002Qq-MC
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 18:01:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbaC1RBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 13:01:34 -0400
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:53077
	"EHLO qmta03.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751340AbaC1RBd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Mar 2014 13:01:33 -0400
Received: from omta05.westchester.pa.mail.comcast.net ([76.96.62.43])
	by qmta03.westchester.pa.mail.comcast.net with comcast
	id j4XJ1n0020vyq2s5351Yql; Fri, 28 Mar 2014 17:01:32 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta05.westchester.pa.mail.comcast.net with comcast
	id j51W1n00R152l3L3R51XJj; Fri, 28 Mar 2014 17:01:32 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 5754310DEBF7; Fri, 28 Mar 2014 10:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1396026090; bh=ww2i2HOCblSwmqOWakX5ASIynPzXfWgIExbln6Ntfbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PDw83p/L1Z5pkO3smTQHhAWjEb5muONisyIcEbvuZpUMkduGcX/c/fxTlrqtLv1cH
	 lDF3UigvmhF0b9kzvpv/MREqftmMTz0sXcdTfHA1PE1u0i/hdVwJzGNARf96YC0ZzZ
	 fH9EpsJR0haO2eWTRPLp7kHOwWdN0j9A+GrgXkNc=
Content-Disposition: inline
In-Reply-To: <5335A976.6050908@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1396026092;
	bh=ww2i2HOCblSwmqOWakX5ASIynPzXfWgIExbln6Ntfbc=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=rBxLF3JPB1tkrBgo4RQPQ91pIUgq0TBlJKPNs6ldjcg8Usq/wakBAz0JAS9mObDlL
	 XoDidZ8SjX/ZD1c+gxLZlLS3vX6SNCt4TPF0YsC3PaFl6Ujov2tt08ijQI4HU33Qme
	 gkNAnTgajRm4u+8cwtEH7YOyyxhSunVj/3uHqHyMW+epVVPUZ99MzGpWNvn/VRJsOx
	 y/35QMNls2s27frvv7c+AQ8a1sCtcvmWwMZTvztas691v7FYxOehg9UDIwToeAdFiv
	 2Uki5zL53zpgvc51NUbxv6WccLwBuBiI5UVnsMksusRr6KzutNl5/y+ndkCCW0Iwap
	 u/nJwBebSbndg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245396>


--FK65GREB+Evh/hTL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2014 at 05:55:18PM +0100, Jens Lehmann wrote:
> I just noticed that the two patches Junio added to pu have a
> reworded commit message I'm perfectly happy with.

The revised wording works for me too.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--FK65GREB+Evh/hTL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNaroAAoJEKKfehoaNkbtkIkQALFdebqPOIEFcCzqdEeOHVL/
llWwE4Th4E9x8Gsv4adLeBKMrXinl2Qe4q+K2ON8DZ8eBItse2ks4Eotco1vlqio
bHV5BWYxUwwNnJ1bMjfSgPShkDHUJFS9pYGgwAXSYT1GWAVSIPDMWNW72BgSuTg1
dYPvxqfvxLIWFuJ4XQa6jaEO9IbL/QxTEvHC/6rxVh//o4zyj93oQjxe67VfgeGc
DMVBHHf8Dejs1NPp/qScD0RsRnkGwPLMK+VJoQtIkYfgHcjt2qipfq7Z5KJw2Vb+
KHWnFMEcFZTOTCCrxTwen5atc6Wngx1srYIXEpjj/XXXaRb/HnfnIr2+JD3bgPR/
ekm9Ntkq5xjXxUOK16Bulu+9FCP6la+KICrBnKe9OWAKSHn8y45pqoG8/nNroEbS
+3kC5lPHMjg1Oyj1Nj0yy2smz560lY3WRlJ6Q4NaQy2gK2ioit1FuLjM9DB0iisH
340Y7WccCuTEAHwu9Idm95qGF1/qqpaTmkvoZ756g5jX3jq4GJ5pakYI/OoEepos
tsYPXYi8g1s/ywVLGng8fzbe+SbwhFtO2yLAgKEaucVWnAE7Y9CTMqainc67oiUd
nkh6jlXxcy34U/VRwMVOl3Seqk88cHWQTyAtkw4xQ5Ol6WMJpoIq/c1oKzX9zRN8
LBfzlN2+XZYQnjepaMKj
=jAIv
-----END PGP SIGNATURE-----

--FK65GREB+Evh/hTL--
