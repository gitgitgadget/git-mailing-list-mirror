From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git (stable)
Date: Tue, 26 Dec 2006 18:14:24 -0800
Message-ID: <7vslf2axvj.fsf@assigned-by-dhcp.cox.net>
References: <368927.59162.qm@web31804.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 27 03:14:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzOJJ-0000Nc-TC
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 03:14:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932890AbWL0CO0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Dec 2006 21:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932892AbWL0CO0
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Dec 2006 21:14:26 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:52833 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932890AbWL0CO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Dec 2006 21:14:26 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061227021425.LAYI25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Tue, 26 Dec 2006 21:14:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3eEe1W00h1kojtg0000000; Tue, 26 Dec 2006 21:14:39 -0500
To: ltuikov@yahoo.com
In-Reply-To: <368927.59162.qm@web31804.mail.mud.yahoo.com> (Luben Tuikov's
	message of "Tue, 26 Dec 2006 17:19:03 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35443>

Luben Tuikov <ltuikov@yahoo.com> writes:

> --- Junio C Hamano <junkio@cox.net> wrote:
>> Luben Tuikov <ltuikov@yahoo.com> writes:
>> 
>> >> I am not quite sure about that.  An old timer would work in a
>> >> newly cloned repository after all, and what this "newbie
>> >> protection" is breaking is not existing repositories but
>> >> expectation from existing users.
>> >
>> > Hmm, "newbie protection" doesn't sound good.  It sounds like
>> > "screw the old-timers and let's change well-established workflow".
>> 
>> As far as I am concerned, this is a topic already closed four
>> days ago with commit fb8696d9.
>> 
>> Are you way too behind, are you rubbing it in, or am I
>> hallucinating and fb8696d9 did not actually fix it?
>
> I'm behind.  I'll pull and take a look at that commit.

Thanks.

And sorry that I sounded harsher than necessary.  Between the
two paragraphs, I meant to say "... with commit fb8696d9.  It
was a mistake, I broke existing workflows, I apologized, and the
commit should have fixed it".
