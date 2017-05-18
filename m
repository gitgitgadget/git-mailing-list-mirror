Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17FDA2023D
	for <e@80x24.org>; Thu, 18 May 2017 09:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754756AbdERJkl (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 05:40:41 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:48857 "EHLO
        zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbdERJkk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 05:40:40 -0400
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Thu, 18 May 2017 11:40:40 +0200
  id 00000000000000AD.00000000591D6C18.000021CA
Date:   Thu, 18 May 2017 11:40:38 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     Manish Goregaokar <manishearth@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/2] refs: Add for_each_worktree_ref for iterating
 over all worktree HEADs
Message-ID: <20170518094038.x3xvpsfte3zxpuqd@ruderich.org>
References: <CACpkpxkGWhcALQZ2+2nOCRKgzAa7U7EjZg--S71zocdGY8NYag@mail.gmail.com>
 <20170518014210.94189-1-manishearth@gmail.com>
 <CACpkpxn1D_g=im0um4ncLiq3A18HRPpfu-sb1FLoY__tet0--Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <CACpkpxn1D_g=im0um4ncLiq3A18HRPpfu-sb1FLoY__tet0--Q@mail.gmail.com>
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 06:45:31PM -0700, Manish Goregaokar wrote:
> Hm, my invocation of git-send-email keeps getting the threading wrong.
> Is there a recommended set of arguments to the command?

The threading looks fine here (for both cases where you mentioned
it being wrong). Why do you think it's wrong? How does it look on
your end?

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
