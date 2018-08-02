Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D88D61F597
	for <e@80x24.org>; Thu,  2 Aug 2018 15:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732649AbeHBRHw (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 13:07:52 -0400
Received: from mout.web.de ([212.227.15.4]:44811 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732625AbeHBRHw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 13:07:52 -0400
Received: from [192.168.178.36] ([79.237.249.67]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Mg7Zl-1fYxo72T3t-00NOtp; Thu, 02
 Aug 2018 17:16:10 +0200
Subject: Re: [PATCH] push: comment on a funny unbalanced option help
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Stephen Boyd <bebarino@gmail.com>
References: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
 <87k1p9u860.fsf@evledraar.gmail.com>
 <xmqqwot969mp.fsf@gitster-ct.c.googlers.com>
 <87h8kdu3ay.fsf@evledraar.gmail.com>
 <30a6105c-4cb7-b52f-0b0a-c4504b90a5b1@web.de>
 <87ftzwu9wg.fsf@evledraar.gmail.com>
 <e7e5f54d-04b6-4d0f-0bcb-692801f0719c@web.de>
Message-ID: <80e861f0-717e-6678-ff1d-0c1198cb9c6f@web.de>
Date:   Thu, 2 Aug 2018 17:16:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e7e5f54d-04b6-4d0f-0bcb-692801f0719c@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:V53/VbdCrA2SjocQ9S6eOCLII8AlwCkykWfGk7Zus8b550XBuEZ
 NJHCvOxs7o7mymSyJSF4djdMsZrkW2afkJbB7+5NomE0MfRfZTIKjKjjkaN3mwT6GMLqjo/
 9yKTDKhZAs7dBI+gtEPAlcMqTOF+n7azA6jiwsjoJyeb5C/135sVOY0tgggxs6AfrZKH74g
 rFL3wv6rSnXWwudclZiIw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7pVbnYl3MaE=:WdlrzJZuzNjDjS7CqT0UG2
 fzGj7qs8Y45X28QZRpG7vwM/8hXKRbttnr1sRanx/nRxk139qGJAmPBijjaPEKHq7+6niDTIj
 /SYuxNnZJiwz2O9YdYGFHCjVyThihj96V4DmOKo03PW0bd3gwciYEklJ42tJYd6jOgcfJmbK3
 7WZFxg73D8UHPpUoLpGCYWDSDC327PgIwKIvmtMkaGZOqMmefb601x9KvXBAYVay9m0ZilZsj
 +3jboRZ6GhvWCw38o5O5PER/eiOBm+mB/5l47+h6Jw2v6Wcdf0qKUwF0LjTTpm+yNiNC49wPV
 +z0iwTKkzW6EHJhTVvyqQEITltn5udj86Oad8hQG4AZwnxr4X2c/4ulxopt43NFbMepYKztbL
 SCVkQyyEUPnACb9OMJDXQm1U9HRRtqsgtZi80+oLx9EeFLLAE10N9zMhANPbgBwac9cPdv0Yy
 j4TwSQ5mKpn09wun+9vhJv2MIXS5e5K6tDHx/bZ313IJf2F22mehsKV6iASQJLehbUJ8Xpljc
 Co1HqJTciLP9zL1yK0pqE1GdArJzZ9TD1T8YahnzZGWx4jJ0OPyRMfyvl/Uqwm111X3wFTG4W
 TrxvR1z/JMX/jEiVvk+jiR41vtGej0tX844Vj7uGUv3BOjuQoLEMDAYwdo80VJKhlsJyNwuNj
 8hTQ2h65UkfjCSe2scNMXxvz5VtK17YCSDDifJAtDA2G+RGYnBfaqbTBxI6NEXBgfdkmiupnR
 +9CTsSzx5/pBj1pusZM6J/rIZ6IONzZLzU7hbtVjREfpmv4Z303QPYV2XmC2acZ3Z7kCpDQa3
 iDw8Z/x
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.08.2018 um 17:06 schrieb René Scharfe:
> According to its manpage the option should rather be shown like this:
> 
> 	--force-with-lease[=<refname>[:<expect>]]
> 
> ... to indicate that all three forms are valid:
> 
> 	--force-with-lease
> 	--force-with-lease=some_ref
> 	--force-with-lease=some_ref:but_not_this
> 
> The current code doesn't allow that to be expressed, while it's possible
> with my patch.
Err, anything is possible with PARSE_OPT_LITERAL_ARGHELP, of course, but
with my patch that flag is automatically inferred if you use the argh
string "<refname>[:<expect>]".

René
