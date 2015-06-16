From: Johannes =?utf-8?B?TMO2dGhiZXJn?= <johannes@kyriasis.com>
Subject: Re: GitHub Pull Request merge commands
Date: Tue, 16 Jun 2015 11:33:45 +0200
Message-ID: <20150616093345.GA28617@leeloo.kyriasis.com>
References: <mloo9l$agl$6@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 16 11:34:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4nFm-0001SB-4L
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 11:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933252AbbFPJdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 05:33:52 -0400
Received: from theos.kyriasis.com ([212.71.254.33]:34550 "EHLO
	theos.kyriasis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932880AbbFPJds (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 05:33:48 -0400
Received: from theos.kyriasis.com (localhost [127.0.0.1]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTP id 0d49954e;
	for <git@vger.kernel.org>;
	Tue, 16 Jun 2015 09:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyriasis.com; h=date:from
	:to:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=theos; bh=VBN+u78bjMbKnHTYVw1NHFS3inM=; b=gCwrU8
	ly+CCPt+Hs0LVNpLKU4A1UMfNUX8VAcmfgz6vQyz2UJ4n9HsnmRM8ingYiOKyyDr
	o8KVHJCTlpPrA+xWeplwMCUE0vJGyU+DqjhI/tSNy8ZtBKOTV7Q76euEASyMNVaX
	kq1BEJOzRxdWMT/tuAFji9s9uN0fc+KoqAgOI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kyriasis.com; h=date:from:to
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=theos; b=FnZKZ9HRJkhPixTXCehPxjg++bOipU2r
	nGlg38yk2yQK6w5iShqekgdJaq6N+hTBJrw3A0pc8uUoTq+g6Lwf53tfVpTszeVR
	qsHVP0FBgxBO5inUZn3cM6XUROmvA5acNZ1ALrlcBJ21CgkJ9ayEOXL3y/88oc3W
	/XsRE8kX+7c=
Received: from leeloo.kyriasis.com (47.67.24.31.in-addr.zone [31.24.67.47]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTPSA id b113e9c0;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	for <git@vger.kernel.org>;
	Tue, 16 Jun 2015 09:33:46 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <mloo9l$agl$6@ger.gmane.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271743>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16/06, Florian Lindner wrote:
>My question is, if davidsblom make further commits to his develop branch
>(after the pull request was issued) aren't these commits also included in
>the pull and therefore in the merge? If yes, isn't the idea to merge just
>the changes that the pull request was about? If not, why? ;-)
>

A pull request is "about" all commits in the branch, which is why=20
topic-branches should be used for PRs.

--=20
Sincerely,
  Johannes L=C3=B6thberg
  PGP Key ID: 0x50FB9B273A9D0BB5
  https://theos.kyriasis.com/~kyrias/

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQQcBAEBCgAGBQJVf+12AAoJEJAcHDIOsNRderYgAJ6EpXKpFqc89iDe5v1zQIh+
VPkkDLn5D9+Iszmav9QI6dMjJCgKFI7mpiPTcApfYoTZUBDGX3CsgwNgbIrVYfSX
ZXJ3Qsp4OJSC0zNAWPNqNz/yqgyWGjh6zBGlrGldP1WPvwZO3U54NPpyXdS64S2y
7hfahxHSroSq07ehJk3pg1+4WnkgyxicfwXI3JpfNLKjd7twjmo1C6/Y/zJ096EG
89glZNxdIUr8u716TMmXRpuHwr0OT9YtFYRVQFYQ67synMOOqGnu29B25UVHVfIw
Nwth7l6XA798Fq1wCGBVzK0noJzwaD+kQyc40Cw+DxFELF5Fh3e0duG/Vzoij2Px
8lHuL+0xPzrg8D5o3R+pgxDBn7Oz7P5vSs46FGsjXrOhUvTx+cWy8xNQNGVzsdWi
7Xz2fDfMSgXDyxhtFXM8vq8cuPH0mgtNMDXlEC9IZzT/LDcNlTT5Mtg07Od9AqRC
wj5uZQn7+NmQqlwB8yKoBIYL4rEBLag8WfI6clJ0aztPj2xkXXNCaFg2KLAwrUA8
Pq9GqfMysdi7NksqzKrLsHQB9IT24Nuh3EFFeWXtGCSENkqTCHbDGs5fnJH4J3rN
d+lLW1hOR3zLJPC1Cla+J1h6Vr/T9zpy2QoiGAxoRO3Zj1PIwcyHhgXumuJGc0lt
YTJ3BxCiUJgGLyl17PDAJoJkPogWzcEv92xqf5C7eJBG/Vyr93ehp50xMujD9YQH
YCtTnKCNq6CJHuWOLW1/kLrDV0S9Df37xWpHRVcNDtFAcg3dmgvBrw7MhgO8HZOz
HokHWj6hPMFqnCY1z7Aj3AQkEtJjg8AO71uMWTssncEzKBznLyodd4rpkUW9bkn/
FZtad48uxvHElfPULWWo9B8aadht+kvFVyQo5SqR7MpquU3pcUnOg6Rk+2rqos+F
UKgsLkyqEadC1Se6dksw6/cTP+sPO0UX5UV2kRK6yhkGuK1Zyc6g+EqFQ975A+hS
n19jDgbvniJUvJtnu4HWFPLNpT4l4zUxZ604tdoCeDhUXgOjH5QMnDxUMOvw2ZFa
9zEoEXmmxYUr8zSqHy5vI273JfxTLQw/fMmKgu76wXiHWghWSBCQ+Xs2zlcVm7sH
5YBo16NCb1XKk+ATv9uWyeu5MjEI44OH6F5AMdyOY+rQ4hKewJJ36Xlbww6Pqvip
QuR6vFStsumtz5tTANQbng3ELgPlFi4uc+GGvzE8gZV8h/hM3sgPwn+pMoFrEwtr
zwEub17NyjpdBXK1SXQddpyol4lQtAt3IJArdm7yS4mV0+b4k5zMWCgZQO3mcE4P
Li4AzNEhaz63TzzOnxVP88lffLzeLGB/5k45IT7MKVc91Zg6NxvkO/XOABND6GM=
=//xY
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
