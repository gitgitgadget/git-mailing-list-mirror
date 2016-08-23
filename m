Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 144081FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 18:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753729AbcHWSRK convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 23 Aug 2016 14:17:10 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:49737 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752410AbcHWSRJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 14:17:09 -0400
Received: from cayenne.localnet (unknown [IPv6:2a01:e35:2ef1:f910:86a6:c8ff:fe05:d3e0])
        by smtp1-g21.free.fr (Postfix) with ESMTPS id 7CFE9B0055E;
        Tue, 23 Aug 2016 18:16:32 +0200 (CEST)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Marco Sousa <marcomsousa@gmail.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Nelson Martell <nelson6e65@gmail.com>,
        Brian Gesiak <modocache@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [L10N] Kickoff of translation for Git 2.10.0 round 1
Date:   Tue, 23 Aug 2016 20:16:52 +0200
Message-ID: <6452157.Plx3AU2iJW@cayenne>
User-Agent: KMail/5.2.3 (Linux/4.6.0-1-amd64; KDE/5.23.0; x86_64; ; )
In-Reply-To: <xmqqoa4jxyrk.fsf@gitster.mtv.corp.google.com>
References: <CANYiYbGL+GVRNuhszp1UShaN_oJgm3netsQxZfbW74pVK0gOYQ@mail.gmail.com> <4016813.pOBvC7ZxlR@cayenne> <xmqqoa4jxyrk.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On mardi 23 août 2016 08:58:55 CEST Junio C Hamano wrote:

> > Let's cut it like this : first ten are literally translated, the following
> > ones fall back to a general rule.
> 
> I actually once wrote "It is rare to squash dozens of commits into
> one, so the first ten or dozen messages that spell the ordinals out
> may be a good thing for readability", in the message you are
> responding to, before realizing that the messages actually say
> "1st", "2nd", etc., not "first", "second", etc., and scrapped that
> part of the response.  I do not really see much point in forcing the
> first ten to be translated differently.

In fact, taking some advance on the patch, I made the translations and used 
full words in the translated language.
By majority of repliers, let's just use a single sentence for each case "use" 
or "skip". 

Will rerun the patch set.

JN
