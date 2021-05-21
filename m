Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF21C4707E
	for <git@archiver.kernel.org>; Fri, 21 May 2021 20:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4F16613E2
	for <git@archiver.kernel.org>; Fri, 21 May 2021 20:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhEUUOc convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 21 May 2021 16:14:32 -0400
Received: from elephants.elehost.com ([216.66.27.132]:23234 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhEUUOb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 16:14:31 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 14LKCpkp000924
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 21 May 2021 16:12:51 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Felipe Contreras'" <felipe.contreras@gmail.com>,
        "'Jeff King'" <peff@peff.net>,
        "=?utf-8?Q?'Michal_Such=C3=A1nek'?=" <msuchanek@suse.de>
Cc:     "'Jonathan Nieder'" <jrnieder@gmail.com>,
        "'Emily Shaffer'" <emilyshaffer@google.com>,
        "'Git List'" <git@vger.kernel.org>,
        "=?utf-8?Q?'Jan_Kr=C3=BCger'?=" <jk@jk.gs>
References: <CAJoAoZ=e62sceNpcR5L5zjsj177uczTnXjcAg+BbOoOkeH8vXQ@mail.gmail.com> <YKViF9OVLeA95JPH@google.com> <20210520071141.GZ8544@kitsune.suse.cz> <YKaaBj0KmJ3K5foC@coredump.intra.peff.net> <60a7fe0b2dd8d_558062087@natae.notmuch>
In-Reply-To: <60a7fe0b2dd8d_558062087@natae.notmuch>
Subject: RE: Should we do something with #git-devel on Freenode?
Date:   Fri, 21 May 2021 16:12:44 -0400
Message-ID: <02ab01d74e7d$acd5cbd0$06816370$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHLXLJ1XWsvrZsSCAklblvzkXmMcgFcQJOSAliBEeoCigWjBgIPXDPLqsPNwuA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 21, 2021 2:38 PM, Felipe Contreras wrote:
>Jeff King wrote:
>> Of course there's value in coordinating. Everybody _can_ hang out on
>> their favorite venues and eventually talk to each other, but it's much
>> easier if everybody agrees where to go. :)
>
>I don't think it works that way.
>
>I "everybody" agrees to move to Discord, many old-timers won't. Same with Gitter. And if most people were on IRC, many youngsters
>wouldn't come.

Having been on IRC for three separate rounds, with a smattering of AOL, CompuServe, HipChat, Slack, Hangouts, Messenger, SMS, Skype, Teams... I'd be surprised if a consensus is possible.  The limiting factor for most of my circle is whether connections are even possible from corporate intranets and IRC is generally blocked. For the more blocked ones, Slack and Teams tend to be more palatable (not in my opinion). We have IRC open by exemption (specifically for #git) and will close it if IRC is discontinued. It might be worth taking a poll of what people can use instead of preference. My $0.02 bet is that that is the limiting factor for the community as a whole (work from home COVID notwithstanding).

>There's a limit to how many chat applications you are willing juggle, and adding one more just to chat with git developers is something
>many people won't do.

I don't know about you, but when 5 or 6 chat platforms beep at me at the same time, I start looking for the exit - or Friday afternoons. As a sideways thought, maybe we should just figure out a way to go to Zoom and be done with it (I have no affiliation).

Cheers,
-Randall

-- Brief whoami:
NonStop developer since approximately 211288444200000000
UNIX developer since approximately 421664400
Still not talking about MVS.
-- In my real life, I talk too much.




