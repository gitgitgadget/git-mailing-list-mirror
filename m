Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 416321FAAD
	for <e@80x24.org>; Fri, 27 Jan 2017 03:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753928AbdA0D5z (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 22:57:55 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:53944 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753487AbdA0D5y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 22:57:54 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 41B2A1FAAD;
        Fri, 27 Jan 2017 03:57:53 +0000 (UTC)
Date:   Fri, 27 Jan 2017 03:57:53 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: vger not relaying some of Junio's messages today?
Message-ID: <20170127035753.GA2604@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed both of these are are missing from my archives
(which rejects messages unless they come from vger):

<xmqq1svp7lcs.fsf@gitster.mtv.corp.google.com>
<xmqqefzp1d1x.fsf@gitster.mtv.corp.google.com>

https://public-inbox.org/git/20170125234101.n2pzrp77df4zycv7@genre.crustytoothpaste.net/#r

I only have them because I was Cc:-ed.

gmane doesn't seem to have them, either:

nntp://news.gmane.org/xmqqefzp1d1x.fsf@gitster.mtv.corp.google.com
nntp://news.gmane.org/xmqq1svp7lcs.fsf@gitster.mtv.corp.google.com

Not sure if there's something up with vger or Junio's setup because
other messages (even from Junio) are getting through fine.
