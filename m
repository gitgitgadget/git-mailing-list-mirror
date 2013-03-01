From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] GIT SVN
Date: Fri, 01 Mar 2013 13:29:05 +0100
Message-ID: <vpqsj4fmhgu.fsf@grenoble-inp.fr>
References: <000301ce1677$c9eb3f80$5dc1be80$@certicon.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Jan =?iso-8859-15?Q?Pe=A8ta?= <jan.pesta@certicon.cz>
X-From: git-owner@vger.kernel.org Fri Mar 01 13:29:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBP5l-0000S6-Dh
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 13:29:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721Ab3CAM3M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Mar 2013 07:29:12 -0500
Received: from mx1.imag.fr ([129.88.30.5]:60232 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750696Ab3CAM3L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 07:29:11 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r21CT4aO012874
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 1 Mar 2013 13:29:04 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UBP5F-0001lg-Ff; Fri, 01 Mar 2013 13:29:05 +0100
In-Reply-To: <000301ce1677$c9eb3f80$5dc1be80$@certicon.cz> ("Jan
 \=\?iso-8859-15\?Q\?Pe\=A8ta\=22's\?\=
	message of "Fri, 1 Mar 2013 13:24:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 01 Mar 2013 13:29:04 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r21CT4aO012874
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1362745748.42151@pZl85KdzQRG4wmFxnkE2UA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217272>

Jan Pe=A8ta <jan.pesta@certicon.cz> writes:

> Sorry,
> My fault :)
>
> Here is a patch atached.

Still, please, read Documentation/SubmittingPatches. Your patch cannot
be included as it is because of lack of sign-off.

Also, please write a commit message describing why this change is
needed. Where is this extra "*" comming from, and why do you need to
remove it?

Thanks,

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
