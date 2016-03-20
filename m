From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/GSoC] Introduction
Date: Sun, 20 Mar 2016 21:17:59 +0100
Message-ID: <vpqwpow9a4o.fsf@anie.imag.fr>
References: <56E3BE3E.9070105@gmail.com>
	<1924FEBB-46F2-46EE-B190-5289588D4BED@gmail.com>
	<xmqqk2l58s2a.fsf@gitster.mtv.corp.google.com>
	<FB2E0900-A77E-4AE2-A580-9192746A8ABA@gmail.com>
	<56E6DF17.2040106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sidhant Sharma <tigerkid001@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 21:18:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahjnq-00053l-RH
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 21:18:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbcCTUSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 16:18:11 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38616 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017AbcCTUSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 16:18:09 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u2KKHvgJ016632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 20 Mar 2016 21:17:58 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u2KKHxXK017042;
	Sun, 20 Mar 2016 21:17:59 +0100
In-Reply-To: <56E6DF17.2040106@gmail.com> (Sidhant Sharma's message of "Mon,
	14 Mar 2016 21:26:07 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Sun, 20 Mar 2016 21:17:58 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u2KKHvgJ016632
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1459109883.40205@02mFtBw7IcnS5jnoQl2fjg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289383>

Sidhant Sharma <tigerkid001@gmail.com> writes:

> On Monday 14 March 2016 01:46 PM, Lars Schneider wrote:
>
>> I also thought about (2). The obvious advantage of having something like 
>> "ggit" as part of Git core is that it would be shipped with the standard
>> Git distribution. That would especially help beginners.

Yes. And that would allow any tutorial to start with something like
"Since you're a beginner, use the command ggit instead of git. When
you're confident enough, just drop the first 'g' and continue hacking."

Asking a beginner to install a separate tool before starting is a show
stopper to me. Or at least, it should be _very_ easy to install.

> I understand that this endeavour may or may not be merged into
> the official Git distribution (though I'd really like it to :)), but
> I still wish to attempt this. I'm also eager to continue work on this
> even after GSoC is over, so maintenance shouldn't be an issue ;)

My usual advice on this point (both for mentors and students): hope that
you will continue contributing after the end of the project, but plan as
if you won't. You don't want the survival of your code to depend only on
you.

I have experience similar to GSoC where I offer CS students to
contribute to open-source software as part of a school project. Almost
all of them told me that they would continue after and essentially none
of them did. I think at least most of them were sincere when they said
they would continue, but then they realize that days have only 24 hours
and life is short ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
