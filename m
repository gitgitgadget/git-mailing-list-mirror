Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4120B2047F
	for <e@80x24.org>; Mon, 31 Jul 2017 11:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbdGaL26 (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 07:28:58 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:62678 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750869AbdGaL26 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 07:28:58 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id c8sPdKlAVlmqOc8sQdKnRO; Mon, 31 Jul 2017 12:28:56 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=H+Sr+6Qi c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=NEAV23lmAAAA:8 a=5rxgeBVgAAAA:8 a=anyJmfQTAAAA:8 a=w41elzSGI3lyMduBvLwA:9
 a=yZoVVUbC94zAuYIM:21 a=UAJTVN-rOyqpC2Tz:21 a=QEXdDO2ut3YA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22 a=PwKx63F5tFurRwaNxrlG:22 a=YJ_ntbLOlx1v6PCnmBeL:22
Message-ID: <BEDE2127EE5B47F1A739DF583B7DBDE9@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     <christopher.diaz.riv@gmail.com>
Cc:     "Git List" <git@vger.kernel.org>
References: <1501423608.3232.30.camel@gmail.com> <6EF3784A5C1F420699D881AF642F28CD@PhilipOakley> <1501438901.3232.46.camel@gmail.com>
Subject: Re: Contact with Latinamerica
Date:   Mon, 31 Jul 2017 12:28:45 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 170731-0, 31/07/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfOtnLlf31SsnMI9gURdhfmqZ5PIPI1sRauSKf9EOepXxwcYw3MrF4L2z5z+UtgK5mELlja6ZicwqBocD1LbRLNRtsLBfHIaQLk0eMKKBr/K9zdcq6HkA
 KUmWuJXd1F+94ZdFjZPga2StNVFw7O9jFUYE0OHhICaPkR8enfA/26qiSzdiG5zZdAbhNYGb0CA6qlo+btl17qehEzLpn+bNc1g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Christopher Díaz" <christopher.diaz.riv@gmail.com>

Hi Christopher,
I've included the Git list to keep the discussion open to all the community. 
(we usually use reply all)

> El dom, 30-07-2017 a las 19:01 +0100, Philip Oakley escribió:
>
> Hi Philip,
>
> Thank you very much for such a fast reply.
>
>
>> I can see two simple steps toward your goal that may help.
>>
>> The first is to ensure that the open source tools do have
>> localisation
>> (l10n) of their command line messages, for which I'm sure Git's l10n
>> team
>> would be happy to have your communities support. -
>> https://github.com/git-l10n and
>> https://public-inbox.org/git/CANYiYbEJ3Gw=JvbhLBeFWBD7xLXxd=_fFdH3UX7
>> 6H97ZU_3zKA@mail.gmail.com/#r
>>
>
> That would be amazing since the second step in order to help open
> source communities is knowing how to use git (the first one is teaching
> them a programming language in order to be able to understand the code,
> we are taking care of that too). This is something that we will need to
> teach practicaly all of the members to do if they don't already know.
> I'll be in contact with the team.
>

You may also want to look at the https://git-scm.com/book/en/v2 free book 
which can be translated by volunteers, and is possibly one of the first 
ports of call for most users (top or near-top of search engine hits)

>> The other idea is to consider how Git's version message, or
>> something
>> similar, should report the users current i18n settings, and any links
>> to the
>> right (e.g. local) support groups. At present, I don't see any
>> obvious
>> command to help users (and those on the help forums and lists) know
>> what
>> i18n nationality / language names to use for discussions. Sometimes
>> it is
>> worth ensuring these baby steps are in place.
>>

Another very simple step is to read and comment on the commit messages sent 
to the list, particulalrly for ease of readability and ease of 
translation/comprehension.

It is very easy to write sentences that are too long. And with too many 
conjunctions.

We do not notice when we do it, having only been taught to write long 
flowery sentences for essays and novels...

Proof-reading the commit messages will also allow the reader to do directed 
research on just the particular item (both the use of language and the code 
style)

>
> Yes, thanks for taking this in consideration, the reallity here in
> Peru, and I could say maybe in a lot of parts in Latinamerica is that
> they don't produce technology since it is mucho more easy just to buy
> something and the language doesn't help to make the learning curve
> easier.
>
> I'll contact the translation team and I hope you won't mind if we could
> say here that we contribute to the git project. It would be a lot
> easier for me in order to go to invite people to the community in
> educational institutions if I could say that the community helps very
> big open source projects like git. And if there are some legal
> procedures that I need to accomplish in order to be able to say it
> publicly, it would be very kind of you if you point me into the right
> direction.
>
Welcome to the community! All it takes is one email (a journey of a thousand 
miles starts with the first step) [1]

>
> Thanks for all the info
> Christopher Díaz Riveros

[1] It's easy to feel overwhelmed by other who post..  can find the article 
but... 

