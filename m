From: "Mike.lifeguard" <mike.lifeguard@gmail.com>
Subject: Pseudonymous commits
Date: Thu, 25 Mar 2010 00:57:40 -0300
Message-ID: <4BAADF34.3080806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 25 04:58:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NueCu-0002M9-SE
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 04:58:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080Ab0CYD57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 23:57:59 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:5247 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016Ab0CYD56 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 23:57:58 -0400
Received: by qw-out-2122.google.com with SMTP id 8so2110331qwh.37
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 20:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=DXvyinO22g1HBjoPAr7saxnkNaKEWvYykTlFtcritCw=;
        b=QWuEJ1Knpjw2Ggp3JE/pYHuKaD4iOp0oHRpYR7AY7hQ7T/sq9GSfPWrUN2LMqkPYHW
         jD8LoAupNm3Q6grDcOK3x4Ku+LgbMnFnhMXfESbmBlH6mhQzUN0y0xQrRyk1ZAFHf6vt
         YdEFbuDJE9XNJpdCFwxcmxo0tXMf00o1e0r7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type:content-transfer-encoding;
        b=HouOoshINtA9XIp0Pov/jKmDedDloy6ntJeNNh38tuMB1GnMCc03GIBDjKqoXvARuk
         OpdGP4jlmWPFNkxh2yCqU4XYgNvFrSI1PZrgNtsIO37UHfPuNIoEbwAqdfR3Kf4okd0+
         LSNw1ZSm0pA0q91UfNzO7V8KsYByCH4ngZTIU=
Received: by 10.224.83.70 with SMTP id e6mr3382411qal.177.1269489477526;
        Wed, 24 Mar 2010 20:57:57 -0700 (PDT)
Received: from [192.168.0.2] ([142.177.156.3])
        by mx.google.com with ESMTPS id 26sm1709413qwa.13.2010.03.24.20.57.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Mar 2010 20:57:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.23) Gecko/20090817 Thunderbird/2.0.0.23 Mnenhy/0.7.6.0
X-Enigmail-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143146>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

Git gives attribution by a "name" and an "email" - however several
contributors I work with are uncomfortable giving that information. I
can easily use a pseudonym (I do so for myself), but is there any way to
not have an email? Or shall I just use "not@real.email"?

While on the subject, I'm curious why name+email was decided upon for
attribution, instead of name + optional-email + optional-URL or
something that might provide additional information or useful metadata.

Thanks,
- -Mike

PS, I still have a question about git-svn & splitting repos with
filter-branch under subject "dcommit-ing from a split repo"
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuq3zQACgkQst0AR/DaKHsDZQCgxitnecj1I6NMDIindJuQna/u
AoUAoNlYAQKHYx5PGYNY3MaeiKXh49qa
=etTo
-----END PGP SIGNATURE-----
