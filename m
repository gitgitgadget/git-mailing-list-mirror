Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1B321F403
	for <e@80x24.org>; Thu,  7 Jun 2018 21:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752041AbeFGV4A (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 17:56:00 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:52209 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751956AbeFGVz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 17:55:59 -0400
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id R2sufqFEqwhzSR2sufeIGq; Thu, 07 Jun 2018 22:55:58 +0100
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=A1X0JdhQAAAA:8
 a=NEAV23lmAAAA:8 a=Fh-62nhE_fI9kPwLb9QA:9 a=DrJk4DP6UvE32rSX:21
 a=ING-HZaeQkYLMa8U:21 a=wPNLvfGTeEIA:10 a=MY9urf3tlLUA:10
 a=Df3jFdWbhGDLdZNm0fyq:22
Message-ID: <3EF5AC29192A4D179B6D8689ECB991CC@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Peter Backes" <rtc@helen.PLASMA.Xg8.DE>,
        "David Lang" <david@lang.hm>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        "Git Mailing List" <git@vger.kernel.org>
References: <20180417191549.GA1199@helen.PLASMA.Xg8.DE> <87y3hlecod.fsf@evledraar.gmail.com> <20180603092736.GA5510@helen.PLASMA.Xg8.DE> <87vab087y2.fsf@evledraar.gmail.com> <20180603112557.GA6564@helen.PLASMA.Xg8.DE> <87tvqk81qp.fsf@evledraar.gmail.com> <20180603141801.GA8898@helen.PLASMA.Xg8.DE> <6BE308009FFA4CCDB5B3B47C2AC53E20@PhilipOakley> <20180603174617.GA10900@helen.PLASMA.Xg8.DE> <alpine.DEB.2.02.1806061831340.7659@nftneq.ynat.uz> <20180607063225.GA28343@helen.PLASMA.Xg8.DE>
Subject: Re: GDPR compliance best practices?
Date:   Thu, 7 Jun 2018 22:28:47 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 180607-0, 07/06/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfD4qUpPYNEqkm1c4xrlvBmg+5Neyf9eW2YAYwqF1y7TWC0TSGX+K0K+lGvQyBOAeLZac2k21zKm8Toe1QPTNmsXXz70tsJu3rPwP3acqCDNa9aYaBnNa
 rIrLmR2SGAIUrHrs3qgcgFgHupxl1AKTHxOCQ5VkDlAC/xIXNE+iiqOCRD2tLVCWp0vur1WYfz02JKeyVRRfU2vg3kclDhTrisfGGsuT8ubf1rDYiBID5f6R
 inNMDMMzmoKgWeLPs27e4A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peter, David,

I thought that the legal notice (aka 'disclaimer') was pretty reaonable.

Some of Peter's fine distinctions may be technically valid, but that does 
not stop there being legal grounds. The proof of copyright is a legal 
grounds.

Unfortunately once one gets into legal nitpicking the wording becomes 
tortuous and helps no-one.

If one starts from an absolute "right to be forgotten" perspective one can 
demand all evidence of wrong doing , or authority to do something, be 
forgotten. The GDPR has the right to retain such evidence.

I'll try and comment where I see the distinctions to be.

From: "Peter Backes" <rtc@helen.PLASMA.Xg8.DE>

> Hi David,
>
> thanks for your input on the issue.
>
>> LEGAL GDPR NOTICE:
>> According to the European data protection laws (GDPR), we would like to 
>> make you
>> aware that contributing to rsyslog via git will permanently store the
>> name and email address you provide as well as the actual commit and the
>> time and date you made it inside git's version history.

This is simply an information statement

>       This is inevitable,
>> because it is a main feature git.

The "inevitable" word creates a point of argument within the GDPR. Removing 
the word (and 'because/main') brings the sentance back to be an informative 
statement without a GDPR claim.
>
> As we can, see, rsyslog tries to solve the issue by the already
> discussed legal "technology" of disclaimers (which is certainly not
> accepted as state of the art technology by the GDPR). In essence, they
> are giving excuses for why they are not honoring the right to be
> forgotten.
>
> Disclaimers do not work. They have no legal effect, they are placebos.
>
> The GDPR does not accept such excuses. If it would, companies could
> arbitrarily design their data storage such as to make it "the main
> feature" to not honor the right to be forgotten and/or other GDPR
> rights. It is obvious that this cannot work, as it would completely
> undermine those rights.
>
> The GDPR honors technology as a means to protect the individual's
> rights, not as a means to subvert them.
>
>> If you are concerned about your
>> privacy, we strongly recommend to use
>>
>> --author "anonymous <gdpr@example.com>"
>>
>> together with your commit.

The [key] missing information here is whether rsyslog has a DCO (Developer 
Certificate of Origin) and what that contains.

The git.git DCO is here 
https://github.com/git/git/blob/master/Documentation/SubmittingPatches#L304-L349

This will also help discriminate between the "name" part and the <unique> 
identifier, as both could be separately anonymised (given the right DCO). 
Thus it may be that the name is recored as "anonymous", but with a 
<uid@known.place> that bridges the legal evidence/right to be forgotten 
bridge.
>
> This can only be a solution if the project rejects any commits which
> are not anonymous.
>
>> However, we have valid reasons why we cannot remove that information
>> later on. The reasons are:
>>
>> * this would break git history and make future merges unworkable
>
> This is not a valid excuse (see above).

Within the GDPR, that is correct. It (breaking history validation), of 
itself, should not be the reason.

>      The technology has to be
> designed or applied in such a way that the individuals rights are
> honored, not the other way around.
>
> In absence of other means, the project has to rewrite history if it
> gets a valid request by someone exercising his right to be forgotten,
> even if that causes a lot of hazzle for everyone.
>
>> * the rsyslog projects has legitimate interest to keep a permanent record 
>> of the
>>   contributor identity, once given, for
>>   - copyright verification
>>   - being able to provide proof should a malicious commit be made
>
> True, but that doesn't justify publishing that information and keeping
> it published even when someone exercises his right to be forgotten.

Publishing (the meta data) is *distinct* from having it.

However publishing the content and it's legal copyright is also associated 
with identifying the copyright holder (who has released it). This can be the 
uid if they hide behind a legal entity. This creates the catch 22 scenario. 
You either start off public and stay public, or you start off private and 
stay there.

Whether the rsyslog folk want to accept copyrighted work without appropriate 
legal release (who guards the guards, what's their badge number?) is part of 
the same information requirement.

Malicious intent makes the submission (commit) part of a legal evidence one 
needs to retain, so is supported by GDPR.

>
> In that case, "legitimate interest" is not enough. There need to be
> "overriding legitimate grounds". I don't see them here.
>
>> Please also note that your commit is public and as such will potentially 
>> be
>> processed by many third-parties. Git's distributed nature makes it 
>> impossible
>> to track where exactly your commit, and thus your personal data, will be 
>> stored
>> and be processed. If you would not like to accept this risk, please do 
>> either
>> commit anonymously or refrain from contributing to the rsyslog project.

The onward publishing and release should be by refernce to the DCO, and not 
that it's the Git way. As Peter notes, the 'Git way' (solely by itself) is 
no defence.
>
> This is one of those statements that ultimately say "we do not honor
> the GDPR; either accept that or don't submit". That's the old, arguably
> ignorant mentality, and won't stand.
>
> The project has to have a legal basis for publishing the personal
> metadata contained in the repository. In doubt, it needs to be consent
> based, as that is practically the only basis that allows putting the
> data on the internet for everyone to download. And consent can be
> withdrawn at any time.
>
> The GDPR's transitional period started over two years ago. There was
> enough time to get everything GDPR compliant.
>
> It might be possible to implement my solution without changing git,
> btw. Simply use the anonymous hash as author name, and store the random
> number and the author as a git-notes. git-notes can be rewritten or
> deleted at any time without changing the commit ID. I am currently
> looking into this solution. One just needs to add something that can
> verify and resolve those anonymous hashes.
>

To me, the key legal document is the DCO (and the law on which it stands). 
It is that which either conveys the rights, or does not. If the DCO is too 
loose then folk will be able to walk away from their malign code, and demand 
that someone else take responsibility for protecting them from it.

Philip 

