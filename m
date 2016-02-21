From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: GSoC 2016: Microproject
Date: Sun, 21 Feb 2016 05:55:53 +0100
Message-ID: <vpq8u2er7ae.fsf@anie.imag.fr>
References: <CA+DCAeTAmUAciCx33ZHLKReHSy4K-dEeaKSb19qBcQc_U80UJA@mail.gmail.com>
	<vpq37so26oz.fsf@anie.imag.fr>
	<CA+DCAeQLJnvNFdSobDNOGVaHbDRnRy4vm9_4SB+Bw+5N5QMKHA@mail.gmail.com>
	<CAGZ79kbdTFui5Zxmt0+BrgOzxTFsN2n-XZiJBNj4QFD3HPRpBQ@mail.gmail.com>
	<CA+DCAeRTtECCZSAPYUe2=AoQEvc6LRG1B+qYCCj9C6_nyUJrhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 09:58:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXmJq-0004wq-4I
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 09:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989AbcBVI6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 03:58:10 -0500
Received: from mx2.imag.fr ([129.88.30.17]:60165 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797AbcBVI6I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 03:58:08 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1L4trSU015839
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 21 Feb 2016 05:55:54 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1L4trbM027499;
	Sun, 21 Feb 2016 05:55:53 +0100
In-Reply-To: <CA+DCAeRTtECCZSAPYUe2=AoQEvc6LRG1B+qYCCj9C6_nyUJrhw@mail.gmail.com>
	(Mehul Jain's message of "Sat, 20 Feb 2016 20:13:40 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 21 Feb 2016 05:55:54 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1L4trSU015839
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1456635358.67332@gjwxzZAJlwrzMyN5cxRLeA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286895>

Please, don't top-post on this list.

Mehul Jain <mehul.jain2029@gmail.com> writes:

> Hello,
>
> I faced the following problem when I tested master branch. Here I have
> made no commits to master branch.

Are you sure that 1) you have no uncommitted change and 2) you have
compiled what you have in your tree?

> Is this test failure usual with linux based system or just happened with me.

All tests are supposed to pass. You can see the result of the Travis-CI
builds there:

  https://travis-ci.org/git/git/branches

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
