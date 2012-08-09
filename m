From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: The GitTogether
Date: Thu, 09 Aug 2012 18:38:22 +0200
Message-ID: <5023E77E.4020604@drmicha.warpmail.net>
References: <CAP2yMaJzJyw=9DqJzUXkkQjz_jcqB4pH=FfHFRiftC9=yC7dvg@mail.gmail.com> <87k3xpe8bz.fsf@thomas.inf.ethz.ch> <50155CD9.6060702@web.de> <5016894C.7020907@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu Aug 09 18:38:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzVkl-0002hs-HM
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 18:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758672Ab2HIQi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 12:38:26 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:59626 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755949Ab2HIQiZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Aug 2012 12:38:25 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id B312020A9D;
	Thu,  9 Aug 2012 12:38:24 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 09 Aug 2012 12:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=svUHW4rGOjUuh59OcR+i+P
	h5Xco=; b=Hz2tjhlaZsYmM+lmg5qoOIaK1ZtZWh24kd7tPuE0s+l+bt9rIlne/X
	AeeuMAO2hZzkwO52B2MJbSlG/uBSqAIUiGBaMvgcewdt4pM5vTBDZvcF8HRuM1RU
	2VlMXVuXGY5oqmM1Mj5bYthUMU+QmTSm+ppsiLmUJnSyqg2b1s33A=
X-Sasl-enc: 2AR2B26GNn3kXVxKwAQ9TB+6oTSzAUdgyKRqIBo2JQbc 1344530304
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 9970E8E020C;
	Thu,  9 Aug 2012 12:38:23 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120717 Thunderbird/14.0
In-Reply-To: <5016894C.7020907@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203165>

Michael J Gruber venit, vidit, dixit 30.07.2012 15:17:
> Jens Lehmann venit, vidit, dixit 29.07.2012 17:55:
>> Am 27.07.2012 13:45, schrieb Thomas Rast:
>>> Scott Chacon <schacon@gmail.com> writes:
>>>
>>>> GitHub would like to volunteer to organize and pay for these events
>>>> this year.  I would like to hold the developer-centric one in Berlin
>>>> in early October
> 
> Winter term classes start 10/15. Before 10/15 it will be easier to book
> university rooms if we need that.
> 
>>>
>>> Yay, Berlin!  I would be glad to join there; I would probably not have
>>> the time and resources to travel to SF this year.
>>
>> Same here.
> 
> Same.
> 
> Do we have contacts regarding (un)conference rooms in Berlin already? I
> might be able to ask around.
> 
>>
>>>> For those of you who *have* been to a GitTogether, what did you find
>>>> useful and/or useless about it?  What did you get out of it and would
>>>> like to see again?  For those of you who have never been, what do you
>>>> think would be useful?  I was thinking for both of them to have a
>>>> combination of short prepared talks, lightning/unconference style
>>>> talks and general discussion / breakout sessions.
>>>
>>> I was at the 2010 GitTogether in Mountain View.  I really liked the
>>> unconference format, and the way Shawn and Junio used it: just using the
>>> topic stickers as a sort of todo-list, not actually fixing any schedule
>>> in advance.  Oddly enough we also managed to avoid the usual consequence
>>> of open-ended discussions: getting stuck endlessly on an absolutely
>>> insignificant point.
>>
>> Yup, the unconference format with both common and breakout sessions
>> worked really well.
>>
>>> I think the discussions were very productive.  I would love to do more
>>> hacking than we managed in 2010, but I realize that this is not possible
>>> if we just meet for 2-3 days.  Perhaps one option would be to plan for
>>> 1-2 days of hacking after the discussion rounds, so that the interested
>>> people can stay a bit longer?
>>
>> I really like that idea and would vote for 3-4 days (maybe including a
>> weekend for those of us who have to take a leave from work ;-).

While the unconference format is successful, may I suggest a
track/topic: Especially if there's GitHub support and participation this
would be a good opportunity to discuss some GitHub specific issues in
person rather than via the list or support tickets. Two come to my mind:

1) GitHub for Git developers: I certainly don't suggest a change in
workflow for git.git, but you often hear Git developers say "we can't do
this or that on GitHub", and I think GitHub (and other projects using
GitHub) could benefit from the specific point of view and input of Git
developers to improve workflow support on GitHub.

2) git-scm.com: The old Git website and wiki certainly did not quite
meet GitHub's demands (e.g. reliability, looks), and git-scm.com
certainly does not quite meet the/all Git developers demands (e.g. list
discussion based decisions and actions, separation between the "free
project" and "business related content). In person it may be easier to
find a way forward which benefits all parts of the large and undefined
"Git community".

Cheers,
Michael
