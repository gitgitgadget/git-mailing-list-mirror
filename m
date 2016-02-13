From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Sat, 13 Feb 2016 12:21:43 +0100
Message-ID: <vpqd1s04zzs.fsf@anie.imag.fr>
References: <vpqoabox66p.fsf@anie.imag.fr>
	<CAP8UFD0UxB6Z1UU=4Bkz0Yt2KE+AkrttQeTx2oY9v9O78f9qow@mail.gmail.com>
	<vpqd1s2e74l.fsf@anie.imag.fr>
	<20160212130446.GB10858@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 13 12:22:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUYHa-0000WH-Ek
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 12:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbcBMLWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2016 06:22:01 -0500
Received: from mx2.imag.fr ([129.88.30.17]:45135 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949AbcBMLV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2016 06:21:59 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1DBLgL3024594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sat, 13 Feb 2016 12:21:42 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1DBLh5H008673;
	Sat, 13 Feb 2016 12:21:43 +0100
In-Reply-To: <20160212130446.GB10858@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 12 Feb 2016 08:04:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 13 Feb 2016 12:21:43 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1DBLgL3024594
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1455967307.31548@MLTPooQ+qkxJYYrYXTk+wg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286108>

Jeff King <peff@peff.net> writes:

> On Fri, Feb 12, 2016 at 08:10:34AM +0100, Matthieu Moy wrote:
>
>> So, that makes it 4 possible co-mentors, i.e. 2 potential slots. Not
>> much, but it starts looking like last year ... ;-).
>> 
>> Peff, would you be willing to co-admin with me (that would be cool, you
>> are the one with most experience here and you know the SFC stuff for
>> payment)? Are there any other co-admin volunteer?
>
> Yes, I'm willing to co-admin (though I'm also happy to step aside for
> somebody else if they would like to do it).

Cool!

> The biggest task there is getting the application together. I went
> through the account creation steps at the site (which is different this
> year), and the application questions are:
>
>  - Why does your org want to participate in Google Summer of Code?
>
>  - How many potential mentors have agreed to mentor this year?
>
>  - How will you keep mentors engaged with their students?
>
>  - How will you help your students stay on schedule to complete their projects?
>
>  - How will you get your students involved in your community during GSoC?
>
>  - How will you keep students involved with your community after GSoC?
>
>  - Has your org been accepted as a mentoring org in Google Summer of Code before?
>
>  - Are you part of a foundation/umbrella organization?
>
>  - What year was your project started? 
>
> I think we can pull most of these answers from previous-year
> applications, but I haven't looked yet. In years past we collaborated
> on the answers via the git.github.io site, and I pasted them in place.

I started working on it.

http://git.github.io/SoC-2015-Org-Application/ => the application itself.
Mostly cut-and-paste from last year, but the questions have changed a
bit. There's a "Remarks on the current state of the application" section
at the end for stuff I wasn't sure about.

This is the urgent part, we won't have an opportunity to modify it after
the deadline.


Less urgent, but we need to add more stuff to be credible:

http://git.github.io/SoC-2016-Ideas/ => Ideas page. I removed the
completed project, and updated some other to reflect the current state
of Git. I think "Convert scripts to builtins" is still feasible this
year, but probably harder (we can't say "start with git-pull.sh"
anymore ...). Johannes: you're still interested I guess?

http://git.github.io/SoC-2016-Microprojects/ => I just did s/2015/2016/.
I think most projects are not valid anymore, and we need new ones.

To all: please contribute to these pages, either by sending patches here
(CC: me and peff), pushing directly if you have access, or submitting
pull-requests. The repo is https://github.com/git/git.github.io/.

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
