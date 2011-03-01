From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Consistent terminology: cached/staged/index
Date: Tue, 01 Mar 2011 10:15:58 +0100
Message-ID: <vpqaahf9p69.fsf@bauges.imag.fr>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
	<20110213193738.GA26868@elie>
	<7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
	<AANLkTim4UKxYwRagCk3R20e7wsRb7CxvS_ze9b8MfWjL@mail.gmail.com>
	<20110214231920.GA24814@elie>
	<AANLkTik-jc0ZX9S4bCYV8VBgPXJZsX0U08W2H+jufO8r@mail.gmail.com>
	<20110227084317.GB3356@sigill.intra.peff.net>
	<1298820840.19827.69.camel@drew-northup.unet.maine.edu>
	<20110228230311.GA7533@sigill.intra.peff.net>
	<AANLkTi=LPqu9zDiAJpxqC=ZCLig+aCv5ztXw668ERtH7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Drew Northup <drew.northup@maine.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David <bouncingcats@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 10:16:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuLh4-0000GG-Kc
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 10:16:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754060Ab1CAJQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 04:16:28 -0500
Received: from mx1.imag.fr ([129.88.30.5]:42404 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753741Ab1CAJQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 04:16:26 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p219Fuxg027049
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 1 Mar 2011 10:15:56 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PuLgU-00082v-TU; Tue, 01 Mar 2011 10:15:58 +0100
In-Reply-To: <AANLkTi=LPqu9zDiAJpxqC=ZCLig+aCv5ztXw668ERtH7@mail.gmail.com>
	(David's message of "Tue, 1 Mar 2011 20:11:11 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 01 Mar 2011 10:15:56 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p219Fuxg027049
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1299575761.27814@++qUqxTSHgRUFJ4J7Ci3zg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168197>

David <bouncingcats@gmail.com> writes:

> A suggestion: could your conceptual bucket be named as "the
> precommit".

I actually like it.

Maybe "precommit area", or "precommit something", because "precommit"
could be seen either as an action (like the pre-commit hook) or as a
place to put stuff.

As a non-native speaker, I didn't know what "staging area" really meant
in english, but the "area" part of the expression immediately made sense
to me. Had it been called the "foobar-ing area", I would have found it
more intuitive than cache or index ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
