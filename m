Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79DD11F4F8
	for <e@80x24.org>; Thu,  6 Oct 2016 04:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbcJFEwy (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 00:52:54 -0400
Received: from ikke.info ([178.21.113.177]:45952 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750979AbcJFEwx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 00:52:53 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 9A3874401D4; Thu,  6 Oct 2016 06:52:50 +0200 (CEST)
Date:   Thu, 6 Oct 2016 06:52:50 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Tom Hale <tom@hale.ee>
Cc:     Anatoly Borodin <anatoly.borodin@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Setting pager.add=true breaks add --patch
Message-ID: <20161006045250.GA25613@ikke.info>
References: <e8bdb434-432b-57c6-5cb4-283aca08ab0b@hale.ee>
 <CACNzp2kd6wdE6pGsb5d5+cvkJa9M-gzG+5=oLhZr9dLn4o8gOQ@mail.gmail.com>
 <829bc648-dd9a-d166-c36e-3ad1508f0ba5@hale.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <829bc648-dd9a-d166-c36e-3ad1508f0ba5@hale.ee>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 06, 2016 at 10:55:11AM +0700, Tom Hale wrote:
> On 2016-10-03 00:00, Anatoly Borodin wrote:
> > I've reported this one bug recently:
> > 
> > https://public-inbox.org/git/nrmbrl$hsk$1@blaine.gmane.org/
> > 
> > The developers know about it, but it will require some deeper refactoring.
> 
> Thanks Anatoly for reporting this.
> 
> [Meta] All: For updates, is there an issue I can watch, or a way to
> subscribe/monitor only this one thread?
> 

public-inbox.org provides an atom feed[0] which you could add to a
reader.

I don't think you can just subscribe to a single thread in the mailing
list, but you can ask to be cc-ed in that thread.

[0]:https://public-inbox.org/git/nrmbrl$hsk$1@blaine.gmane.org/t.atom
