From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv7 1/4] wt-status.*: better advices for git status added
Date: Tue, 05 Jun 2012 13:33:22 +0200
Message-ID: <vpqy5o2hu2l.fsf@bauges.imag.fr>
References: <1338748217-16440-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1338830399-31504-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<7vtxyqr89y.fsf@alter.siamese.dyndns.org>
	<20120605123219.Horde.4685bnwdC4BPzeAz2LLCYAA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Tue Jun 05 13:33:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbs0z-00067W-Qm
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 13:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933944Ab2FELda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 07:33:30 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50297 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933635Ab2FELd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 07:33:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q55BOmjF024347
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 5 Jun 2012 13:24:48 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sbs0p-0007WX-Ea; Tue, 05 Jun 2012 13:33:23 +0200
In-Reply-To: <20120605123219.Horde.4685bnwdC4BPzeAz2LLCYAA@webmail.minatec.grenoble-inp.fr>
	(konglu@minatec.inpg.fr's message of "Tue, 05 Jun 2012 12:32:19
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 05 Jun 2012 13:24:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q55BOmjF024347
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339500290.50107@m1O5E/HTf4Hl+C2MchlaeQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199232>

konglu@minatec.inpg.fr writes:

> > Perhaps s/fixed this problem/resolved conflicts/ [...]
>
> I agree. Still, experienced users probably have their advice.statushints
> disabled and won't have any problems resolving a conflict. However, for
> "beginners" that need the advices, resolving a conflict may not seem
> as trivial as it is. And even though the word "problem" may scare them,
> it will attract their attention.

But beginners are scared by conflicts. Indeed, "there are conflicts" is
automatically translated into "sir, it doesn't work" by many beginners I
know ;-). I prefer Junio's wording as a subliminal message that
conflicts are not "a problem", but just "something you should avoid when
possible, and fix otherwise".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
