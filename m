Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FD5A1FD99
	for <e@80x24.org>; Sat, 20 Aug 2016 21:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753339AbcHTVgW (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Aug 2016 17:36:22 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:50958 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753111AbcHTVgV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2016 17:36:21 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id A04331FD99;
        Sat, 20 Aug 2016 21:29:37 +0000 (UTC)
Date:   Sat, 20 Aug 2016 21:29:37 +0000
From:   Eric Wong <e@80x24.org>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     git@vger.kernel.org, Doug Rathbone <doug@dougrathbone.com>,
        David Bainbridge <david.bainbridge@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC] Proposed questions for "Git User's Survey 2016"
Message-ID: <20160820212937.GA20555@starla>
References: <91a2ffbe-a73b-fbb9-96da-9aea4d439e5a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91a2ffbe-a73b-fbb9-96da-9aea4d439e5a@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Narębski <jnareb@gmail.com> wrote:
> #### Other version control systems
> 
> 20. What other version control systems (SCM) do you use beside Git?
>    (multiple choice, with other)
> 
> Explanation: "using" version control system here means using
> it to actively contribute (propose changes or accept proposals),
> and not only e.g. using it to download software.
> 
> JN> Perhaps we should split it into two questions, one about
> JN> centralized version control systems, one about distributed
> JN> ones.

Perhaps there can be a question about use and interest of other
decentralized/federated systems which could be potential
collaboration tools or transports for git.
e.g. ipfs, gpg, tor, diaspora, *coin, tent, xmpp, matrix, ...

And another about how they use email: webmail, GUI client,
console client, phone app, none at all.
