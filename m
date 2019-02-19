Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PI_DNOT,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0A5C1F462
	for <e@80x24.org>; Tue, 19 Feb 2019 09:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfBSJjL (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 04:39:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:45110 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727638AbfBSJjK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 04:39:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2194DAD1A;
        Tue, 19 Feb 2019 09:39:08 +0000 (UTC)
Date:   Tue, 19 Feb 2019 10:39:06 +0100
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Senol Yazici <sypsilon@googlemail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de, jpyeron@pdinc.us
Subject: Re: [RFE] Demilitarize Documentation (was RE: Delivery Status
 Notification (Failure))
Message-ID: <20190219103906.3fc4c231@naga.suse.cz>
In-Reply-To: <CAFacdQ_9=2hbC8-5+N=RdrGs=Anu2ku+TAj7x07OQNpa1b+gcg@mail.gmail.com>
References: <001601d4c7aa$460c0e70$d2242b50$@nexbridge.com>
        <xmqqimxh2b61.fsf@gitster-ct.c.googlers.com>
        <CAFacdQ_9=2hbC8-5+N=RdrGs=Anu2ku+TAj7x07OQNpa1b+gcg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 19 Feb 2019 09:02:43 +0100
Senol Yazici <sypsilon@googlemail.com> wrote:

> Dear all,
> 
> Thank you for the quick response and apologize my late reply (good
> morning from Europe).
> 
> I understand that well "established" concepts might make it easier
> grasping concepts.
> 
> My concerns towards using these particular expressions
> (dictator/lieutenant/blessed) are nevertheless motivated.
> 
> 1. Dictator
> Concern: "Bad" connotation.
> 
> I agree, dictator is not military, but it is not "not military at
> all", see https://www.merriam-webster.com/dictionary/dictator.
> Except of case 1 a (and 2, which is not applicable in this context),
> cases b and c are related to either "autocrat" or "fascist dictator".
> Both of these historical "figures" majorities abused their military
> power to "rule" in an oppresive way.
> Further, "googling" dictator does not give Linus as a result in (at
> least my) search (bubble).
> It gives the well known bad examples of dictators usually having
> abused or are abusing their powers in an oppressive/tyrannical way.

You could say that serves as a reminder that authority comes with
responsibility ;-)
> 
> Suggestion for substitution: Principal or principal integrator.
> 
> 2. Lieutenant (somehow I manage to misspell this word most of the times)
> Concern: Strong relation to military.
> 
> I also agree here, lieutenant is not military, again see
> https://www.merriam-webster.com/dictionary/principal.
> The connotation here is also not as negative as it is with dictator.
> However, googling lieutenant results in mostly military figures.
> 
> Suggestion for substitution: Assistant or assistant integrator.

So now the terms sound a lot like a corporate lingo. Is it now turn for
enthusiasts and entrepreneurs to feel excluded because git is meant
only for corporations, and for people who had bad experience as
corporate employees to feel offended?

> 
> 3. Blessed repository
> Concern: Rather exclusive than inclusive.
> 
> I agree, blessed is not a bad phrasing. But if one is not
> attached/related to a religion in some way, one somehow feels left
> out.
> It is creating some troubles explaining this to the "curious young
> mind" (i.e. children) without having to mention religion at some point
> of the explanation.
> Why should one need to go there in a discussion of how "big projects"
> are dealt with?
> Of course, one could say "it is another word for approved" and neglect
> the origin of the word.
> What would then be left as a motivation to use this word at all, and
> not use approved?
> 
> The more I try to understand what "blessed" in a context of a
> repository wants to tell me about it's current state, the less I am
> understanding.
> 
> I think the state of the repository is something like "Approved by
> principal integrator" or "Principal integrator (PI) approved", thus...
> 
> Suggestion for substitution: PI-Approved repository
> 
> Words have their weight.

The problem is they all have weight, and different words have different
weights for different people.

> In times where the entire world is accessible by the "click of a
> finger" it is becoming more and more important to be inclusive.
> Further, in a world where hundred of millions live in conditions ruled
> by dictators or military regimes _I_ care more about acceptable than
> "descriptive".

I would like to point out that dictators rarely call themselves
'dictator' so whatever negative connotations people living in actual
dictatorships are most likely connected with the person of the dictator
or the title the dictator chose for themselves and not the actual word
'dictator'.

Also once you go down this route you will find that most words have
some negative connotation to some people. If you manage to find a few
purely neutral words and write your documentation with them people will
likely learn to hate them over time because they will read them again
and again in vague politically correct documentation that does not
describe what it is supposed to document in fear of offending somebody.

At that point you can just delete the page from the documentation and
be done with it.

> 
> I am not sure if someone in a "warlike" situation will feel "included"
> finding these expressions when it is about software development
> projects!

I don't feel included in projects where the documentation is
unintelligible for use of vague and non-descriptitve words.

Thanks

Michal
