Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71B281F463
	for <e@80x24.org>; Wed, 25 Sep 2019 15:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732613AbfIYPai (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 11:30:38 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:14503 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727563AbfIYPai (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 11:30:38 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iD9FT-00059G-3n; Wed, 25 Sep 2019 16:30:35 +0100
Subject: Re: Bi-Weekly Standup - Time/timezone in calendar?
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <a56e5ebe-53ba-5f20-5606-b4b17dc660b5@iee.email>
 <20190925143247.GD11444@cat>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <dfa01a78-c45e-4466-5232-6aae389082ca@iee.email>
Date:   Wed, 25 Sep 2019 16:30:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190925143247.GD11444@cat>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/09/2019 15:32, Thomas Gummerer wrote:
> On 09/25, Philip Oakley wrote:
>> Hi,
>>
>> At the Virtual Git Contributors Summit we discussed (#13) the bi-weekly
>> standup meetings (mentioned in the Git Rev News edition 55 under
>> 'News/Various').
>>
>> The Git Events calendar [1] that's linked from the Rev News doesn't actually
>> say what time zone to use for the stand-up start time, so at first glance
>> one can get confused by summer time and national time zone differences.
>>
>> Currently it's saying (when clicked on, via 'more details')
>>
>> Git Standup
>> Monday, September 30⋅6:00 – 7:00pm
>> Every 2 weeks on Monday
>>
>> I thought it was to be 1700 UTC, which currently is 1800 BST her in UK, and
>> 1900 CST in Europe.
> That's my recollection as well, and what the calendar should say.
> Thanks for flagging this!
>
>> If I hover over the event (have to restart the calendar), I (depending on
>> view) do get an indicator in the lower left status bar that
>> "Events shown in time zone: Coordinated Universal Time". but with a 5pm
>> indication in the calendar sheet.
>>
>> Is this google calendar trying to be too clever, or should "1700 UTC" be
>> included in the event details? I don't use Google calendar except for
>> occasional reference.
> Yeah, I think the embed view of the Google Calendar is trying to be
> too clever here.  I did set the event up to be at 17:00 UTC, and I'm
> not sure why it showed up otherwise for you.
>
> I have now updated the event with a few more details, including that
> it is happening at 17:00 UTC, and added that information to the title
> as well.  Hope that helps!
Looks a lot better, especially if one clicks and selects the 'more 
details' option (which changes to local TZ)

> Also replying to your last question in https://github.com/git/git.github.io/issues/394#issuecomment-535030810:
>
>> Also given Dscho's comment at the summit about late evenings, are we
>> changing the time for those dark winter nights soon to come (N
>> Hemisphere)?
> I don't know.  I'd be happy to keep it at 17:00 UTC, but that might be
> a bit early for folks living on the west coast.  I don't have a strong
> opinion on this, but I'm happy to update the calendar (or not
> depending on what we decide) once the decision is made.

Once everyone changed from daylight saving, then changing to local clock 
is likely (unless we have a few southern hemisphere dst folks going the 
other way! James Ramsay?)

>> Philip
>>
>>
>> [1] https://calendar.google.com/calendar/embed?src=nk8ph2kh4p5tgfcctb8i7dm6d4%40group.calendar.google.com
>>

