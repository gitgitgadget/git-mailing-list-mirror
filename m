From: Phillip Sz <phillip.szelat@gmail.com>
Subject: Re: [PATCH] l10n: de.po: better language for 2 strings
Date: Fri, 18 Sep 2015 16:43:46 +0200
Message-ID: <55FC2322.1030901@gmail.com>
References: <1442505032-11578-1-git-send-email-phillip.szelat@gmail.com>
 <20150918084808.GA10616@ralf-ubuntu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AdToPqqAJmH2fONANnlW0PBhp3J83XAnS"
Cc: git@vger.kernel.org, tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com,
	sbeller@google.com
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 16:53:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zcx29-0004YF-Db
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 16:53:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216AbbIROxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 10:53:00 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35595 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbbIROn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 10:43:56 -0400
Received: by wicge5 with SMTP id ge5so35935562wic.0
        for <git@vger.kernel.org>; Fri, 18 Sep 2015 07:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type;
        bh=ge+YLUQmg28dlAKXT7Zu1sbt1yqPn6X5UhPogvuKWoU=;
        b=EfdrYsUXK+vDTyTwG2xGAQwbt33LYoF4XTTBEj+CwMpEx1NB/apgjSsMCJGZkd1Un5
         m7zt8g8KFjVEhA/vYnbBiJXccdJxHyb3MGlR47hzno8uBMzl+g9S6HbdvrXAe6r2r+9T
         RYrevYWQJsdDcS8MiJsW1U13/UdV3CocSoc0E1tkZWBC8Uvo3xwgm+YEuRyHqd98c8k+
         BJttqkIQOn93B58ckSGqtwzzBruzRBnkfiPVM6SEn7izi7QfFeY5M3P80mXtFOmwjRNE
         J7Z1+P1DQYGmxgVzUFNSMK5ixETlLS0oDGkoyJYWvVd9ew2O7H+D+Vwsk9J9TQfOCfM1
         Iypw==
X-Received: by 10.194.48.81 with SMTP id j17mr7459909wjn.81.1442587434033;
        Fri, 18 Sep 2015 07:43:54 -0700 (PDT)
Received: from [192.168.178.84] (i577AB33D.versanet.de. [87.122.179.61])
        by smtp.googlemail.com with ESMTPSA id gl4sm9223758wjb.29.2015.09.18.07.43.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Sep 2015 07:43:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <20150918084808.GA10616@ralf-ubuntu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278195>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AdToPqqAJmH2fONANnlW0PBhp3J83XAnS
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

>>  #: git-am.sh:512
>>  msgid "Please make up your mind. --skip or --abort?"
>> -msgstr "Bitte werden Sie sich klar. --skip oder --abort?"
>> +msgstr "Bitte entscheiden Sie sich. --skip oder --abort?"
>> =20
>=20
> This string has been removed in 40147ec (l10n: de.po: translate 123
> new messages), so I've updated the commit accordingly.
>=20

Thanks, a lot!

> From: Phillip Sz <phillip.szelat@gmail.com>
> Date: Thu, 17 Sep 2015 17:50:32 +0200
> Subject: [PATCH] l10n: de.po: better language for one string
>=20
> Just one string I think we could translate better.
>=20
> Signed-off-by: Phillip Sz <phillip.szelat@gmail.com>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>

Phillip



--AdToPqqAJmH2fONANnlW0PBhp3J83XAnS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV/CMnAAoJEJIt6Cqh4sVSMFwH/1LYbk/+mZ7Zg2whWYwdeq4X
gYXrhOCUvi4qIs33aX8l89AMnJqeT57kK2aGQyimouHy1Moy/jqdegzZSsskglec
exSHKDXNf1QuN6LJ3pVgtzdPPaVzOKb9AyEfm1OP9hsvF0nbfxOBfl2BSS6iKkGl
Fs2oy9P/7k4qQ/3/jvphLdWykZQycfF7Dx8LlrD2+9+Ybx+BASFT7XxQjuyBGG/Y
BKGCQBx73alO79ajAsLdbL0mJ04+OyHtlmR5wclhUA3BrIPZx59ajJHPH8asIpDs
fnyA2l2MQqwPMmKZWYkWMcKsOR5itOaF5BxoxI7MYEGiA45vCpWAa8Y8Mb3WZuo=
=H7+I
-----END PGP SIGNATURE-----

--AdToPqqAJmH2fONANnlW0PBhp3J83XAnS--
