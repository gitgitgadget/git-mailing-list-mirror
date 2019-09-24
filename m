Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65C211F463
	for <e@80x24.org>; Tue, 24 Sep 2019 17:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfIXRFP (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 13:05:15 -0400
Received: from pine.sfconservancy.org ([162.242.171.33]:46222 "EHLO
        pine.sfconservancy.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbfIXRFP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 13:05:15 -0400
X-Greylist: delayed 549 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Sep 2019 13:05:15 EDT
Received: from YOLO (c-76-118-177-220.hsd1.ma.comcast.net [76.118.177.220])
        (Authenticated sender: deb)
        by pine.sfconservancy.org (Postfix) with ESMTPSA id ECB6CE256;
        Tue, 24 Sep 2019 16:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sfconservancy.org;
        s=pine; t=1569344164;
        bh=P1I5CCvktztVUIw0PVo6a3U2LcXMX+F6wSrnJSero+0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=csjUYb/mD3IGC1o7diKJqV6Yg3oIlclT7/7U7IgQEUBou+0TDSTl+Kaedd/y+9rjX
         sCdOx4jo5tJFNonWBTlD+XBHZ1QQBewg+8JAWyZJv/1AB2Led0xb11HWWcZW1fADKX
         fdCxpx3ZfqEFbc+8DHB1iAvovmDhMzbpKb4pMKAGb9XcOqtFNAPGgQFGzCU+ozwCW5
         sKMqNPr5/ittpDXem5QPo6aX7mBz6vVhcY+LcUXB63g5K95jbKyFLObxEqziaXArkK
         aUpoSHB6RNaIhI32QXPCt3BkshaiItsag6mFW2Hfa8j7OB9XmM/Jg6zseMoB4Wn1st
         jeQuMnWz5n7Jw==
Message-ID: <1569344163.2309.5.camel@sfconservancy.org>
Subject: Re: [PATCH] add a Code of Conduct document
From:   Deb Nicholson <deb@sfconservancy.org>
To:     Garima Singh <garimasigit@gmail.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Cc:     git@sfconservancy.org, Derrick Stolee <stolee@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Date:   Tue, 24 Sep 2019 12:56:03 -0400
In-Reply-To: <133b46b2-b2e1-4673-820b-5a5ca6ec0269@gmail.com>
References: <20190924064454.GA30419@sigill.intra.peff.net>
         <133b46b2-b2e1-4673-820b-5a5ca6ec0269@gmail.com>
Organization: Software Freedom Conservancy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all, 
Deb here from Git's fiscal home. Let us know if you need any advice or
help finding a professional consultant to take a look at the Code of
Conduct document for you. I'm also happy to perosanlly take a look at
any draft(s).
Best, 
Deb


On Tue, 2019-09-24 at 12:53 -0400, Garima Singh wrote:
> On 9/24/2019 2:44 AM, Jeff King wrote:
> > 
> > 
> > If people are on board with this direction, it might be fun to pick
> > up a
> > bunch of "Acked-by" trailers from people in the community who agree
> > with
> > it. It might give it more weight if many members have publicly
> > endorsed
> > it.
> > 
> > I've cc'd git@sfconservancy.org here, because I think it's
> > important for
> > all of the project committee members to endorse it (and because the
> > document puts us on the hook for enforcing it!).
> > 
> I think this looks really good. I appreciate how it gets the point
> across for
> people to empower each other and welcome new members without being
> too wordy.
> It gets my wholehearted ACK. Thanks for putting it together. 
> 
> Cheers,
> Garima G Singh
-- 
Deb Nicholson <deb@sfconservancy.org>
Software Freedom Conservancy

