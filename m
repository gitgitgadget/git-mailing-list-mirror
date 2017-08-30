Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EBF3208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 11:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751316AbdH3LB0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 07:01:26 -0400
Received: from ikke.info ([178.21.113.177]:34418 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751263AbdH3LBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 07:01:25 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 6A237440216; Wed, 30 Aug 2017 12:55:19 +0200 (CEST)
Date:   Wed, 30 Aug 2017 12:55:19 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        sbeller@google.com, gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [RFC 5/7] http: send Git-Protocol-Version header
Message-ID: <20170830105519.GH3839@alpha.vpn.ikke.info>
References: <20170824225328.8174-1-bmwill@google.com>
 <20170824225328.8174-6-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170824225328.8174-6-bmwill@google.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 24, 2017 at 03:53:26PM -0700, Brandon Williams wrote:
> Tell a serve that protocol v2 can be used by sending an http header
> indicating this.

s/serve/server/
