From: Johannes =?utf-8?B?TMO2dGhiZXJn?= <johannes@kyriasis.com>
Subject: Re: [PATCH v3] receive-pack: Create a HEAD ref for ref namespace
Date: Fri, 5 Jun 2015 19:08:06 +0200
Message-ID: <20150605170806.GA28379@leeloo.kyriasis.com>
References: <1433193883-11577-1-git-send-email-johannes@kyriasis.com>
 <1433523731-25172-1-git-send-email-johannes@kyriasis.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 19:08:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0v6K-00080p-Q4
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 19:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932750AbbFERIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 13:08:09 -0400
Received: from theos.kyriasis.com ([212.71.254.33]:53006 "EHLO
	theos.kyriasis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932123AbbFERIH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 13:08:07 -0400
Received: from theos.kyriasis.com (localhost [127.0.0.1]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTP id a25e0158;
	for <git@vger.kernel.org>;
	Fri, 5 Jun 2015 17:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyriasis.com; h=date:from
	:to:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=theos; bh=t5rNhmb+XeL9UaROsG2auPgM6V0=; b=DRgDxC
	z0TS7kkowNRdDjQd4GQk1Bcf5mkhfircshng/6agW0u0BJMcXSdBR2TSDbtZarz6
	7YpUJoW041dYel1QsfnoiThowTN3ZueChenH+0KUrjTdZ09OB2flM9fJFIeg7WKq
	/BCYQmMN/CQzicIW9qDQJqXEsqw49gE+sd0so=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kyriasis.com; h=date:from:to
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=theos; b=R5nUKICEdlbbtvFQNyvoNkBiACkTTgcU
	xi5XMZ274WmRFBf3S5Im8diSSJnoKWD51mupTaCb5FXIOAPEMIYsM9s4L0QQgygq
	IlrzvBToUvs9x4HF1gjNm8OWN9sf4c8hH4MbWKGzqbjQxfqxv4bMdWK0Z/CyIu5D
	XLge/g3oZOM=
Received: from leeloo.kyriasis.com (m77-218-250-201.cust.tele2.se [77.218.250.201]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTPSA id b8bc624e;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	for <git@vger.kernel.org>;
	Fri, 5 Jun 2015 17:08:06 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1433523731-25172-1-git-send-email-johannes@kyriasis.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270860>


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I should also look into why the other tests in t5509 fail later.

--=20
Sincerely,
  Johannes L=C3=B6thberg
  PGP Key ID: 0x50FB9B273A9D0BB5
  https://theos.kyriasis.com/~kyrias/

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQQcBAEBCgAGBQJVcddzAAoJEJAcHDIOsNRdjw8f/RC68kIlet3UhBFHQ8C6YuQP
QX5akywLoQBpbjO+38yGhhQIJhNqC8EP8msV1AaKov062nfVLWHAO53cWm4qxJrE
wAc3qithx1kFxV9MmgrTY3W3sXMLkpQs4XtEZ2JAQz0vs3FjS6JFmtmzVZND1dcD
BBvose+MEk0YZDIvegsuA+y+nl72WCo4SucWIONQKokGJP6yta3OMofVQpnqtV6m
/y8Wfqcp0icBFoVHnR0VDQMVl7nEgOwFk617c7RzNuLN48NJZPgwArcbpbAXi+Xu
ffkASwxMrUp3j+mZ3l7OhtufliBR9MHQiEYOEFyM7NDVKhM4t5HdlsSJdKOQZWox
t01uTf31fM8WBYcBN6/1Q7DwY2lgKjg8VvLKyCT7el5mGqNBF0pON2/A2kqOme1e
qdN5spMkSMYKJlP4eDHGwiWSDk0PsT8yjaZlYwe7xLrzZg+FwhJ+nQqP06j34Q6q
1qKv58QFhUJCOJlBiKdsCSH7O+AlsqPqbx3IEBpbVaPmXMWFGAliyqLNAXU+/+WX
EewiJYHUzYVepTHXybuhkHAnyQUz39CkgyrXgDXS09fvT3DgWzRUvid/zQhz5hWJ
QQG/eqXQPM7wPCh5yrsm0Ms1T3j+eVh0mzbYHJ3EWdUsE/7ymOA2zAbGDk2VSeys
BghS7OXGDtmfAiVV0zNub2kHxVJPUb+6NIvwl5X6KcG22cqgA0cx+r7IyBcX8zj3
VNlE9dkI3QCcola3rTtgC0MI8XuRSg+R60iSnCcfS2dk4VbGZYEgfZ2W2ZU5ELvM
M/XRgqgjSSGvkf4J+NPWBaMp0nWKNT2ixo/zw5hysBUwfUcp5X0QRuWTgvVDq7Yu
mx/6dDjiGTLmwPtlgKTe/zsr6Gy32R3jfsMC10AQ68v2PmYcdILJQ3uVN6/4c6SA
sStcVCwRtew0Y5onU0jjWwCmg52FWp+V0YfapD6ScHQtZ0RXevuh7DqIl0SeqTkl
86D+5LWZ6yDIKkzHOtE3jwV49p7f+Q8Ih+eQ+HE5A6cqZIT+RlP7XRNumZx0zfEI
LxEFd/o/loocanvS73X1mFkJ55pVoTbsekJQVpYwSNmzgL10MxHvFOpQVWXxK4qb
aYb+LbE4mQB0z8tSj5vWz8X6dsNjXCPfedqpmB//GoNCdFzPSCG4+777EexnUmSB
9fuPku5TRNLbJLlarGJVOudses4kI8gqL86ZEOXBO6PdkuxevjvlvK6CcslFP4hz
d7BeySsPnAd6pYgpGKKo2D7CHjhyjK0Qsbl95YsYGuc0Kx2iHTuqEoN3tQHxOLFv
xbBK4YD7ANsVxr0r3s+KI0QJw6/xn4BIhp8uvchp5ZMPqTtC1QCKDl1+kPY6xxU=
=kuMM
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
