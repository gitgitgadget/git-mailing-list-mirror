Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB91C433DF
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 21:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A99D206D7
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 21:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgFNVPC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 17:15:02 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:60708 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbgFNVPB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 17:15:01 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id E7D7B1F5AE;
        Sun, 14 Jun 2020 21:15:00 +0000 (UTC)
Date:   Sun, 14 Jun 2020 21:15:00 +0000
From:   Eric Wong <normalperson@yhbt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        =?utf-8?Q?S=C3=A9rgio?= Augusto Vianna 
        <sergio.a.vianna@gmail.com>, philipoakley@iee.email,
        Johannes.Schindelin@gmx.de, don@goodman-wilson.com,
        git@vger.kernel.org, msuchanek@suse.de, newren@gmail.com,
        sandals@crustytoothpaste.net, simon@bocoup.com, stolee@gmail.com
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200614211500.GA22505@dcvr>
References: <9d3d3888-55e5-61f0-1541-9854a70fb233@iee.email>
 <d020d05f-5e36-2959-3eae-d7e21bf51178@gmail.com>
 <20200614181906.u42tuny3eipvhd46@chatter.i7.local>
 <xmqqmu55xsqd.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmu55xsqd.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> It of course opens a different can of worms ;-) Even though we can
> please master-slave-haters by moving away from the particular word
> 'master', those who cannot stand the very idea of one thing being
> special among others will not be satisfied (and we shouldn't even
> try to please them, IMO).

As somebody who does not like the idea of things being special,
I'm considering renaming "master" of the few projects I maintain
to "unofficial".  It fits my anti-centralization and
anti-authoritarian mind, at least :>
