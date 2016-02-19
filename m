From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Fri, 19 Feb 2016 13:49:05 +0100
Message-ID: <vpqr3g827cu.fsf@anie.imag.fr>
References: <vpqoabox66p.fsf@anie.imag.fr> <20160217172407.GD1831@hank>
	<448280D1-3EEB-40DF-9886-C9B620E32E3C@gmail.com>
	<vpqh9h7f9kz.fsf@anie.imag.fr>
	<1CE3F5E2-DDCC-4F1B-93CF-1A4A194650BF@gmail.com>
	<CAGZ79kbGyCTdq4P02fNb7tEuvkvqcZviWJp40Ob1ed6=JCh9Xg@mail.gmail.com>
	<xmqq7fi1hlw6.fsf@gitster.mtv.corp.google.com>
	<0E364888-DD95-4B47-9679-3CB586FC7E8C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 13:49:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWkUs-0001Jy-Ia
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 13:49:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757454AbcBSMtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 07:49:18 -0500
Received: from mx2.imag.fr ([129.88.30.17]:36609 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757175AbcBSMtR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 07:49:17 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1JCn3H8013494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 19 Feb 2016 13:49:03 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1JCn5kY007003;
	Fri, 19 Feb 2016 13:49:05 +0100
In-Reply-To: <0E364888-DD95-4B47-9679-3CB586FC7E8C@gmail.com> (Lars
	Schneider's message of "Fri, 19 Feb 2016 10:23:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 19 Feb 2016 13:49:04 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1JCn3H8013494
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1456490945.66989@+IzfyuNNkDEgi4XQrG3XwA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286713>

Lars Schneider <larsxschneider@gmail.com> writes:

> Thanks for your elaborate response. I think I got your point and I
> tried to adjust my "beginner mode" proposal accordingly [1].

Now merged as
https://github.com/git/git.github.io/commit/6b8b5e19cdb221192dedd70ba3e207636f1cdab1

I've added a warning for students:

  Note that this project is not technically difficult, it requires a
  deep understanding of Git: how each command is meant to be used, what
  are the potential dangers, ... Reaching a solution that effectively
  protects beginners without harming anyone is much harder than it
  seems. See for example [this
  thread](http://thread.gmane.org/gmane.comp.version-control.git/285893/focus=286614)
  for example potential objections. If chosen, this project should be
  discussed in depth on the list before and after the student
  application.

I just want to avoid students loosing their time writting silly
proposals (once you have seen what the majority of proposals looks like,
nothing surprises you anymore ;-) ).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
