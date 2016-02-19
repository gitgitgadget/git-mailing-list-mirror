From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: GSoC 2016: applications open, libgit2 and git.git
Date: Fri, 19 Feb 2016 09:06:23 +0100
Message-ID: <vpq1t896s5c.fsf_-_@anie.imag.fr>
References: <vpqoabox66p.fsf@anie.imag.fr> <20160217172407.GD1831@hank>
	<448280D1-3EEB-40DF-9886-C9B620E32E3C@gmail.com>
	<vpqh9h7f9kz.fsf@anie.imag.fr>
	<xmqq60xnjh1s.fsf@gitster.mtv.corp.google.com>
	<vpqziuzdr5r.fsf@anie.imag.fr>
	<20160217204528.GA22893@sigill.intra.peff.net>
	<xmqq60xnhviw.fsf@gitster.mtv.corp.google.com>
	<1455788324.3786.14.camel@dwim.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@dwim.me>
X-From: git-owner@vger.kernel.org Fri Feb 19 09:06:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWg5U-0004VZ-6m
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 09:06:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422990AbcBSIGn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2016 03:06:43 -0500
Received: from mx1.imag.fr ([129.88.30.5]:55230 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422756AbcBSIGm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 03:06:42 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u1J86NO6010589
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 19 Feb 2016 09:06:24 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1J86OQH031878;
	Fri, 19 Feb 2016 09:06:24 +0100
In-Reply-To: <1455788324.3786.14.camel@dwim.me> ("Carlos =?iso-8859-1?Q?Ma?=
 =?iso-8859-1?Q?rt=EDn?= Nieto"'s
	message of "Thu, 18 Feb 2016 10:38:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 19 Feb 2016 09:06:24 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1J86NO6010589
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1456473986.92872@fojAOpJgir7Cn3WznkHffw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286666>

Carlos Mart=EDn Nieto <cmn@dwim.me> writes:

> We still have most of the same things open as for the 2014 list. I'll
> ask around to see if we have. Last year I wasn't involved in the
> candidate selection but IIRC we didn't do a project as none of the
> applications showed the candidates would be capable of doing the
> project they were applying for.

OK. It's essentially too late to change this for this year, but next
time we should discuss earlier about how we want to organize this
git.git/libgit2 thing. For example, I think it would make little sense
to have a git.git microproject and then apply for a libgit2 project
since we have very different ways of interacting. And honnestly, right
now the application is really git.git-centric so I don't think it
attracts students towards libgit2. So, if you want to attract more
students, we should work on that.

I tried to clarify the situation with libgit2:

https://github.com/git/git.github.io/commit/94d1747eb9621b3bc892be2f232=
338b7933ac271

Please say if you're happy/unhappy with what I wrote. PRs are still
welcome after the deadline.

> I'll ask around to make sure people would be able to be mentors, but =
I
> think that we would still like to put forward a few projects (I can
> send a PR with the projects that we would still like to see to the 20=
16
> page).

We don't have this everywhere, but having a "potential mentors" field
for projects also helps (students, and us, at least to make sure we do
have mentors).

Cheers,

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
