From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: a error in git documentation
Date: Tue, 31 Jul 2012 08:38:51 +0200
Message-ID: <vpqpq7c1ll0.fsf@bauges.imag.fr>
References: <DBDC25FF-7978-49BF-AB39-5EF9496F5456@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jialin Liu <jialinliu7@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 08:39:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sw66i-0001sh-Oe
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 08:39:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875Ab2GaGi7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Jul 2012 02:38:59 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48842 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751870Ab2GaGi6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jul 2012 02:38:58 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q6V6aXob023419
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 31 Jul 2012 08:36:33 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sw66V-0000ja-N7; Tue, 31 Jul 2012 08:38:51 +0200
In-Reply-To: <DBDC25FF-7978-49BF-AB39-5EF9496F5456@gmail.com> (Jialin Liu's
	message of "Mon, 30 Jul 2012 22:38:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 31 Jul 2012 08:36:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6V6aXob023419
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1344321396.9304@c0ioNYUWHjw3X1y5/0mQVg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202630>

Jialin Liu <jialinliu7@gmail.com> writes:

> In http://git-scm.com/book/en/Git-Basics-Recording-Changes-to-the-Rep=
ository
>
> Notice how you don=E2=80=99t have to run git add on the benchmarks.rb=
 file in this case before you commit.

In which case? (the page is rather long)

I didn't see a case where "git add" was not needed (or "git commit" use=
d
with "-a", which gives the same effect).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
