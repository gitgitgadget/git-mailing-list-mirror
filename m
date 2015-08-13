From: Matthew Thode <mthode@mthode.org>
Subject: Re: config options for automatic signed tags and signed pushes
Date: Thu, 13 Aug 2015 14:16:36 -0500
Message-ID: <55CCED14.3050200@mthode.org>
References: <55CA4799.7@mthode.org>
 <CAD0k6qSAw_aG_kScRgJE+6jVv6z_qc_O81Zq1s29nu=NkKp0oQ@mail.gmail.com>
Reply-To: mthode@mthode.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="DpNOMfa79m9VI5L21RC7SLsbW3TdSsTjp"
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 13 21:19:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPy2G-0002wk-8P
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 21:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbbHMTT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 15:19:26 -0400
Received: from 216-82-208-22.static.grandenetworks.net ([216.82.208.22]:60489
	"EHLO mx1.mthode.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754416AbbHMTTX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 15:19:23 -0400
Received: from [10.0.3.3] (unknown [10.0.3.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.mthode.org (Postfix) with ESMTPSA id 8963E1FF0B
	for <git@vger.kernel.org>; Thu, 13 Aug 2015 15:19:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mthode.org;
	s=default; t=1439493588;
	bh=MQkH4F7qW2uKVTZjkdUSfPl/MknaDdMdOwQL9OtpmEI=;
	h=Reply-To:Subject:References:To:From:Date:In-Reply-To;
	b=NOec7LLnDgpAgr0oglOBaH7XYMHEhGDh2l5OaJeqXIvYCmIjYrueT1AT3QL3NJBQt
	 xStlH5BwTzaMv5CRteeqndMY4uDolP7KVnRInCKIoi8re+70VsjMnNAUOMruMVKuMg
	 /sDrGdrfIWTmgllCEkeG0WC3ANxnIfnq6zL4Pvoo=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <CAD0k6qSAw_aG_kScRgJE+6jVv6z_qc_O81Zq1s29nu=NkKp0oQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275887>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DpNOMfa79m9VI5L21RC7SLsbW3TdSsTjp
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/13/2015 02:01 PM, Dave Borowitz wrote:
> On Tue, Aug 11, 2015 at 3:06 PM, Matthew Thode <mthode@mthode.org> wrot=
e:
>> If it doesn't already exist (not that I can find). I'd like to see
>> config options analogous to commit.gpgsign for both tagging and pushin=
g.
>=20
> I agree this would be useful, and that's why I just implemented it toda=
y :)
>=20
>> Not sure where else to send this request though, let me know if there'=
s
>> a better place.
>>
>> Thanks,
>> --
>> Matthew Thode
>>

Thanks,

While, this is good, perhaps we should add the same option to rebase
(and anything else I can't think of). :D

--=20
Matthew Thode


--DpNOMfa79m9VI5L21RC7SLsbW3TdSsTjp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJVzO0UAAoJEGSje+quGaToM14P/iyYWADOxyhd/AyRR3JZw5wQ
s+A68Z/KqdXr3YCwxYY7a/Sm4dG6Jzp9wTW6BEE/YARmRPDsLu+7jjLSvMKeB4MO
w+9mTXucQ1qbagzcLnwnjvS8xiJiXdgapkip764bfvnOJS3Ni3r9AJmHBYQBws9p
8dT6r9K+qL1J8P372q2A+Ss2VeBrYz/XiVvja/D+Sv7bWSsP1+QgiHUHVEVn1qsw
RquKsTRhWXsKsOYOxVnxJpb3saRI8rlLgt0ptlk1xF7VQtluAV5kHUxwl9uEAFck
Ns+6aiNBjVEdIa4naro1NTPg0yzm7q6cJVaFczw2phRwpKOy8rY9wU9jQqFQY9AG
c2qTHUH7T5F83T3mxhWfFYOPPQtv2zSh/uDqVkz3aN6KObHz7bl7iNQXViYr4jit
caEjfvH+acpb64ZxXt12Pl0CvKn/+ams24QeR8ZNViJa5Az0ZJor8e9imPsopGwR
ExFtkd2HFqRtDKc5entl281llOP0txD22iFIPDR4AzevbpiqebhSM6VUKySVZGsm
ILy7hYDb4vIQq30BD+EbhpmXkBt9YX2tl9NvnRaMnlZiTgRvq+fc9BkRbz0/5uOl
mlQ8AhKJJCuDqga56DnOkxvftrogTmQMaWRK6PtyWpF84p6lnhRxPyRKVLWwtWMm
kaZgoN7gnniEXJ2hufkt
=2Tq/
-----END PGP SIGNATURE-----

--DpNOMfa79m9VI5L21RC7SLsbW3TdSsTjp--
