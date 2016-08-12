Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21651203BD
	for <e@80x24.org>; Fri, 12 Aug 2016 07:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbcHLHnC (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 03:43:02 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:57670 "EHLO
	smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbcHLHnA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 03:43:00 -0400
Received: from PhilipOakley ([92.22.69.35])
	by smtp.talktalk.net with SMTP
	id Y72ubGGJIxR4bY72wbaeTA; Fri, 12 Aug 2016 08:38:27 +0100
X-Originating-IP: [92.22.69.35]
X-Spam:	0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=118V6UEFpCLMRzptT8w30g==:117
 a=118V6UEFpCLMRzptT8w30g==:17 a=IkcTkHD0fZMA:10 a=gdoHADL5AAAA:8
 a=xtxXYLxNAAAA:8 a=5rxgeBVgAAAA:8 a=S4xfRp7QQVHrsRsy4ZIA:9
 a=4dtb82l_A6RjyT71:21 a=VBHeilj_ydcKrKjQ:21 a=DclRd9yUzMzvIfv12z_R:22
 a=xts0dhWdiJbonKbuqhAr:22 a=PwKx63F5tFurRwaNxrlG:22
Message-ID: <6E3699DEA672430CAEA6DEFEDE6918F4@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Eric Wong" <e@80x24.org>
Cc:	<git@vger.kernel.org>
References: <73FC8DE87D24466EBEE0A5B96CBDFFBF@PhilipOakley> <20160811075628.GA24690@starla> <95848D06D55D4633A686DD892D12F501@PhilipOakley> <20160811222615.GA5607@starla>
Subject: Re: Mapping old gmane numbers to existing amil servers?
Date:	Fri, 12 Aug 2016 08:38:24 +0100
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
X-CMAE-Envelope: MS4wfKsPNqaD9Ba3KSwcTVAT/5hYQbDk69YJXQw4YYtr4DoRdifbQMotODo+eC4swW3O8Wpq6xVfVnG/DVN+PE6KViMtt1+9jRKsdmnwRD7Yk8R3/Z20mkB3
 JJ+hsCWk4nh3OlNdycAmmy3/xjjkD5YkH/+P2VScRaNgy0fmM/uB4oK6zph/V8z/fmQ2p96kt1qzmw==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Eric Wong" <e@80x24.org>
Sent: Thursday, August 11, 2016 11:26 PM
> Philip Oakley <philipoakley@iee.org> wrote:
>> The raw download works. My home ISP is currently blocking your email for
>> some reason, though I do see it at my work - my iee.org alias is via my
>> professional body which duplicates the email when it relays it.
>
> Hmm, do other emails from other users get blocked?
> I wonder if it's lack of DKIM (which gets invalidated by the
> list sig vger appends) or something else...

Not really sure. My professional body's alias service now uses EveryCloud 
for its antispam. initially it also blocked your mails as 'spam', by the 
daily notification allows me to white list that. However the forwarded 
emails go to both home & work, and only the home ISP (cheap but annoying) 
then has no white list mechanism and no way of seeing what they binned.

>
>> On thing I did note on the web display of the threads is that it would be
>> good to have a leader of " . . . . . `" so that one can count the level 
>> of
>> indent, and see the alignments via the columns of dots.
>>
>> When looking at
>> https://public-inbox.org/git/0648000B273C412AB7140AE959EBC99A%40PhilipOakley/
>> I had difficulty working out which email the last 4 were replying to.
>
> https://public-inbox.org/git/0648000B273C412AB7140AE959EBC99A%40PhilipOakley/
> So, right now, it's:
>
> 2016-07-20 21:10               ` [PATCH v4 8/8] doc: revisions - clarify 
> reachability examples Philip Oakley
> 2016-07-20 22:22               ` Junio C Hamano
> 2016-08-11 21:50               ` [PATCH v5 00/12] Update git revisions 
> Philip Oakley
> 2016-08-11 21:50                 ` [PATCH v5 01/12] doc: use 'symmetric 
> difference' consistently Philip Oakley
> 2016-06-25 19:49       ` Junio C Hamano
> 2016-06-27 13:37         ` Philip Oakley
> 2016-06-27 15:08           ` Junio C Hamano
> 2016-06-27 15:39             ` Philip Oakley
>
> And you would rather see something like:
>
> 2016-07-20 21:10       .       ` [PATCH v4 8/8] doc: revisions - clarify 
> reachability examples Philip Oakley
> 2016-07-20 22:22       .       ` Junio C Hamano
> 2016-08-11 21:50       .       ` [PATCH v5 00/12] Update git revisions 
> Philip Oakley
> 2016-08-11 21:50       .         ` [PATCH v5 01/12] doc: use 'symmetric 
> difference' consistently Philip Oakley
> 2016-06-25 19:49       ` Junio C Hamano
> 2016-06-27 13:37         ` Philip Oakley
> 2016-06-27 15:08           ` Junio C Hamano
> 2016-06-27 15:39             ` Philip Oakley
>

Not quite, something like:
2016-07-20 21:10       . . . . ` [PATCH v4 8/8] doc: revisions - clarify 
reachability examples Philip Oakley
2016-07-20 22:22       . . . . ` Junio C Hamano
2016-08-11 21:50       . . . . ` [PATCH v5 00/12] Update git revisions 
Philip Oakley
2016-08-11 21:50       . . . . . ` [PATCH v5 01/12] doc: use 'symmetric 
difference' consistently Philip Oakley
2016-06-25 19:49       ` Junio C Hamano
2016-06-27 13:37         ` Philip Oakley
2016-06-27 15:08           ` Junio C Hamano
2016-06-27 15:39             ` Philip Oakley


I haven't filled in the last ones because there are no matching follow on 
replies, e.g to Junio' s 2016-06-25 19:49 message.
(I may not have put in enough of the lead either)
However for ease of formatting I guess that simply setting the indent to be 
'. ' rather than '  ' (both 2 chars) would create the impression of the 
messages being on an indent grid

If rather than looking at those below junio's reply, you try and look at 
which message he was replying to, it's very hard (It's more than a full 
screen scroll up), hance the request for the alignment 'column of dots'. I 
think he was replying to my 2016-06-25 13:50, but it's not easy to be sure.

> ?
>
> Actually, my initial inclination was to use the '|' character
> which is what mutt does
>
> 2016-07-20 21:10       |       } [PATCH v4 8/8] doc: revisions - clarify 
> reachability examples Philip Oakley
> 2016-07-20 22:22       |       } Junio C Hamano
> 2016-08-11 21:50       |       ` [PATCH v5 00/12] Update git revisions 
> Philip Oakley
> 2016-08-11 21:50       |         ` [PATCH v5 01/12] doc: use 'symmetric 
> difference' consistently Philip Oakley
> 2016-06-25 19:49       ` Junio C Hamano
> 2016-06-27 13:37         ` Philip Oakley
> 2016-06-27 15:08           ` Junio C Hamano
> 2016-06-27 15:39             ` Philip Oakley
>
> It should be doable, and the '`' immediately following the last
> '|' probably ought to be a link to the parent, too.
>

I feel that the '¦' style chars will fill the screen too much (with '.' 
being the minimalist I can think of), but it's a personal choice.

> I would also like to use '}' (as above) or '+' where mutt would
> use "├─>" or just '├', but I don't think I can introduce multibyte
> chars without causing problems for some users.
>
> Anyways, it's definitely on my ever-growing todo list.
>
>
> (Wow, it is refreshing to be a "web designer" who can live
> entirely in a terminal without relying on screenshots :D)
>
>

Philip 

