Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3EB31F406
	for <e@80x24.org>; Sat,  9 Dec 2017 13:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751251AbdLINIQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Dec 2017 08:08:16 -0500
Received: from ikke.info ([178.21.113.177]:54614 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751195AbdLINIP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Dec 2017 08:08:15 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id F01984400D4; Sat,  9 Dec 2017 14:08:13 +0100 (CET)
Date:   Sat, 9 Dec 2017 14:08:13 +0100
From:   Kevin Daudt <me@ikke.info>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Takashi Iwai <tiwai@suse.de>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 0/5] SHA1DC fixes & fully moving to a git.git submodule
Message-ID: <20171209130813.GF6006@alpha.vpn.ikke.info>
References: <20171128213214.12477-1-avarab@gmail.com>
 <20171208223001.556-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171208223001.556-1-avarab@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 08, 2017 at 10:29:56PM +0000, Ævar Arnfjörð Bjarmason wrote:
> Here's v2 as promised. Comments per-patch.
> 
>   sha1dc: remove in favor of using sha1collisiondetection as a submodule
> 
> Reword & expand commit message.

Is this commit missing from the mailing list because the e-mail is too
large?

