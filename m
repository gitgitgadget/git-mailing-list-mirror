From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Feature request: Configurable prefixes for git commit --fixup and --squash
Date: Thu, 03 Mar 2016 18:34:10 +0100
Message-ID: <vpqpovbh3e5.fsf@anie.imag.fr>
References: <CALHmdRz3ffgifH2BZK14B=4LGFqOeTWpRarD+RAFx8AtwwMidg@mail.gmail.com>
	<20160303132128.GE1766@serenity.lan>
	<CALHmdRwgDjRJMQSPzp34aS25ZHg-mr458QeyYgyp85q8g34Aig@mail.gmail.com>
	<vpq1t7rlfi1.fsf@anie.imag.fr>
	<CALHmdRwZCb7LnQcKkdy-wNx5Ree+FcMPz2ykqVnTTq_SPDR_HA@mail.gmail.com>
	<vpqvb53ij45.fsf@anie.imag.fr>
	<xmqq7fhj327x.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Martine Lenders <mlenders@riot-os.org>, authmillenon@riot-os.org,
	git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 18:34:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abX8w-0002MW-MB
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 18:34:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757631AbcCCRe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 12:34:26 -0500
Received: from mx1.imag.fr ([129.88.30.5]:37366 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756330AbcCCRe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 12:34:26 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u23HY8lp031687
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 3 Mar 2016 18:34:09 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u23HYAgA032702;
	Thu, 3 Mar 2016 18:34:10 +0100
In-Reply-To: <xmqq7fhj327x.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 03 Mar 2016 09:23:14 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 03 Mar 2016 18:34:09 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u23HY8lp031687
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1457631252.03347@E6whEud1D1K5ODg0KnQrnA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288196>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> I may get some students to work on this in May, or do it myself one day.
>
> I envy teachers who can say "hey, code this for me if you want
> course credits".

Well, in practice it's often still more work to supervise students than
to do the work myself, but supervising students is what I'm paid
for ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
