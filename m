Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B4601FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 19:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756322AbeAHTPM (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 14:15:12 -0500
Received: from mut-mta1-se01a-zose1-fr.yulpa.io ([185.49.21.248]:59034 "EHLO
        mut-mta1-se01a-zose1-fr.yulpa.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755580AbeAHTPK (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 8 Jan 2018 14:15:10 -0500
X-Greylist: delayed 1734 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Jan 2018 14:15:10 EST
Received: from zose-mx-out01.web4all.fr ([185.49.20.46] helo=zose-mta-hub-out-web-01.w4a.fr)
        by mut-mta1-se01b-fr.yulpa.io with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <matthieu.moy@matthieu-moy.fr>)
        id 1eYcR3-000AJj-OL; Mon, 08 Jan 2018 19:46:14 +0100
Received: from localhost (localhost [127.0.0.1])
        by zose-mta-hub-out-web-01.w4a.fr (Postfix) with ESMTP id C6AEB1C0E49;
        Mon,  8 Jan 2018 19:45:02 +0100 (CET)
Received: from zose-mta-hub-out-web-01.w4a.fr ([127.0.0.1])
        by localhost (zose-mta-hub-out-web-01.w4a.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id dieKD1CH_8Vh; Mon,  8 Jan 2018 19:45:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zose-mta-hub-out-web-01.w4a.fr (Postfix) with ESMTP id 4CCF71C11C1;
        Mon,  8 Jan 2018 19:45:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at zose1.web4all.fr
Received: from zose-mta-hub-out-web-01.w4a.fr ([127.0.0.1])
        by localhost (zose-mta-hub-out-web-01.w4a.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wlyYYys_zykQ; Mon,  8 Jan 2018 19:45:02 +0100 (CET)
Received: from zose-store11.web4all.fr (zose-store11.web4all.fr [10.101.13.41])
        by zose-mta-hub-out-web-01.w4a.fr (Postfix) with ESMTP id 27EF71C0E49;
        Mon,  8 Jan 2018 19:45:01 +0100 (CET)
Date:   Mon, 8 Jan 2018 19:46:12 +0100 (CET)
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Message-ID: <719818385.221348.1515437172473.JavaMail.zimbra@matthieu-moy.fr>
In-Reply-To: <CAP8UFD06ZThD=FiccGrYLKpJz6R8NAUzFzMv+zrD4MisfJSbTw@mail.gmail.com>
References: <q7h9lghcob2s.fsf@orange.lip.ens-lyon.fr> <alpine.DEB.2.21.1.1801051217190.31@MININT-6BKU6QN.europe.corp.microsoft.com> <CAP8UFD06ZThD=FiccGrYLKpJz6R8NAUzFzMv+zrD4MisfJSbTw@mail.gmail.com>
Subject: Re: GSoC 2018 Org applications. Deadline = January 23, 2018 at
 18:00 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - FF57 (Linux)/8.7.11_GA_1854)
Thread-Topic: GSoC 2018 Org applications. Deadline = January 23, 2018 at 18:00 (CET)
Thread-Index: uEZ3KJ5nxWPFYKc4fNuKncZMgjQ67g==
X-Originating-IP: 185.49.20.46
X-SpamExperts-Domain: zose1.web4all.fr
X-SpamExperts-Username: 185.49.20.46
Authentication-Results: yulpa.io; auth=pass smtp.auth=185.49.20.46@zose1.web4all.fr
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.09)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5tC0UK+5EXaq1S8U2UVv133j1g3/PwYZaTCzSym8uE9HUitjeSUZ7skk
 CYNDj+2RlWWBUnGywMKq3X5xeLzyrXCYMXdDJbl0zJISHuDpYUgBxny7zX4LRTl3KRxPycYW83X5
 yLBTaqi03Bto7MR+NwLpBaOnOAr02oY8SqCWeLmuBzwVO1OZSLMG0J+7Ys8oDE2agB+cMuwrT2m5
 dvKphnwEybI1sOftHmSKUCHCvcq0+97CL41XDezwBoE7d4v3GrEFXogYRm3nJgdSXkuMf4fX9tnW
 lG/OPZfQDyf8WosOiUw068MC7ZiH/k9UNBOwWbc8/ou4HsEE0cokhF/g5T/WAzzjLnJnvWqQwX7Y
 feigA6BknuCjYLw/sl38r7kUc/1qJYab+Oi0pZrAwMZvzUWd5a1UKDAw1uB7ci8W17Gf3UP28xVH
 bhnYgilQn85qtkFdG+8oksmYeAnETBnKYEV28MKf35lHSvC6UyDhqkhDvCrJPmnnTHzVkpybMK7Z
 TaKt/YBhiRplXhn03vU98dtR7KZTJJG/1QRnwAzHw/oJa+wXImvuA/qi388qP41stPzwxulXBsoQ
 6nZaYxeIqMrmI8mJEUh9mwJV6tRuvxTvKZC7F8ACqTeNLptvxEZcmQCSYva1a6KCh04AyzJQgNha
 I22p7LcY/woTxTSkTFBkpFYIU2/sSgRx7K4UHplMz7cdNsK9Y8oIY7DS9AD2QLNDebtqDywdo+KN
 R3RjhF85CFDxDrsLU3qm2qo1Sr/iLf7nF4yN/7wNlhSml4LIoWChmNdig5VSybRGYqS6oADhepPE
 FpRjoOiggAkX7KdkjxxwEiTVJqDh0qKoKsXx5llBubvYKuhKpuI95ka3cETIzFjcLr6RL8jM3R5I
 hpmFC4kjSTD1ZDObCjF+B8Dvd82vgV/njHHIbNMKOf9nF36x4Ii4PZnY5dOZ7V02q/ROZwRAL85z
 y5irEacH2FSFTW3GLxsTFnT1LoeNMOi6+XYAS/5rYqqYUNIv7+CPD54aAtCBIPOx8FKVIUcRh40P
 xNYulwPEZq0N30Y49KdlglHPMS+4ayUpOtEhdxekWDmK9g==
X-Report-Abuse-To: spam@mut-mta1-se01a-fr.yulpa.io
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Christian Couder" <christian.couder@gmail.com> wrote:

> Hi,
> 
> On Fri, Jan 5, 2018 at 12:18 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Hi,
>>
>> On Fri, 5 Jan 2018, Matthieu Moy wrote:
>>
>>> If we go for it, we need:
>>>
>>> * Admins
>>>
>>> * Potential mentors
>>
>> Count me in as a potential mentor.
> 
> I am ok to be admin and mentor.

Cool :-)

In case you missed it: there's an iCal/Google calendar link on
the timeline page:

  https://developers.google.com/open-source/gsoc/timeline

If you use an electronic calendar, it's nice to add it to make
sure you never miss a deadline. The URL is the same every year, it's
how I got a reminder that the application was open.

-- 
Matthieu Moy
https://matthieu-moy.fr/
