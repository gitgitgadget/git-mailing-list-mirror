Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1575207EC
	for <e@80x24.org>; Sun, 25 Sep 2016 07:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422779AbcIYH0q (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 03:26:46 -0400
Received: from mout.web.de ([212.227.15.4]:53721 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422767AbcIYH0p (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 03:26:45 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0LwYtb-1at9DX3o9X-018O7i; Sun, 25 Sep 2016 09:26:36
 +0200
Subject: Re: [PATCH 6/7] use COPY_ARRAY
To:     Git List <git@vger.kernel.org>
References: <6f402d35-b483-7552-2fb2-a5350112b8a6@web.de>
 <869cff97-9e5f-ec17-6b64-bd1e4d9d1947@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Newsgroups: gmane.comp.version-control.git
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <0428ceee-8761-1840-f769-26597c14f09b@web.de>
Date:   Sun, 25 Sep 2016 09:26:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <869cff97-9e5f-ec17-6b64-bd1e4d9d1947@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:XsDxSWVP8SYc2yUWJuc8zKKFcxZEqun+YJQoX2hjD/9DZrIs2KO
 j1T9+EWrFVfppDn1GbKjNKSAt73WrcNBFnGDBevm2ihIFHo+gEBGTxTBimwZF3Y4PyJ3aXy
 dGwR1fMJLdE/10zvKDqORBBQGVskRmHNp26NPFSN13C8OmXlrA4hNj8FRwTikVboeWr6FqX
 b7aXm98CFjkKFEoHt9cFg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:A8TDlS371fA=:55+Y6rixG0vXROXK+W7jIN
 YV8NKt+qaaJ4YIbdoCJILQDuFSBE99ColFZkTqkDC3FhYbTDeibyAU+3sCRMY27dgKPNlx81K
 Y6GZkse1EMCFK8AN4L9kf/qZn9AELx93n4MOxHMh22P2D/23HZdIESmkky0gynKEb/ypJ8OW+
 HX50ZBike20GhokkRq0/B30SYKZq6AyUaM7f5WhogC45JFhPyvdInPkN0GW7LEWSe31tDMLjS
 rAHp+bgIkb8dqjM2VIcoQ8vIa/Rz6AKnH5Elgptr6Zpov0ZrJC0AHO31PQawGkD5m3OzbIXwG
 FFkt6znZvC+VjNSypTBQ99V6Fr0rVrkaPFaDY9Pyttjz1uAxg/6zx+FEowyyHabiIyYSkG23g
 mFvmqtI3sVS55MUp4TO0vhidUIm2diM8dJdudDNiCvz7l56nfKMvFzMv4fzGRFi6g8PzMivho
 7jtSsHYM/xlDVGBNPPxoJcLGJId7m5YTb2tCMkaWRzZGiGm5bpt3y3Im2REpd06hivVYgfLgC
 OC3WOidxZOHEVOJuTW0ZC1KC/IdZAb6XE/h6vc3Qa0KJSkSxK5tmsBl2mnyuMIQ3JGY+82ykU
 CMp0Yao6+KWGP0HIGoyvkQNNhNBchsANMzP/pWHwp3r5zuiRUzxyhgDKh3qmZ3j/vdhOEEE21
 mBhoGt6nzeGAXT0j58xn2n6GDmKO7pym626eA0VhlyUPzh9etTfl5QABKNYfN/+NLi8qcFAz9
 d/H2PnKT7A52BfxLjsQVDOVmj9t5SC5kYjCa5w5bGQc2kx3pTAACpjvD1lYCVUVh2ilPUAk9r
 cYSOHtb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ha, can't count.  It should be [PATCH 2/2] of course.

René

