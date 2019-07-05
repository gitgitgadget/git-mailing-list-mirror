Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47EAE1F461
	for <e@80x24.org>; Fri,  5 Jul 2019 14:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfGEOJI (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 10:09:08 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:46005 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfGEOJI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 10:09:08 -0400
Received: from [192.168.1.22] ([89.243.190.203])
        by smtp.talktalk.net with SMTP
        id jOtdhARR7nuQZjOtdhmloE; Fri, 05 Jul 2019 15:09:06 +0100
X-Originating-IP: [89.243.190.203]
X-Spam: 0
X-OAuthority: v=2.3 cv=echDgIMH c=1 sm=1 tr=0 a=eLyEXkeXgyqjrUSteAL3aw==:117
 a=eLyEXkeXgyqjrUSteAL3aw==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=zrx41NgC3UInodjT9p4A:9 a=ZnI8S_KZ4Zjj3iZl:21
 a=ydX6-rsLYsO2Doo1:21 a=QEXdDO2ut3YA:10
Subject: Re: Virtual Git Contributor Summit
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
References: <nycvar.QRO.7.76.6.1907031429420.44@tvgsbejvaqbjf.bet>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <e7f2393a-0eb3-ad3e-4e0c-0500b974e3c5@iee.org>
Date:   Fri, 5 Jul 2019 15:09:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1907031429420.44@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfPbhFtIRsdQzotJJKacUkYIs42UfclONM4Ge/gRvpUhOB96irLJb8BGT8CC9R6HQBemo+FHuWDWhZfcftLyVhJ8lLf2dE/56Ctv9jk02HjecgZ/xA19F
 Juc+KL/ArQAQyphIex0Ajecyjt1ZYUAS9eZsOIyied0Vc6/b6NiImT3A2btY8Y0CiToMZ6y+At0luP6YwIINdjZWorVV3A3Y7As=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On 03/07/2019 14:01, Johannes Schindelin wrote:
> Team,
>
> I kept talking about this idea of a purely online Git Contributor Summit,
> and it is finally time for action.
>
> The idea: just like the Git Contributor Summits we have on the day before
> GitMerge, but instead of traveling to the same place, we'll use an online
> conferencing system.
>
>  From my point of view, the main benefits of doing this online are:
>
> - It should make it easier for all contributors to attend (yes, Junio, we
>    do miss you every single time you're not there).
>
> - We will leave a substantially reduced carbon footprint.
>
> - There won't be any jet-lag involved, including the consequences on
>    health/sleeping.
>
> - It is substantially cheaper and more sustainable.
>
> Of course, there are also some challenges:
>
> - Timezones. My idea here is to have all participants put down their
>    preferred timezone and then compromising on some sort of Median.
>
> - Timing. As it is not attached to a conference, we are less bound to a
>    specific date, and that flexibility might make it harder to agree
>    on one date.
>
> To alleviate both of those points, we might want to consider spreading it
> out over a couple of days? I already heard some fierce opposition against
> that idea, though.
>
> In any case, I think it would be good to give everybody some time to
> coordinate and to shift work out of the way, so I propose that we look for
> dates in the first two weeks of September.
>
> Peff kindly agreed to use GitHub's Zoom license for this, which should
> also make it easy to have a recording (and not having people in the same
> room will benefit this, too).
>
> To coordinate this event, I started a Google Spreadsheet where we can
> decide on timezone, date(s), number of days, and later on try to imitate
> the sticky game with virtual stickies for the discussions.
>
> I will send out an invitation to the top 25 contributors (according to
> `git shortlog -nse --since=1.year.ago`) after sending out this mail.
>
> Obviously, there will be more people interested in participating; Please
> do drop me an email if you're interested and I will send you a link to
> that spreadsheet (as I do not read my mails continuously, it might take a
> day, but I will, promise).
>
> Thanks all,
> Dscho

Will there also be an opportunity for a listen/read -only mode for those 
of us on the lower reaches of the contributor list? I'd certainly like 
to at least keep up with progress.
--
Philip
