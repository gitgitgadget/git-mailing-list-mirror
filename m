Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A71651F462
	for <e@80x24.org>; Thu,  6 Jun 2019 22:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfFFWop (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 18:44:45 -0400
Received: from resqmta-ch2-04v.sys.comcast.net ([69.252.207.36]:57210 "EHLO
        resqmta-ch2-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726786AbfFFWop (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Jun 2019 18:44:45 -0400
Received: from resomta-ch2-19v.sys.comcast.net ([69.252.207.115])
        by resqmta-ch2-04v.sys.comcast.net with ESMTP
        id YrLQhtR2dwgtlZ17lhnYY1; Thu, 06 Jun 2019 22:44:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1559861085;
        bh=aSSk+3k6RTtrm8FwToELcxwu/HLtyvPdgohwVq8H52s=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=ai9fX04GJcxQVTgyknak22kLph2bef0JACLKNpsvTrU57GKbwWZ+fU+f4qtPurGd6
         axg35jYofGhRT9xc01j1/tdIkgu+xSUlNYSC3G0xIfjsgPcj8DHXONYlPPlRj+3+LJ
         L+EfE3gM5s++CJ8pE0IIFceyCWj2TlBhtOQx/hHfapC3bj5fCaJvOcgfBHsYwmC38G
         iuWCf3763RnvvxNVfOqsMyd9DmLDj6HpgJhFhwP4isiL6VYy1tZxA7EZnrdolZvoff
         K0m/oULAqwGnhwZYd66q7vy8cB9JfUF8KYW7G9b2Z2Uywlgv28PD1y4qSgYKQaLAqb
         rMRH0MZbv2USA==
Received: from comcast.net ([IPv6:2620:15c:2ce:200:fd28:a9c3:fb88:6b87])
        by resomta-ch2-19v.sys.comcast.net with ESMTPSA
        id Z17KhxH0WsHnBZ17PhOvEw; Thu, 06 Jun 2019 22:44:42 +0000
X-Xfinity-VMeta: sc=0;st=legit
Date:   Thu, 6 Jun 2019 15:44:18 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Matthew DeVore <matvore@google.com>
Cc:     jonathantanmy@google.com, jrn@google.com, git@vger.kernel.org,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com
Subject: Re: [PATCH v1 0/5] Filter combination
Message-ID: <20190606224418.GB7246@comcast.net>
References: <cover.1558484115.git.matvore@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1558484115.git.matvore@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you are looking for the latest version of this patchset, it is here:

https://public-inbox.org/git/20190601003603.90794-1-matvore@google.com/

But also has these interdiffs:

https://public-inbox.org/git/20190604234951.GB43275@comcast.net/#t
https://public-inbox.org/git/20190603222247.GG4641@comcast.net/
https://public-inbox.org/git/20190604225921.GA43275@comcast.net/

Sorry for not making v2 a response in this thread. Later versions will be
posted as responses to v2 (the first link).
