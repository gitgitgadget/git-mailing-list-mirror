From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: What's cooking in git.git (Jan 2012, #06; Fri, 27)
Date: Mon, 30 Jan 2012 09:47:12 +0100
Message-ID: <vpq62ftd1bj.fsf@bauges.imag.fr>
References: <7vipjwzvc2.fsf@alter.siamese.dyndns.org>
	<7v7h0czur2.fsf@alter.siamese.dyndns.org>
	<7vfwf0xu8a.fsf@alter.siamese.dyndns.org>
	<CAMP44s0FBm3_P--wykHRXROSQLFgmDeVwr2cyEgk33QBfYbdSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 09:47:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrmtY-0003bA-Rq
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 09:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539Ab2A3IrU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jan 2012 03:47:20 -0500
Received: from mx2.imag.fr ([129.88.30.17]:40338 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752856Ab2A3IrU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 03:47:20 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q0U8ii5i025472
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 30 Jan 2012 09:44:44 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RrmtM-0002xg-IM; Mon, 30 Jan 2012 09:47:12 +0100
In-Reply-To: <CAMP44s0FBm3_P--wykHRXROSQLFgmDeVwr2cyEgk33QBfYbdSA@mail.gmail.com>
	(Felipe Contreras's message of "Sat, 28 Jan 2012 19:23:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 30 Jan 2012 09:44:45 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q0U8ii5i025472
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1328517888.59825@qBhkOBv1gk/l3RlKTmT5Eg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189331>

=46elipe Contreras <felipe.contreras@gmail.com> writes:

> On Sat, Jan 28, 2012 at 7:37 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> * mm/zsh-completion-regression-fix (2012-01-17) 1 commit
>>> =A0 (merged to 'next' on 2012-01-23 at 7bc2e0a)
>>> =A0+ bash-completion: don't add quoted space for ZSH (fix regressio=
n)
>>>
>>> Will merge early in the next cycle and deal with any fallout in 'ma=
ster'.
>>
>> This topic has been superseded by Felipe's f15026b (git-completion:
>> workaround zsh COMPREPLY bug, 2012-01-25) to use "typeset -h IFS", s=
o I
>> should drop this.
>>
>> Am I mistaken?
>
> That's correct.

Yes. You can drop my version.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
