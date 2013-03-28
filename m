From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Git and GSoC 2013
Date: Thu, 28 Mar 2013 21:39:23 +0100
Message-ID: <CAP8UFD2jPSpAQQJC1sUtd5ztnMB=kou36HZUaoPOG4ht-Sj8wg@mail.gmail.com>
References: <20130327183410.GA26066@sigill.intra.peff.net>
	<20130327185248.GE28148@google.com>
	<CAP8UFD1CjfJ8wM-htX8SOOveAt8zQ+qBRk_P016Y57jWnt6sCw@mail.gmail.com>
	<7vtxnvv5gx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 21:39:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULJc0-0002wp-P1
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 21:39:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712Ab3C1UjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 16:39:24 -0400
Received: from mail-ve0-f176.google.com ([209.85.128.176]:56116 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893Ab3C1UjY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 16:39:24 -0400
Received: by mail-ve0-f176.google.com with SMTP id ox1so3992175veb.35
        for <git@vger.kernel.org>; Thu, 28 Mar 2013 13:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=F0XdAM2TQp1YuIVmoOyXu21Z2BOQzMgu/SyQjdgzdUE=;
        b=vIVZrrv/8j1/XGINnjeCLEwH5FqyIRNJD4pHkK0Ih352DXfGTMIJtBAGEw9ZR3FJ1F
         yizH0hIn6FzkTZgwVTfqLJpIXalUqJkW4U/EUeNbS7j8qX2QsQ0gdMHYSLHu1NpMLpuP
         QUQ9/+FwAnlCHsb0eAjbWz4T9rGtMaXI/k8+REmgVaYGtb2mE8YaR4fm7jbMApIIeW1C
         9cm83b2w9yqc9PqciO0rahZb5e2/WQ04FqmJRTf4aSn9bP+MoTW2AXjlJa6bYo3rG7oJ
         hAUIObEeoJqLhdYxJWaWkw78bXz56hJL6Vq7vAOthiEliENdmMPxfnDL5YHmdCiTA/2X
         59ag==
X-Received: by 10.52.231.1 with SMTP id tc1mr32484vdc.39.1364503163198; Thu,
 28 Mar 2013 13:39:23 -0700 (PDT)
Received: by 10.58.120.97 with HTTP; Thu, 28 Mar 2013 13:39:23 -0700 (PDT)
In-Reply-To: <7vtxnvv5gx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219459>

On Thu, Mar 28, 2013 at 5:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> On Wed, Mar 27, 2013 at 7:52 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>> Jeff King wrote:
>>>
>>>> There was a big thread about a month ago on whether Git should do Google
>>>> Summer of Code this year[1].
>>
>> I think we should do it.
>>
>> It looks strange to me to say that students are great and at the same
>> time that we should not do it.
>>
>> Let's give them and us one more chance do to well. This is the only
>> way we can improve.
>
> Do you mean we should be doing the same thing over and over again
> and expecting different results?  Einstein may not like it, and I
> certainly don't.

No, I don't mean we should be doing the same. I agree that smaller
projects are helpful and insisting on submitting right away on the
mailing list is helpful.
But if we don't even try we have no chance to see if it works. We just
lose time.

> What I gathered from the discussion so far is that everybody agrees
> that our mentoring has been suboptimal in various ways (not enough
> encouragement to engage with the community early, working in the
> cave for too long, biting too much to chew etc.).  What makes you
> think we would do better this year?

The fact that we will be more conscious that we need smaller projects
and that we need to push even more for students to send their patch
soon on the mailing list.

If it doesn't work at all we will be set and we will know that there
is not much we can do to make it work.

If we don't even try we will not know soon, so not be able to improve
or decide to stop.

It's like software or science. If you don't test soon your hypothesis
you don't progress fast.

Or do you think we just stand no chance to progress?

By the way we say that students should post soon to the mailing list
to get a feedback soon, but it looks like we don't want to try our
hypothesis around mentoring as soon as we can.
Doesn't it sound strange to you? Aren't we saying "do as I say not as I do"?

> "We have a track record of being not great at mentoring, and we
> haven't made an effort to improve it." is a perfectly valid and
> humble reason to excuse ourselves from this year's GSoC.

It is also a perfectly valid justification to decide to make an effort
to improve our mentoring and to try again.

> "Students are great" is immaterial.

"We are not great at mentoring" is as much immaterial.

> In fact, if they are great, I think it is better to give them a
> chance to excel by working with organizations that can mentor them
> better, instead of squandering their time and GSoC's money for
> another failure, until _we_ are ready to take great students.

How do we know we are ready if we don't try?

By waiting we just lose the experience we already have, because some
mentors might not be around next year, or they will not remember well
about the process.

And some organizations that will perhaps be accepted, if we decide not
to do it, might have no mentoring experience at all. How do you know
they will mentor students better than what we have been doing?

Best regards,
Christian.
