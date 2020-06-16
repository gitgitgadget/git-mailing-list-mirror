Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CB6C433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 08:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25915206F7
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 08:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rambler.ru header.i=@rambler.ru header.b="GKIZBNH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgFPIhI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:37:08 -0400
Received: from huan9.mail.rambler.ru ([81.19.78.8]:47242 "EHLO
        huan9.mail.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgFPIhG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 04:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rambler.ru;
         s=mail; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:Reply-To:Message-ID:Subject:To:From:Date;
        bh=sMeT2j3Yb1ppa1zMl+HEFmBCZlQ3FP5OZo0heRJPJX8=; b=GKIZBNH2M0p/1/9tYGYbo2v6Oy
        ukamSd6X7QehrfnIzFSFS3MVUED4EVXKAA1oFB0I11Pw/89eZEa79ttIlHAVCOIXc+LrQO+4Qma08
        49Cx/PHFdi9FGzqND06pRi0Oe51+1uLeQ2AGKG6YLPN1ATe6cgbe4tCOrf4wzEiHAYp8=;
Received: from [UNAVAILABLE] ([194.190.114.28]:34894 helo=localhost)
        by huan9.mail.rambler.ru with esmtpa (Exim 4.86_2)
        (envelope-from <lego_12239@rambler.ru>)
        id 1jl75d-0003Si-5d
        for git@vger.kernel.org; Tue, 16 Jun 2020 11:37:05 +0300
Date:   Tue, 16 Jun 2020 11:38:46 +0300
From:   Oleg <lego_12239@rambler.ru>
To:     Git <git@vger.kernel.org>
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200616083405.GA17381@legohost>
Reply-To: Oleg <lego_12239@rambler.ru>
References: <xmqqy2oqxyp3.fsf@gitster.c.googlers.com>
 <0dd6b6c2-4ea4-498d-4481-7f65988db293@gmail.com>
 <CAGA3LAeXzYokcpU8RnFdF7N5vC-geOdJSY5_Mjc-yssvbpjmgw@mail.gmail.com>
 <CANgJU+Vs-hzU-Fg+iWAn349_azb3k_6PCzyY+S2C_5ZUTv7o=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANgJU+Vs-hzU-Fg+iWAn349_azb3k_6PCzyY+S2C_5ZUTv7o=A@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Rambler-User: lego_12239@rambler.ru/194.190.114.28
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 09:31:43AM +0200, demerphq wrote:
> On Sun, 14 Jun 2020 at 08:35, Don Goodman-Wilson <don@goodman-wilson.com> wrote:
> > But to deny that explosive content on the basis that you don't
> > personally feel it, that you've never experienced it? To claim that it
> > is "meaningless", that some people are "perpetually offended"? That's
> > willful ignorance on your part, a bad-faith effort to engage in
> > serious intellectual conversation about what is good and right, and
> > has no place in a discussion about creating an inclusive space for all
> > developers, let alone trying to bring about a more just world.
> 
> Well said sir. I might quote that sometime.

No. The stupid idea. The stupid discussion. All world use this terminology
and it disturb nobody with sane mind. And why we must change it? Because someone
is completely mad and takes this as an insult to himself? There are many
*real* problems in the world - famine, wars, drought, diseases, etc. What do
you know about this? Where is you HELP? Fucking hypocrites. All of you have
well-fed life - you know nothing about real problems. Do you think you can
just rename something in you fucking code(JUST REPLACE ONE LETTERS WITH
ANOTHER ONE) and this helps somebody? Are you all really so stupid? If you
want to help, just lift your ass from a chair, toss a hamburger and go to
the street, find someone who need help and HELP HIM. Just help somebody! But
this is so hard. Real things are always hard. Every day you need to do something
to make this world better. This is not what we want. We want just to sent $10
sometime to some charity organization or change several letters in our computers.
Yes? This is so simple. Just do it and feel better, liers.

Whole technical world look at you now and think:

"These men are comlete idiots. They really think that changing letters will change
something in real life".

If some of you don't want to write a code and want to do some politics, just
leave and dedicate your life to politics. Why should we all suffer from someone's
polical program? This is not the property of someone. This program is used all over
the world. Did you ask somebody outside of your sandbox, boys? Do you really
understand the responsibility?

-- 
Олег Неманов (Oleg Nemanov)
