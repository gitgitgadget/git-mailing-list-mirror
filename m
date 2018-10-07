Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87C751F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 22:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbeJHFse (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 01:48:34 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:48090 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbeJHFse (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 01:48:34 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 42Sz2W5gdKz5tm4;
        Mon,  8 Oct 2018 00:39:47 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 66E034158;
        Mon,  8 Oct 2018 00:39:47 +0200 (CEST)
Subject: Re: What's so special about objects/17/ ?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Nix <nix@esperi.org.uk>,
        Steven Grimm <koreth@midwinter.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
References: <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
 <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
 <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
 <alpine.LFD.0.9999.0709051438460.21186@xanadu.home>
 <87k1mta9x5.fsf@evledraar.gmail.com>
 <f64b5c5d-ef72-a347-bd0f-7b1669a8c10d@kdbg.org>
 <87in2da862.fsf@evledraar.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <c904d10e-d6a1-b1d4-73eb-fb93f5caecdb@kdbg.org>
Date:   Mon, 8 Oct 2018 00:39:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <87in2da862.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.10.18 um 21:06 schrieb Ævar Arnfjörð Bjarmason:
> Picking any one number is explained in the comment. I'm asking why 17 in
> particular not for correctness reasons but as a bit of historical lore,
> and because my ulterior is to improve the GC docs.
> 
> The number in that comic is 4 (and no datestamp on when it was
> published). Are you saying Junio's patch is somehow a reference to that
> xkcd in particular, or that it's just a funny reference in this context?

No lore, AFAIR. It's just a random number, determined by a fair dice 
roll or something ;)

-- Hannes
