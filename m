From: David Kastrup <dak@gnu.org>
Subject: Re: Should git-remote-hg/bzr be part of the core?
Date: Mon, 12 May 2014 15:12:22 +0200
Message-ID: <87mwenuond.fsf@fencepost.gnu.org>
References: <537008f06ceb8_8e47492f89f@nysa.notmuch>
	<53709788.2050201@alum.mit.edu>
	<5370a47bee98c_139611a92fc29@nysa.notmuch>
	<5370B920.2060506@alum.mit.edu>
	<5370beb4b2483_168f13a72fc57@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	git-fc@googlegroups.com, Richard Hansen <rhansen@bbn.com>,
	Torsten =?iso-8859-1?Q?B=F6gershaus?= <tboegi@web.de>,
	Antoine Pelisse <apelisse@gmail.com>,
	Christophe Simonis <christophe@kn.gl>,
	Dusty Phillips <dusty@linux.ca>, Jeff King <peff@peff.net>,
	John Keeping <john@keeping.me.uk>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 15:12:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wjq1u-0000D9-1w
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 15:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758246AbaELNM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 09:12:26 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:45432 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758212AbaELNMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 09:12:25 -0400
Received: from localhost ([127.0.0.1]:44466 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1Wjq1m-000794-F3; Mon, 12 May 2014 09:12:22 -0400
Received: by lola (Postfix, from userid 1000)
	id 22697E0F4F; Mon, 12 May 2014 15:12:22 +0200 (CEST)
In-Reply-To: <5370beb4b2483_168f13a72fc57@nysa.notmuch> (Felipe Contreras's
	message of "Mon, 12 May 2014 07:29:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248706>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Michael Haggerty wrote:
>> On 05/12/2014 12:37 PM, Felipe Contreras wrote:
>> > Michael Haggerty wrote:
>> >> On 05/12/2014 01:34 AM, Felipe Contreras wrote:
>> >>> Recently Junio said he was willing to hear the opinion of other people
>> >>> regarding the move from contrib to the core[1]. This move is already
>> >>> under way, but suddenly Junio changed his mind.
>> >>
>> >> I agree with Junio.  There are good technical arguments for and against
>> >> moving git-remote-hg out of contrib.
>> > 
>> > Saying you agree with Junio is content-free. You have to say *why* you
>> > agree.
>> 
>> Actually, I don't have to,
>
> Then there's no point in reading what else you have to say. Whatever
> reasons you might have to agree with Junio are known only to you, thus
> your "agreement" is opaque and meaningless.

Let me spell it out for you.  Michael states "I agree with Junio.  There
are good technical arguments for and against moving git-remote-hg out of
contrib."  Since there are arguments for both sides, the decision boils
down to a judgment call.  Michael states that he condones the choice
Junio made, based on the reasoning he gave.

Does that mean that he examined the choice with equal detail and
remembers every detail?  No.  In such a decision, both technical
expertise as well as trust based on a past record factor in.

>> > The quality of the subjproject has not been called into question,
>> > stop taiting the discussion with red herrings.
>> 
>> On the contrary.  I just called the quality of the subproject into
>> question, and I stated exactly which aspects of its quality I find to
>> be inadequate in the text that you omitted from your response:
>
> I'll wait until somebody else calls into question the quality.
> Preferably somebody who backs up his claims with evidence.

The evidence for the toxicity of dealing with subprojects maintained by
you is all over the mailing list.

You are obviously blind to it yourself.  Feel free to print out a few
salient threads where you argue in favor of your points and ask someone
you trust about his impression about how you come across.

>> > Let's see how sincere you are in your sentiment. I'll reply to you
>> > personally about the points that I consider to be red herrings and
>> > ad hominem attacks so we don't taint the dicussion. If you don't
>> > reply I'll know you were not being sincere.
>> 
>> Jumping at your every demand is not a prerequisite for being sincere.
>
> I spent a lot of time writing that mail. Not sincere it is then.

That kind of exchange is what you should show some of your personal
friends and ask them whether it will likely lead to the desired
understanding and ultimately reaction in the reader.

Because that is what communication is about.  Of course, one can try
bypassing understanding and directly aim for a particular reaction: that
is being manipulative.  You are hardly in danger of being manipulative:
that would require a basic understanding of people.  So all you can
really aim for is understanding: presenting your best case.  Forget
about "rhetorics" and the like: you suck at them, and a technical
audience is easily annoyed by them even when they are employed well.

And if a calm presentation does not lead others to the same conclusion
that you would draw, deal with the consequences.  Throwing tantrums will
only bias people against you when you have the next case to present.

-- 
David Kastrup
