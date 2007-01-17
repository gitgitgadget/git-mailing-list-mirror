From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Subject: Re: [PATCH] git-reset: make the output as the fetch output
Date: Wed, 17 Jan 2007 22:38:54 +0900 (JST)
Organization: USAGI/WIDE Project
Message-ID: <20070117.223854.10678094.yoshfuji@linux-ipv6.org>
References: <87odox23u9.fsf@gmail.com>
	<8aa486160701170527p69c59510i2daf99e7e805ec5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, yoshfuji@linux-ipv6.org
X-From: git-owner@vger.kernel.org Wed Jan 17 15:02:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7BMZ-0001Qq-En
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 15:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbXAQOCA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 17 Jan 2007 09:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbXAQOCA
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 09:02:00 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:46261 "EHLO
	yue.st-paulia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932074AbXAQOB7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jan 2007 09:01:59 -0500
X-Greylist: delayed 1447 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jan 2007 09:01:59 EST
Received: from localhost (localhost [127.0.0.1])
	by yue.st-paulia.net (Postfix) with ESMTP id 9A9E433B40;
	Wed, 17 Jan 2007 22:38:56 +0900 (JST)
To: sbejar@gmail.com
In-Reply-To: <8aa486160701170527p69c59510i2daf99e7e805ec5a@mail.gmail.com>
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 3.3 on Emacs 20.7 / Mule 4.1 (AOI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37004>

In article <8aa486160701170527p69c59510i2daf99e7e805ec5a@mail.gmail.com=
> (at Wed, 17 Jan 2007 14:27:15 +0100), "Santi B=E9jar" <sbejar@gmail.c=
om> says:

> > @@ -84,14 +85,20 @@ fi
> [...]
> > +    echo "* HEAD: reset to $commit"
> [...]
>=20
> perhaps?
> echo "* HEAD: resetted to $commit"

Of course, not.  Past (and past participle) of "reset" is "reset".

--yoshfuji
