From: Daniel Johnson <computerdruid@gmail.com>
Subject: Re: Mirror plain directory under git
Date: Fri, 24 Sep 2010 10:36:39 -0400
Message-ID: <201009241036.45388.ComputerDruid@gmail.com>
References: <AANLkTi=9nqfzR-Zo85LieBuhv97oudCVZCex8ZL3mM0t@mail.gmail.com> <20100921075621.GA27575@nibiru.local>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart29918087.S20egQg2rD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, suntong@cpan.org
X-From: git-owner@vger.kernel.org Fri Sep 24 16:36:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz9O2-0003bf-D3
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 16:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756711Ab0IXOgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 10:36:22 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:64537 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754600Ab0IXOgV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 10:36:21 -0400
Received: by qwh6 with SMTP id 6so1862987qwh.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 07:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=zks3+BQTHs8gkiuA+w0WPDk0W2NnQwotoCWPqGC4Tfs=;
        b=B7X3qXfg7UtE/QOdS7UjGJAIrOBWL4TjZqftj2S4imruZFEjVIXAZZF43o2PMCUpw2
         7K8DKsBUGRgMN4W1pje+aKy0AVpgy0Ilf3nvPOd2LrYIvgw67yOYL7aF1hKWB7JHz4j0
         ZkSWP7I3TavwCzKP+DSQa8QLRaLN56D54Wbl8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        b=ENU/erhPBG8JXp91AovW2teMY52RfLeB0RILrJ4nAnon61Igttkumj1asuGpMS7q9R
         JnOY5bYicGWXYl4GkEDaclhRCdG6OjYMVZ1pWRZyaJknKqYSheHc4T1Y1USPPUoBZh0/
         Jn9jpzzYs3QbTNkrFdekLxoFmes0EGG6Y3g/U=
Received: by 10.229.11.14 with SMTP id r14mr2569824qcr.228.1285338963404;
        Fri, 24 Sep 2010 07:36:03 -0700 (PDT)
Received: from hyperion.localnet (hyperion.student.rit.edu [129.21.115.231])
        by mx.google.com with ESMTPS id t1sm2407168qcs.21.2010.09.24.07.36.01
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 07:36:02 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.35.3; KDE/4.5.0; x86_64; ; )
In-Reply-To: <20100921075621.GA27575@nibiru.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156994>

--nextPart29918087.S20egQg2rD
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I know nothing about the subject matter of your email, but the date appears=
 to=20
be wrong on this email message, hiding it back further in the history than =
it=20
should be. Just a warning, as the last few emails you sent all seem to be l=
ike=20
this.

Some of the relevant mail headers from this mail:

>Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
>	id S1752826Ab0IXMH3 (ORCPT <rfc822;thleetest9@gmail.com>
>	+ 99 others); Fri, 24 Sep 2010 08:07:29 -0400
>Received: from caprica.metux.de ([82.165.128.25]:38054 "EHLO
>	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
>	by vger.kernel.org with ESMTP id S1752237Ab0IXMH3 (ORCPT
>	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 08:07:29 -0400
>Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1=
])
>	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o8OBuZHp005578;
>	Fri, 24 Sep 2010 14:08:05 +0200
>Received: (from uucp@localhost)
>	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id=20
>	o8NKgxSa008244; Thu, 23 Sep 2010 22:42:59 +0200
>Received: (from weigelt@localhost)
>	by nibiru.metux.de (8.12.10/8.12.10) id o8L7uL3d031552;
>	Tue, 21 Sep 2010 09:56:21 +0200
>Date:	Tue, 21 Sep 2010 09:56:21 +0200

--nextPart29918087.S20egQg2rD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAkyct30ACgkQhP2Vm0oJTtyudgCfXFJzpRs0fxElwPnNcjqwTLm+
gQgAn3tvz6M1PdDdUBsv87ujvfDyL81c
=9wJL
-----END PGP SIGNATURE-----

--nextPart29918087.S20egQg2rD--
