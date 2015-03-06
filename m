From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [ANNOUNCE] Git Merge Contributors Summit, April 8th, Paris
Date: Fri, 6 Mar 2015 13:55:02 +0100
Message-ID: <CAP8UFD2qGBPiNaDmx1OELM45TZqSqKkHZkdVOqupWKKxPxbvOw@mail.gmail.com>
References: <20150224220923.GA23344@peff.net>
	<CAP8UFD27xaJU3QFuQZqADmh=ZseiN=Y1WCFPk4v4RzizK=2Xtg@mail.gmail.com>
	<xmqqlhjb13s3.fsf@gitster.dls.corp.google.com>
	<54F986D6.5000607@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git <git@vger.kernel.org>, git@sfconservancy.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 06 13:55:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTrmX-0001h0-3d
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 13:55:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057AbbCFMzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 07:55:04 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:33382 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbbCFMzD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 07:55:03 -0500
Received: by igbhl2 with SMTP id hl2so3313482igb.0
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 04:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tEf6cYJIo1QmDgZuuHWa5bcN6Ov0uzaKQ1suPwXRcdk=;
        b=FriefAqe609B64AEtHrL9y62M6hjNpL9NvygzTLOBmSR9O5vN2Qfl0xNri6L/N4T6c
         7M24pnWVUIm268FD4sleA7+RQHC6CpmHGE96d2fV/0e2qqDHtJYXuEX6bbMLebTDioM/
         1X+eHEgeOxoZwedgEEI0SLE51RGzmwLNFUAT8G95YbZUeHm9uw9hvAi6poeBZhoScv1V
         gxzEYLmxbLiiuQgPd9gxTUw8hlvtJ1JmtcxJOk4oldtUfU7Uc4Af5G/CAfCt5hx/FmPx
         7j6PNFRW9bwrMYc+RbFOcv2xgUQ/wFGFXpmHIT5FHeKBxGc1XLYcXqLes5AdpYatFOQb
         mWFA==
X-Received: by 10.42.76.6 with SMTP id c6mr9705614ick.52.1425646502537; Fri,
 06 Mar 2015 04:55:02 -0800 (PST)
Received: by 10.50.245.144 with HTTP; Fri, 6 Mar 2015 04:55:02 -0800 (PST)
In-Reply-To: <54F986D6.5000607@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264920>

On Fri, Mar 6, 2015 at 11:52 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Junio C Hamano venit, vidit, dixit 05.03.2015 23:24:
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>>>
>>> I'd like the Git project to set up a more organized way to pay back
>>> the travel costs and the conference fee to the developers who come.
>>> For example the Git project could say that it will at least pay back:
>>>
>>> - all the travel costs to the 5 most important Git developers who come and ask,
>>> - half the travel costs to the 5 next most important Git developers
>>> who come and ask,
>>> - all the conference fee to the 15 most important Git developers who
>>> come and ask,
>>>
>>> I think it could help developers decide to come, and it looks like
>>> enough funding could be available, thanks to GitHub and the GSoC
>>> money. What do you think?
>>
>> I personally perfer things to be kept informal---it would keep
>> things simpler for everybody.  You do not have to wonder what you
>> should do when you think you are among the five most important
>> people and you also know your employer will pay for the conference
>> if you asked, for example.
>>
>> It feels to me that the suggestion Peff gave in his announce to ask
>> privately for case-by-case arrangement strikes the balance much
>> better.
>>
>>> Apart from that it's also possible to find ways to accommodate some
>>> developers for free, if they don't mind crashing in someone's spare
>>> room.
>>>
>>> So please don't hesitate to ask if you would like to come.
>>
>> These five lines, by not explicitly saying something like "the first
>> 2 people who ask can crash in Christian's spare bedroom", is doing
>> exactly the same thing as Peff did by saying "please talk to me
>> off-list", it seems to me at least.  Both keep things informal and
>> simple, and both arrange things on case-by-case basis as needed.
>>
>> And I think that is better than setting a seemingly hard rules
>> upfront, and causing more problems unnecessarily (e.g. who decides
>> who are the 5 most important, for example?).
>
> Oh yes, that would be an interesting metric to define...
>
> OTOH I can see where Christian's question is coming from:
> Who is even supposed to ask for support? Not just as in "who is a
> developer", but also "what are finance hardships":
>
> At scientific conferences which I'm going to, there is often "support
> for those who need it", and that typically means participants from "less
> fortunate countries" (to avoid the usual world-counting term). Everyone
> else is expected to be covered by their academic employer - and if not,
> it's not even okay to ask the organisers. I guess that's what some of us
> are having in mind.

I had more in mind the people who mentored GSoC students (and this way
helped the Git project get some money) and the 200 or so developers
who contributed between 10 and 50 patches, though I agree it could
also be useful for others too. As far as I know very few people have
asked for funding and it would be sad that people don't come because
they think they would not be payed back the costs when in fact they
would.

> That still leaves the question:
> Is there any space left in Christian's spare bedroom? :)

Yes, no one as asked yet, so I shoud be able to accommodate you if you want :-)

See you soon,
Christian.
