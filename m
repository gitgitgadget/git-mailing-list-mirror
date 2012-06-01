From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv5 1/3] wt-status.*: better advices for git status added
Date: Fri, 01 Jun 2012 11:26:59 +0200
Message-ID: <vpqzk8ngz6k.fsf@bauges.imag.fr>
References: <1338384216-18782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<7vmx4o58zc.fsf@alter.siamese.dyndns.org>
	<20120601111651.Horde.R0mdSHwdC4BPyIiDyUHhUVA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Fri Jun 01 11:27:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaO8o-0007hH-IS
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 11:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759088Ab2FAJ1H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jun 2012 05:27:07 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42579 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758764Ab2FAJ1G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 05:27:06 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q519Ibqn018426
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 1 Jun 2012 11:18:37 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SaO8K-0005MI-NM; Fri, 01 Jun 2012 11:27:00 +0200
In-Reply-To: <20120601111651.Horde.R0mdSHwdC4BPyIiDyUHhUVA@webmail.minatec.grenoble-inp.fr>
	(konglu@minatec.inpg.fr's message of "Fri, 01 Jun 2012 11:16:51
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 01 Jun 2012 11:18:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q519Ibqn018426
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339147118.65433@chqNoJ+ZZ/NiNjzYKdT/4A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198968>

konglu@minatec.inpg.fr writes:

> Junio C Hamano <gitster@pobox.com> a =E9crit=A0:
>
>> How is your development process work, by the way?  Does everybody on
>> this list have code in this patch?  Or are you just listing people
>> who are in the same class taught by Matthieu who reviewed and
>> commented on this patch?
>
> Basically, we 5 people are in the same group and work together on
> the same project. Some are more involved into improving the advices
> in git status, and some are more involved into the XDG configuration
> but we are all in the same room thus there're a lot of communication =
so
> everyone knows what's happening in each topics. Matthieu is helping u=
s
> when we have technical questions but he doesn't review our code befor=
ehand
> (he is very busy :p).

Just an addition: I'm not really a co-author of the work, but I'm the
one who authorize the students to contribute their code to Git (they ar=
e
normally not allowed to distribute the code they develop for school
projects).

I think this implies that I should appear in the Signed-off-by: of the
patches.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
