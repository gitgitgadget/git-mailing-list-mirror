From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [ANNOUNCE] Git Merge Contributors Summit, April 8th, Paris
Date: Fri, 06 Mar 2015 11:52:06 +0100
Message-ID: <54F986D6.5000607@drmicha.warpmail.net>
References: <20150224220923.GA23344@peff.net>	<CAP8UFD27xaJU3QFuQZqADmh=ZseiN=Y1WCFPk4v4RzizK=2Xtg@mail.gmail.com> <xmqqlhjb13s3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	git@sfconservancy.org
To: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 11:52:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTprt-00038h-Gh
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 11:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303AbbCFKw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 05:52:28 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:53378 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934292AbbCFKwK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2015 05:52:10 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 03833207AF
	for <git@vger.kernel.org>; Fri,  6 Mar 2015 05:52:07 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Fri, 06 Mar 2015 05:52:09 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=atweqqXIQyIpDYll3U6s2S
	aksXg=; b=uMvJF8SYR6yJB3bsEbY5T9jHyWtBkojS0VVh6F9gWELfyAeGKPehV5
	ZANL3S2pEzhgR7i/sunlOpYnJxuzm2C+1lwr5WwI1gNN5IjWsqjevogqeCKaMp0i
	90E5hkutfu3TPQZDlwdvDW29DjWNAyl0OdzckpIM/tvUJnG3yV/Do=
X-Sasl-enc: Fyocd5AjU7Yx0uHM69WfiNIAikroAMcTcE6u81SxoOMA 1425639128
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id C9F8C6800F3;
	Fri,  6 Mar 2015 05:52:07 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqqlhjb13s3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264909>

Junio C Hamano venit, vidit, dixit 05.03.2015 23:24:
> Christian Couder <christian.couder@gmail.com> writes:
> 
>> On Tue, Feb 24, 2015 at 11:09 PM, Jeff King <peff@peff.net> wrote:
>>> I wanted to make one more announcement about this, since a few more
>>> details have been posted at:
>>>
>>>   http://git-merge.com/
>>>
>>> since my last announcement. Specifically, I wanted to call attention to
>>> the contributor's summit on the 8th. Basically, there will be a space
>>> that can hold up to 50 people, it's open only to git (and JGit and
>>> libgit2) devs, and there isn't a planned agenda. So I want to:
>>>
>>>   1. Encourage developers to come. You might meet some folks in person
>>> ...
>>>   2. Get people thinking about what they would like to talk about.  In
>>> ...
>>> If you are a git dev and want to come, please RSVP to Chris Kelly
>>> <amateurhuman@github.com> who is organizing the event. If you would like
>>> to come, but finances make it hard (either for travel, or for the
>>> conference fee), please talk to me off-list, and we may be able to help.
>>
>> I'd like the Git project to set up a more organized way to pay back
>> the travel costs and the conference fee to the developers who come.
>> For example the Git project could say that it will at least pay back:
>>
>> - all the travel costs to the 5 most important Git developers who come and ask,
>> - half the travel costs to the 5 next most important Git developers
>> who come and ask,
>> - all the conference fee to the 15 most important Git developers who
>> come and ask,
>>
>> I think it could help developers decide to come, and it looks like
>> enough funding could be available, thanks to GitHub and the GSoC
>> money. What do you think?
> 
> I personally perfer things to be kept informal---it would keep
> things simpler for everybody.  You do not have to wonder what you
> should do when you think you are among the five most important
> people and you also know your employer will pay for the conference
> if you asked, for example.
> 
> It feels to me that the suggestion Peff gave in his announce to ask
> privately for case-by-case arrangement strikes the balance much
> better.
> 
>> Apart from that it's also possible to find ways to accommodate some
>> developers for free, if they don't mind crashing in someone's spare
>> room.
>>
>> So please don't hesitate to ask if you would like to come.
> 
> These five lines, by not explicitly saying something like "the first
> 2 people who ask can crash in Christian's spare bedroom", is doing
> exactly the same thing as Peff did by saying "please talk to me
> off-list", it seems to me at least.  Both keep things informal and
> simple, and both arrange things on case-by-case basis as needed.
> 
> And I think that is better than setting a seemingly hard rules
> upfront, and causing more problems unnecessarily (e.g. who decides
> who are the 5 most important, for example?).

Oh yes, that would be an interesting metric to define...

OTOH I can see where Christian's question is coming from:
Who is even supposed to ask for support? Not just as in "who is a
developer", but also "what are finance hardships":

At scientific conferences which I'm going to, there is often "support
for those who need it", and that typically means participants from "less
fortunate countries" (to avoid the usual world-counting term). Everyone
else is expected to be covered by their academic employer - and if not,
it's not even okay to ask the organisers. I guess that's what some of us
are having in mind.

That still leaves the question:
Is there any space left in Christian's spare bedroom? :)

Michael
