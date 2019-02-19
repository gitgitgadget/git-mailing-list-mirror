Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PI_DNOT,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 065601F453
	for <e@80x24.org>; Tue, 19 Feb 2019 16:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfBSQU3 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 19 Feb 2019 11:20:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:55820 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726110AbfBSQU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 11:20:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2BA94B11A;
        Tue, 19 Feb 2019 16:20:28 +0000 (UTC)
Date:   Tue, 19 Feb 2019 17:20:25 +0100
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?UTF-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Senol Yazici <sypsilon@googlemail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org,
        jpyeron@pdinc.us
Subject: Re: [RFE] Demilitarize Documentation (was RE: Delivery Status
 Notification (Failure))
Message-ID: <20190219172025.5577eb31@kitsune.suse.cz>
In-Reply-To: <nycvar.QRO.7.76.6.1902191547510.41@tvgsbejvaqbjf.bet>
References: <001601d4c7aa$460c0e70$d2242b50$@nexbridge.com>
        <xmqqimxh2b61.fsf@gitster-ct.c.googlers.com>
        <CAFacdQ_9=2hbC8-5+N=RdrGs=Anu2ku+TAj7x07OQNpa1b+gcg@mail.gmail.com>
        <20190219100136.GO1622@szeder.dev>
        <nycvar.QRO.7.76.6.1902191547510.41@tvgsbejvaqbjf.bet>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 19 Feb 2019 15:58:00 +0100 (STD)
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> Hi Gábor,
> 
> On Tue, 19 Feb 2019, SZEDER Gábor wrote:
> 
> > On Tue, Feb 19, 2019 at 09:02:43AM +0100, Senol Yazici wrote:  
> > > 1. Dictator
> > > Concern: "Bad" connotation.  
> > 
> > "Benevolent dictator" is a well-established term in open source
> > projects, and it has an inherently good connotation.  
> 
> It is a well-established term, alright. Does it have an inherently good
> connotation? No, absolutely not. Every time anybody calls me the BDFL of
> Git for Windows, it annoys me, to say the least.
> 
> And yes, when I pull out my generous self, I can give you that the
> *intention* was funny. But to some, it is not funny at all.
> 
> Besides, in our field we had pretty established terminology for a long
> time. It was the *architect* who had the final say over what goes in and
> what stays out. And the respective team leaders were responsible for
> respective areas of the code, trusted by the architect.

Established to some perhaps. However, it is rarely the architect
merging to the master repository. Architect and team leaders also
suggests corporate structure. Is git for corporate users only just as
the previous suggested that it is militaristic?

> 
> > > Further, "googling" dictator does not give Linus as a result in (at
> > > least my) search (bubble).  
> > 
> > https://en.wikipedia.org/wiki/Benevolent_dictator_for_life
> >   
> > > Suggestion for substitution: Principal or principal integrator.  
> > 
> > These are poor substitutions.  
> 
> I agree that those are poor substitutions, but shooting down without
> giving better alternatives is a poor way to reply ;-)

No, not at all.

It is very poor reply to critique to say that better alternative should
be provided. The solution stays poor even if you don't have a better
one readily available.

Thanks

Michal
