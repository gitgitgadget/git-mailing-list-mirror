From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] GIT SVN
Date: Fri, 01 Mar 2013 14:07:53 +0100
Message-ID: <vpqip5bmfo6.fsf@grenoble-inp.fr>
References: <000301ce1677$c9eb3f80$5dc1be80$@certicon.cz>
	<vpqsj4fmhgu.fsf@grenoble-inp.fr>
	<001001ce167c$0f376f10$2da64d30$@certicon.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Jan =?iso-8859-15?Q?Pe=A8ta?= <jan.pesta@certicon.cz>
X-From: git-owner@vger.kernel.org Fri Mar 01 14:08:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBPhH-0001qP-7I
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 14:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863Ab3CANH6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Mar 2013 08:07:58 -0500
Received: from mx2.imag.fr ([129.88.30.17]:39030 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750696Ab3CANH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 08:07:57 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r21D7q0n013129
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 1 Mar 2013 14:07:52 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UBPgn-0002Gg-Ug; Fri, 01 Mar 2013 14:07:53 +0100
In-Reply-To: <001001ce167c$0f376f10$2da64d30$@certicon.cz> ("Jan
 \=\?iso-8859-15\?Q\?Pe\=A8ta\=22's\?\=
	message of "Fri, 1 Mar 2013 13:55:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 01 Mar 2013 14:07:53 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r21D7q0n013129
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1362748073.5751@p2424MPddyFa5d/QFvJSXw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217275>

Jan Pe=A8ta <jan.pesta@certicon.cz> writes:

> Hi again,
>
> Finally I created patch according to document.

This is much better, but you still haven't taken into account some
important parts of Documentation/SubmittingPatches (the part about
attachments Vs inline patch, and the part about sign-off).

Thanks,

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
