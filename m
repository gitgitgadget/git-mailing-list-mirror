From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] annotate: Support annotation of files on other revisions.
Date: Mon, 06 Mar 2006 10:44:39 -0500
Message-ID: <440C58E7.5080402@michonline.com>
References: <20060305111334.GB23448@c165.ib.student.liu.se> <440B751F.5000801@michonline.com> <46a038f90603051629ke34a0a6u89dad995bbd777b0@mail.gmail.com> <20060306024353.GA23001@mythryan2.michonline.com> <Pine.LNX.4.63.0603061016320.1422@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5F91A37CD3EF77ADF14BE424"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 06 16:45:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGHtT-0001Mt-Ni
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 16:45:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWCFPow (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 10:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbWCFPow
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 10:44:52 -0500
Received: from mail.autoweb.net ([198.172.237.26]:2968 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1751459AbWCFPov (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Mar 2006 10:44:51 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1FGHtA-0003ip-Rr; Mon, 06 Mar 2006 10:44:50 -0500
Received: from [10.254.251.12] (helo=mythryan.michonline.com)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FGHt3-0003hw-SZ; Mon, 06 Mar 2006 10:44:41 -0500
Received: from localhost ([127.0.0.1])
	by mythryan.michonline.com with esmtp (Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FGHt3-00070d-H2; Mon, 06 Mar 2006 10:44:41 -0500
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0603061016320.1422@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.93.0.0
X-h4x0r5.com-MailScanner: Found to be clean
X-h4x0r5.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17298>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5F91A37CD3EF77ADF14BE424
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Johannes Schindelin wrote:

>Hi,
>
>On Sun, 5 Mar 2006, Ryan Anderson wrote:
>
>  
>
>>+use Data::Dumper;
>>    
>>
>
>You really need this?
>  
>

I keep adding it back in when debugging things, and then promptly forget
to remove it when I cull the debugging back out.

It's a core module, so it shouldn't be a significant issue for any porting

-- 

Ryan Anderson
  sometimes Pug Majere


--------------enig5F91A37CD3EF77ADF14BE424
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFEDFjpfhVDhkBuUKURAoAdAJ0VfYGgzs5u5Z8Yeazgn4/BHJIPEwCcDGnz
bwnlgYPw+bNciWIL+q/MdlU=
=/MQ9
-----END PGP SIGNATURE-----

--------------enig5F91A37CD3EF77ADF14BE424--
