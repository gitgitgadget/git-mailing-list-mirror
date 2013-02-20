From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Wed, 20 Feb 2013 13:26:38 +0100
Message-ID: <vpqip5nb281.fsf@grenoble-inp.fr>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
	<20130218174239.GB22832@sigill.intra.peff.net>
	<CAJo=hJvknVedGba5OxjjvZi2=JZyDuDoP2tD+LKQKdZNJ4NcsA@mail.gmail.com>
	<CAP8UFD01bUgUz1LST6DPjhQ4qsNEA4-ndpLQ97XqH_fOEdew9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Shawn Pearce <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@inf.ethz.ch>, git <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 13:28:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U88n5-0002dt-0p
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 13:28:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935298Ab3BTM21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 07:28:27 -0500
Received: from mx2.imag.fr ([129.88.30.17]:59016 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934845Ab3BTM20 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 07:28:26 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r1KCQb4V022489
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 20 Feb 2013 13:26:37 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U88kw-0006ux-Gu; Wed, 20 Feb 2013 13:26:38 +0100
In-Reply-To: <CAP8UFD01bUgUz1LST6DPjhQ4qsNEA4-ndpLQ97XqH_fOEdew9w@mail.gmail.com>
	(Christian Couder's message of "Wed, 20 Feb 2013 13:07:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 20 Feb 2013 13:26:39 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r1KCQb4V022489
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1361968001.07541@URiAMU2rv4hepeO6Ohr14A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216704>

Christian Couder <christian.couder@gmail.com> writes:

> - yes, we could improve mentoring by providing better projects and
> insisting even more on submitting earlier

A few words about my experience, not with GSoC, but with school projects
(I've been proposing a few students in Ensimag to contribute to Git each
year since 2010).

Last year, we've been using Scrum, and the "definition of done" was a
very helpful tool. In Scrum, nothing is ever "half done", it is either
"done" or "not done". Out of a 3 weeks project, the definition of done
was initially "ready to be sent to the list", then "sent to the list, no
major criticism in reviews" the second week, and "sent to the list, no
more objections in reviews" the last week. At the beginning of each week
("sprint" in Scrum), students were commiting to a list of tasks, and at
the end of each week, we evaluated how many were done. This encouraged
students to avoid overcommiting and send patches early. Some of them
validated nothing at all the first week: they hadn't realized the
distance between their notion of clean working code and the one on this
list, but at least they realized it early enough.

Of course, even with that, I had to continue the work to push it to
master for some patch series, and discard some series that were
basically not there.

Having several small projects instead of one big was very important. I'm
not sure how the GSoC would feel about a list of small tasks instead of
one ambitious project however.

My main disappointment is that I never managed to keep students in the
community past the end of the project.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
