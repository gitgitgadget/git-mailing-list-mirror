From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Developing- Where to Start
Date: Tue, 15 Sep 2015 10:31:33 +0200
Message-ID: <vpqbnd4dqxm.fsf@anie.imag.fr>
References: <CAMTS3bMxb1ak4YHTEU7FYoLVnkmV=4NehQ+obCSp9gV6gFBx_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Breanna Devore-McDonald <Breanna.S.Devore-McDonald.1@nd.edu>
X-From: git-owner@vger.kernel.org Tue Sep 15 10:31:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbleW-0006W2-O4
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 10:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbbIOIbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 04:31:44 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50667 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751961AbbIOIbl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 04:31:41 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t8F8VWVS026459
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 15 Sep 2015 10:31:33 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8F8VXbU008778;
	Tue, 15 Sep 2015 10:31:33 +0200
In-Reply-To: <CAMTS3bMxb1ak4YHTEU7FYoLVnkmV=4NehQ+obCSp9gV6gFBx_Q@mail.gmail.com>
	(Breanna Devore-McDonald's message of "Mon, 14 Sep 2015 16:42:31
	-0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 15 Sep 2015 10:31:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8F8VWVS026459
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1442910694.09736@d0D6t/OKR6fdyO3zJYI2bw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277896>

Breanna Devore-McDonald <Breanna.S.Devore-McDonald.1@nd.edu> writes:

> Hello all,

Hello,

> I'm a third year Computer Science student at the University of Notre
> Dame, and for the final project of my Data Structures class, my group
> and I have to find a way to contribute our (hopefully) newly-found
> data structures and optimization knowledge to a well-known open source
> project. We thought Git would be a great project to work on, but we
> have no idea where to start.

I am a teacher and I offer my students a similar project. I maintain a
list of small projects as source of inspiration for students:

  https://git.wiki.kernel.org/index.php/SmallProjectsIdeas

Some advices before you get started:

* Start with a very, very small contribution, as soon as possible. The
  list of microprojects from GSoC is a good place to start, and the
  easiest projects in the page above can be of interest too.

  This way, you will:

  - Understand how submitting contributions work (if you haven't done
    so, read https://github.com/git/git/blob/master/Documentation/SubmittingPatches )

  - Get an idea of how productive you are when working with the Git
    codebase.

* Even for the actual project, don't try something hard. The difficulty
  here is not to write the first draft, but to get it properly tested,
  reviewed, to respond to reviewers, and finally get the code accepted
  into git.git. Unlike traditional school projects, you can't anticipate
  difficulties (no teacher wrote the correct version for you in
  advance...), and the quality standard is much higher than what you're
  probably used to. A rough heuristics: estimate how long you are going
  to take for your project, multiply by 2 or 3, and you're still getting
  an underestimation.

  As a comparison, for Google summer of code, a very good student works
  full-time for 2 months and writes about 2000 to 3000 lines of code.

  BTW, how long is your project? How many students in your group?

* Interact with the mailing-list as much as you can and as early as you
  can. What you want to avoid is to write a large amount of code and get
  it reviewed at the end of your project. That would almost certainly
  result in requests for changes that you wouldn't have time to apply.

OK, that may all be a bit discourraging ;-). But it shouldn't: it's
_really_ very interesting to contribute to a project like Git.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
