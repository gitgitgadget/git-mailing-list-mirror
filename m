Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,URI_HEX shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7CD71F51C
	for <e@80x24.org>; Tue, 22 May 2018 15:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751674AbeEVPBV (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 11:01:21 -0400
Received: from n2.nabble.com ([162.253.133.85]:52422 "EHLO n2.nabble.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751656AbeEVPBU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 11:01:20 -0400
Received: from n2.nabble.com (localhost [127.0.0.1])
        by n2.nabble.com (Postfix) with ESMTP id 3DF1245525D2
        for <git@vger.kernel.org>; Tue, 22 May 2018 08:01:20 -0700 (MST)
Date:   Tue, 22 May 2018 08:01:20 -0700 (MST)
From:   curlUser <suga18@gmail.com>
To:     git@vger.kernel.org
Message-ID: <1527001280208-0.post@n2.nabble.com>
In-Reply-To: <alpine.DEB.2.00.1311272237400.17037@tvnag.unkk.fr>
References: <5291F70A.7070508@googlemail.com> <20131124133356.GA3507@sigill.intra.peff.net> <529214D7.1030203@googlemail.com> <20131124155439.GA8047@sigill.intra.peff.net> <52922A22.2090109@googlemail.com> <20131125063945.GA16313@sigill.intra.peff.net> <alpine.DEB.2.00.1311250815150.27300@tvnag.unkk.fr> <20131125143213.GA22642@sigill.intra.peff.net> <20131125144321.GA23779@sigill.intra.peff.net> <alpine.DEB.2.00.1311272237400.17037@tvnag.unkk.fr>
Subject: Re: [curl PATCH 2/2] ignore SIGPIPE during curl_multi_cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We may not be able to upgrade to 7.60.0 any soon, 
Is the fix present in 7.45 , in this sequence of code. 
Please let me know. 



--
Sent from: http://git.661346.n2.nabble.com/
