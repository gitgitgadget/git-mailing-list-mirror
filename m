From: William Giokas <1007380@gmail.com>
Subject: Re: [PATCH] svn-fe: Conform to pep8
Date: Thu, 8 May 2014 22:03:53 -0500
Message-ID: <20140509030353.GC550@wst420>
References: <1399603010-2429-1-git-send-email-1007380@gmail.com>
 <20140509024632.GI9218@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 05:04:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wib6Q-0003bs-Eb
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 05:04:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756126AbaEIDD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 23:03:58 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:41595 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395AbaEIDD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 23:03:58 -0400
Received: by mail-ie0-f170.google.com with SMTP id ar20so130277iec.15
        for <git@vger.kernel.org>; Thu, 08 May 2014 20:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qdyEaIygjsMZtyx6X/mAUBIWfolwL5IB11EpHBa9gXs=;
        b=GkS8OWiChmTRy667v4PrlG3BL2Anv2XNOZvOfPmlu72WQgdYwo9S/5EWgzT0Gyf2QT
         uh96GezzEBE0Y29Lz1rpMmeek5k8lvjDaVvMyWNrkAhSgnjCM8ktqcUgd10n8TN9bjqb
         jeNmKAau9ZZwJFg7pEIFFo3w9wLnNweXE3XQ1AcCtuDjPVqttNFdjxSDs6Ox0eS1R0m9
         PXiRgQ9ysw+8fhbjmWQ0iSRDBdGJSBOOLB8BaOd9imy+Ew78MgH7WcOYS6NXE8ADnxgd
         +DFkqazK3I1HOz2nrhBuFuGNee+2Qkspu8sIpptlrl7mtlQuHkh3nZE2zkEGmcL29DU0
         nisw==
X-Received: by 10.50.83.6 with SMTP id m6mr3452141igy.30.1399604637787;
        Thu, 08 May 2014 20:03:57 -0700 (PDT)
Received: from localhost (of2-nat1.sat6.rackspace.com. [50.56.228.64])
        by mx.google.com with ESMTPSA id ql7sm3495955igc.19.2014.05.08.20.03.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 20:03:56 -0700 (PDT)
X-Google-Original-From: William Giokas <wgiokas@wst420>
Content-Disposition: inline
In-Reply-To: <20140509024632.GI9218@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248509>


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 08, 2014 at 07:46:33PM -0700, Jonathan Nieder wrote:
> Hi,
>=20
> William Giokas wrote:
>=20
> > Quite a large change, most of this was whitespace changes, though there
> > were a few places where I removed a comma or added a few characters.
> > Should pass through pep8 and pass every test.
>=20
> Thanks!  Mind if I forge your sign-off?  (See
> Documentation/SubmittingPatches section (5) "Sign your work" for what
> this means.)

Oops. Feel free to put that in there. Most projects that I work on don't
require that and I've gotten in the habbit of not using it.


Thanks,
--=20
William Giokas | KaiSforza | http://kaictl.net/
GnuPG Key: 0x73CD09CF
Fingerprint: F73F 50EF BBE2 9846 8306  E6B8 6902 06D8 73CD 09CF

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTbEWYAAoJEGkCBthzzQnPV5IQAIaCGgtHIy36qvt77GYcQfU1
Dbu51AjxZy+DfgSRR51gmkidrC5SWGQvnyaNCIct1sdUZm2JfiS3tdA6JvcsIt4b
2FYHBMbgx/9FiSd4cCUaHgLxgFEnbrEB2cG8sH4HrTYtvO0ptI16vAIBk1Oi7h0i
CiAtjgfbE7e61FRWDq41ehd3gnZytDRggizIsGUftNkZlfH9JY81Cv+e1n1N5cS4
eoa7jc6EOXVJQcroUaqVh0T/KLV1HBBxyCnyZMiELalDlpWhPWtsBtAEcO2X08/y
CWcCKftKC0WSpScJP34iGLpxinqW+8poZqF4ddstd1T2gOzKcx9NSDP1lxf+1U/p
YTfU6Lgyt/NuPSXhNFc5R5Rviz9g+ZqObnjU59tUK5isKhZxQYvaorA5ZoYFBvTn
c1f4rzhqlenFTBM3JcEbbukwCpt3697m8fmIXs1WhDiLtYAaZCAjSg6J7eLRL/dw
JPbEQLUFhWYIFYk+BW4oKKDZXL5BVj0PZV+QICbpmBeNYoaLIy6WggfDGRC28+mg
0+YCmzB5hJIq9kzfdDK6WNTr1Lrzc7aY5oZKcQLyq1jseSQKhMivOhQAEd2NgzuT
Ztua5isPzrnk6/X9MUvGEqcsjs3NJeREXEZIH83GZJ2j8kUlTC6sf1XK9Zw06Lea
C+t7nGu3Nw963wgth6zi
=v+uA
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
