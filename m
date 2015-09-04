From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: GSoC 2015 is over
Date: Fri, 04 Sep 2015 18:14:06 +0200
Message-ID: <vpqoahib1rl.fsf@anie.imag.fr>
References: <vpq8u8qw047.fsf@anie.imag.fr>
	<xmqqy4gon1ow.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaYRZyaK6FhcChd3MtxXL7L0E7XYJ8mqoXTUntK-_O+fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Paul Tan <pyokagan@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 18:15:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXtdl-0007qt-LE
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 18:15:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760030AbbIDQO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 12:14:58 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49930 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755488AbbIDQO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 12:14:57 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t84GE5BB012600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 4 Sep 2015 18:14:05 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t84GE6hY009142;
	Fri, 4 Sep 2015 18:14:06 +0200
In-Reply-To: <CAGZ79kaYRZyaK6FhcChd3MtxXL7L0E7XYJ8mqoXTUntK-_O+fA@mail.gmail.com>
	(Stefan Beller's message of "Wed, 2 Sep 2015 11:01:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 04 Sep 2015 18:14:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t84GE5BB012600
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1441988047.03884@ZWbQ8+R6keSb8LwjVlGNaw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277321>

Stefan Beller <sbeller@google.com> writes:

> On Wed, Sep 2, 2015 at 10:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>>  * The individual qualities of the students we got this year must
>>    have been a major factor.  This we can indirectly influence by
>>    having a very engaging microproject period, I think, and we did
>>    so this year.

For sure, having good students does help ;-).

Note that "good" students is not just a matter of technical skills, but
also largely a matter of motivation, perseverance & so. I remember in
past years students for which we had very high hopes and who lost
interest in the GSoC during the summer.

It's actually very hard to identify good students before the project. My
experience (in GSoC and elsewhere) is that the correlation between how
well we rate the student in the selection period and how it actually
goas afterwards is weak (or sometimes, there is a correlation, but with
a negative slope!).

Microprojects are a very good way to improve this correlation, and at
least to eliminate really bad students quickly. We had 11 proposals this
year, and we really discussed about 3 or 4 of them, others were
discarded early.

Microprojects also give students a taste of what "contributing to Git"
means. As a consequence, the "community bonding period" is essentially
useless: it's already done. As mentors, we did give a few advices to
Karthik during that period, but essentially on the way to manage his own
project, as he already knew the community.

>>  * I cannot say anything about mentor-student interactions, which
>>    are largely private.  Mentors may want to share tips to get
>>    students more engaged, or perhaps the level of engagement was
>>    primarily affected by who the students were.  I dunno.
>
> As a first time mentor, I sometimes had the feeling of not doing enough
> mentoring. Though maybe just because of less private student-mentor
> interaction the reviews came to the list earlier exposing the patches to
> a wider audience?

Actually, I think a good mentor-student relation is to avoid
mentor-student relation ;-).

On our side, we exchanged a few emails. We have a private thread with 29
emails, most of them very short. We did sometimes pre-review: add a few
comments on a draft on GitHub before sending to the list, to save other
reviewers some time on easy-to-catch mistakes, but the important
discussions were done on-list.

Quite often, the on-list consensus was proving my off-list remarks
wrong, but the time lapse between my incorrect statement and the
correction by the list was short, and thanks to this, not much time was
lost. Much better than spending the summer working on incorrect
statements or speculations on what the actual review will look like.

>>  * The topics chosen this year were well-sized, not overly nebulous.

Interestingly, both projects were essentially internal refactoring ones
(the one I mentored last year was, too). Nothing really impressive for
the end-user, but in both cases a substantial contribution to Git's
maintainability.

I'm positively surprised that students chose these topics. They are not
the best subjects to show off with your friends ("see this new command
you love so much, *I* implemented it!"), but are necessary work to make
the codebase healthier.

The tempting trap we avoided is the flashy project ending up with a very
impressive prototype that no one wants to maintain.

IOW, I think we decreased the technical debt of Git, while we gave into
the temptation of increasing it in the past.

>>  * The reviewers were helpful and probably more active than past
>>    years.

For Karthik (I didn't follow Paul enough to say), reviewers did a really
great job. Especially Junio and Eric, but many other helped too. I was
amazed by the amount of change from iteration to iteration.

I'd add one item:

* We limited the number of slots. A successful GSoC has to be a lot of
  work for many people (student, mentor, reviewer, maintainer). We have
  a limited bandwidth to deal with the GSoC, and I think that focusing
  on a small number of slots is a good strategy.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
