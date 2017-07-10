Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5174202AC
	for <e@80x24.org>; Mon, 10 Jul 2017 10:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753173AbdGJKK6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 06:10:58 -0400
Received: from ikke.info ([178.21.113.177]:59238 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752457AbdGJKK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 06:10:57 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id DB06C4400B1; Mon, 10 Jul 2017 12:10:55 +0200 (CEST)
Date:   Mon, 10 Jul 2017 12:10:55 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Andre Hinrichs <andre.hinrichs@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Small typo in german translation
Message-ID: <20170710101055.GA13190@alpha.vpn.ikke.info>
References: <f11120c3-30fb-bdfe-a597-8ceb41097209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f11120c3-30fb-bdfe-a597-8ceb41097209@gmx.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 10, 2017 at 08:47:23AM +0200, Andre Hinrichs wrote:
> Hi Git-Developers!
> 
> I've found a small typo in git/po/de.po
> In line 8567 the word "erwzingen" should be "erzwingen".
> Please fix.
> 
> Thanks
> 

Hello Andre,

The best way to get this fixed is to make a pull-request on the German
translation team repo[0].

Kind regards, Kevin

[0]: https://github.com/ralfth/git-po-de
