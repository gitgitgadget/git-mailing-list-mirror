From: Johannes =?utf-8?B?TMO2dGhiZXJn?= <johannes@kyriasis.com>
Subject: Re: [PATCH v2] commit: add commit.signoff config option
Date: Thu, 25 Jun 2015 17:08:56 +0200
Message-ID: <20150625150856.GC28349@leeloo.kyriasis.com>
References: <1435243807-32112-1-git-send-email-cmarcelo@gmail.com>
 <xmqqlhf725xy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1SQmhf2mF2YjsYvc"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 17:09:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z88m7-0004GJ-Lx
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 17:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbbFYPJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 11:09:07 -0400
Received: from theos.kyriasis.com ([212.71.254.33]:58307 "EHLO
	theos.kyriasis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbbFYPJF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 11:09:05 -0400
Received: from theos.kyriasis.com (localhost.localdomain [127.0.0.1]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTP id 60cc1a43;
	for <git@vger.kernel.org>;
	Thu, 25 Jun 2015 15:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyriasis.com; h=date:from
	:to:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=theos; bh=bHMhb0+54k/Kgd36nu+UqtBDkBo=; b=KcOTQT
	DOoAEiUrIZl7oe7YMobTYCQqxZ8wiUTf6ggrdpLGTy3qH9Z+N2mw65gY1PLLpqW1
	Ifu6F9Guo6+LpnKNk6ecfCad2eLmWi2v05f5SK3giW70wymi2n6K7NAFpTH7yaxt
	NUgMKZiI+mQFgjlDgIryjdugOBok1S6uMo/MY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kyriasis.com; h=date:from:to
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=theos; b=e7pNj/MyU1U6IK5f65wuUEVODGteEiTc
	8RlOy8MB3GlozeV/NekquJyAymsli1pZqYG4yO3ub4CKjSPNCtHrn4CY20JV9g+q
	Dtto+zr0L+wZOF+aNr733fnYUZhW7C+sqP61MMLnjvdaWiNIlIDEIB1EmG66uASv
	vUwhBW4KYjw=
Received: from leeloo.kyriasis.com (47.67.24.31.in-addr.zone [31.24.67.47]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTPSA id 6a75a027;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	for <git@vger.kernel.org>;
	Thu, 25 Jun 2015 15:09:03 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqqlhf725xy.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272682>


--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25/06, Junio C Hamano wrote:
>Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com> writes:
>Hmm, I do not recall seeing v1 but that is OK.
>
>The following immediately comes to mind.
>
>http://thread.gmane.org/gmane.comp.version-control.git/51754/focus=3D51780

To be honest I'm not sure I buy that since we have `git commit -s`,=20
which is just as easily added as a really simple git alias.

--=20
Sincerely,
  Johannes L=C3=B6thberg
  PGP Key ID: 0x50FB9B273A9D0BB5
  https://theos.kyriasis.com/~kyrias/

--1SQmhf2mF2YjsYvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQQcBAEBCgAGBQJVjBmFAAoJEJAcHDIOsNRd/oIgAIxjXtjGlfPrKrdGrS0RsoXA
LZ/eo9+vlmzhz3NEK1KJjDsdFFMp3FyFYvH+kX8IYHZnpjbMAyaP1JliO+an5Iw1
iajkW1Wb4HDYUNibptU/H9OY83uYaY8JkMQZZKhJUZisoJzxc6VO9GyxAf4IMiDE
k1iqaT1DAS5hmgDYJUM9cedd65sf8mb8anGRqMubfKFIQbf6J+p73gORWDbfjzLv
GslRNOAqqAWQTTDtW74p/Xsl59LGgEuTbNWuG+QWDo55CSMFvt0PzLKg46YiTrFn
08ARtsUP1hMNhBZzj7gQeonEE1xI+X0bu2zWSrrWQmkIjh7Zp0P8k60yn9RBfjJo
MPKtg11DBhP4RzKhPY8rz7J7tz/QP7GYn8MzjMeqypyNoHcxV7PfaoatamixB/4O
29Vez3Uxnm5hvu5jOqDaIyy9QT8OuWHl73eAK8+OxxUKkN+StebjAQ8Wd/zT4Vth
2ps9hN8TC5FNmvY4KhciyQzfkFL9p2lRwhCL65OuLpAD05/7xPqcCCgMCyOtdM5R
Vo6MbWJNP/mNu3P/l/JRzgAqXPZcuSIvBk81mhTlTBk39wXshZbyqx8Rebiu5/Wg
Otons3fWzRLgu3OXYlCkfdXixD/2+boOISgiyaNCKfe3jM/+SILXSzdTJUskhJQO
w8T8+wTkkjtATG8YkeqV4GwgyyfHQecZ7FyA43TT+3FaQXEtRPCOqLgQkRGdjVXE
Dj2I0q2IGkUi2JyYgX2trl3LKh5I6LjchArzib00Bko3352EnMZLBYEnsM0o7eQw
7xtO19w84yQWcyDvX7nd/VNHMKCfAFCz/E1/Tmztsyp7CnyeUxjVFc9RgVdq7mj4
uImIfcyvFu1mJMSfY56xdXD6oWhvKJpdZw8SicOaz6olQvm8cM7wis3/wKSdwmVS
STbfbv/jc+0LqKxM7IEMBBeXSgaiFLQ9+hW1A/UxiovsHux+I2yLXx4ACuGHfbYS
W4pN4beHWqaZp58tD+RI2xMF96qGvTXlpsU9IGsTAfKeVtYe57k+ovY+4rp475lp
lqTE3B9C5lVOCTdZsAmHt8rIM4tfORWcGVX3ZNSs3ySBcq2VL4yM1GmeX7RpcpN3
VK7eYjF6bYCHtnrNghXGs3SqoWXxZghQ1jQ1j3IjVssS23baViai8RrLI8QeZ6xU
v8p6EgaH2zvHt+meAly5LVGIT41k5HMEjAJ7cF6uBS/O5X05iYEI7q+8b64tHNi1
l4n4zj1TNIbi+tDf9ct6L49aBcGcB2MkZyALZbsnDpkN44sira/uE3aBsuIKPSQ1
5Yx/iDF2iqJy6Eb1DTuf3LhVWO1d8kqOcJ4KtZ2QYOV9EpJSu850KBbrGLp5J8Q=
=D5Ab
-----END PGP SIGNATURE-----

--1SQmhf2mF2YjsYvc--
