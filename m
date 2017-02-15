Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ED412013A
	for <e@80x24.org>; Wed, 15 Feb 2017 14:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751644AbdBOOHy (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 09:07:54 -0500
Received: from mout.gmx.net ([212.227.15.15]:61413 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751702AbdBOOHn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 09:07:43 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MX16a-1cq1M63vuO-00VvSR; Wed, 15
 Feb 2017 15:07:07 +0100
Date:   Wed, 15 Feb 2017 15:07:06 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Christian Couder <christian.couder@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        git-for-windows@googlegroups.com, git <git@vger.kernel.org>
Subject: Re: [git-for-windows] Re: Continuous Testing of Git on Windows
In-Reply-To: <CAP8UFD1+AgBVqSh=wHteM3uKO+55ZqqD4cHzBUfN0KTPXyvutQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1702151506250.3496@virtualbox>
References: <alpine.DEB.2.20.1702101241210.3496@virtualbox> <xmqq60kdbqmy.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1702142150220.3496@virtualbox> <xmqqd1ek8oqo.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD1+AgBVqSh=wHteM3uKO+55ZqqD4cHzBUfN0KTPXyvutQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lrdwH0m7eGGzurxoRSiu7KaA2DG+IlmBWHqylcPg8aP/Wjq6z7Q
 C5PJJNp+3NjavnIaj6+Y8hcHnw+AdRs0MM3l123orvnaLjaWmZO8jUrkVVzjDRW7DYVbAOo
 jAvkNhpa8pdNlns3+G+Wyz15HfHcRPOWY9jB58AyRn7iS+F0e7E4ZNIRXZhdSvtxSm0GA8r
 T4x+O/VY2d4XbHSEeDlDQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QZGjHL+wwQ4=:qwbM9Qx5KtlOAQ8pL/KIWn
 G9M0JS/xaFqVMHCX44GfdEDkKKC1pqGGvwMu9/8QAkCkSrFtjWC2cD+pCp1DlRjA3JqIXZv41
 wGKiZ4sHYwCfGZpLrpOAoO/RpWC/V6AqHeu4vwZDpSJRlfRnlHHCN4dnAUrcUy3BPKUpitkxL
 Int2syir/G9vxIFB3rF/V9H6ghL9RyuFjnHIe4q6WYzBui/+/KZboqzI7Do/rnQToLiAMZLqs
 Mht0tpNlYwB2Pg1KR5rSRcgNQK6aDGtvcmLhtfQ/DHYZ3s2Jkhgtm1nxJUOLxEl0AwHEcKD7v
 EwD5vtS/IyvBtAmXi7fz8l9DOxCNGAgSvJi2wL7i8NRz/JnuH+kjdgx5hxo4A+5QEn0bKWuBy
 DDZBPoeDMWuCJJUxZDquU4DqGsRvgvB/XQWYCadcvVTxQ1bw6h4de2iboEVtjcI8kZQaGBC90
 wTW/1vVa4djQNpBTNcmLVyJmqabeeABLBiUu1PWfpsHYWu+seu8KRuCIphh3tlbl4JjRbgkQU
 eMV5gIpZd874ZvOTQZL5qStSu6ly1GBf3UengVYNQFvfcjVFBzWZHFISLHoSWbQ9i3XQo0tHX
 d2lOw8kMgtpAMYlJ2RFNNFlP5X0sWGm4LtNhSJeCta6nvKkMdr5Bej5uH+RbvDUbm9Hska1WY
 Tz8RE6JpxMLVip6/UxVw/GE0d4Y7PS4IePN+d2IOeQp1tbIFx7yFvf0gmjbjG+8VSsxTDNktm
 JEiHE8Zl1fjHBjTZGJ0/Hu/+f0drHOvQWEEEYNCJ5QTUmmYZ2SQvsFUCJ8z2wT9PSyBWO3w1h
 VAsbpzw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On Wed, 15 Feb 2017, Christian Couder wrote:

> On Tue, Feb 14, 2017 at 10:08 PM, Junio C Hamano <gitster@pobox.com>
> wrote:
> 
> > Probably a less resource intensive approach is to find the tips of the
> > topics not in 'next' but in 'pu' and test them.  That would give you
> > which topic(s) are problematic, which is a better starting point than
> > "Oh, 'pu' does not build".  After identifying which branch is
> > problematic, bisection of individual topic would be of more manageable
> > size.
> 
> It is still probably more resource intensive than it couls be.

Indeed.

Ciao,
Dscho
