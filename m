Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8958C1F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbeHHVBQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:01:16 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33855 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727295AbeHHVBQ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Aug 2018 17:01:16 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id E0778220C7;
        Wed,  8 Aug 2018 14:40:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 08 Aug 2018 14:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=y0pcfZAKUR9vlvD/lvYosC2eGdMSz
        5HlZTkuoqvlxL8=; b=sAJ7Sv+YvRyakGlp8uehymnw9xNIyhjm+Ta/PM1iJid7z
        gMqCWdu4bg/3euPDiGdoOtIIHr9CqIphs43CPmvFLQkenow2t8DSdMlg5GKnppqU
        5y9M5rJLR2AZ8NGMAMt4CmFqLcpR4EKoWsemj1KLtBmt6BKW3vfFJHfOsorr0iYq
        zGrAut5S6gnIArIb6OuVZM4omdfgb+DLQ4/XoG6JTHVaLtmdHZl0cGQ51r0ilJtO
        TTpZQ3RkeZMss63hc+X60+j6HSjULT56TaSZwPrlyARxgHSwDwV4aA0aiSHg/18V
        L75ILHAEGRoz4AYqaLoiqDnMH3GGxMxGdqPL78Bpg==
X-ME-Proxy: <xmx:EjlrW1tvVGo_QBQHOZlAfJrgcgKXdXxEzls5z-T6Xv8rR7R0TbRIww>
    <xmx:EjlrW-ohLOhvyhf8WY7FjycEi45jyZ-zWTwWezBcrIdBeU8eG9DUfg>
    <xmx:EjlrW6n11NjWLeRpdyJO1lxwIDx0C1CN9RJsFwlPFSp1QeE0AyZFfA>
    <xmx:EjlrW6zs9JabVcdu06dhc2rA7kjwGsZS12rQkorQjjtQo23aBGJeEQ>
    <xmx:EjlrW6k4E0f8DSP1fvpEKIJNlQrQpKCb_0ihoaAUMZEs4jHvomX4lQ>
    <xmx:EjlrW7jS11vYHTG8WtMJ8Ggbvg3ZcDHcMGOL9f2SXm2kHLoaTw3wIw>
X-ME-Sender: <xms:EjlrWxauytaHaVg9uF9zsIyGGVTOdNjvobGtucaTbPjzp791RhLUMQ>
References: <20180808035854.49D69E450E@mailuser.nyi.internal> <CAPig+cRP-t+4nDd2ei7PNPupcWSbcNAQaqmiEMVLGh3Nwuc2FA@mail.gmail.com>
From:   Brady Trainor <mail@bradyt.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Page content is wider than view window
In-reply-to: <CAPig+cRP-t+4nDd2ei7PNPupcWSbcNAQaqmiEMVLGh3Nwuc2FA@mail.gmail.com>
Date:   Wed, 08 Aug 2018 11:40:16 -0700
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <20180808184017.DC28C10268@mailuser.nyi.internal>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Eric Sunshine <sunshine@sunshineco.com> writes:

> The git-scm.com website is maintained as a distinct project[1] at
> Github; it is not directly related to the Git project itself (to which
> you sent this email). A good way to voice a concern or make a
> suggestion about the website is either to open an issue[2] or submit a
> pull request[3] if you have a specific change in mind.
>
> The Pro Git book (if that's what you're reading) is also a distinct
> project[4], not directly related to the Git project. You can likewise
> open an issue[5] or submit a pull request[6] if needed.
>
> [...]

Ah, that was completely discoverable through the website. My mistake,
thank you for redirect.

-- 
Brady
