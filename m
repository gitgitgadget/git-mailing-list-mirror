Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C90F1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 07:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbeIDLes (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 07:34:48 -0400
Received: from ao2.it ([92.243.12.208]:54006 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbeIDLes (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 07:34:48 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fx5SP-0000Y8-DT; Tue, 04 Sep 2018 09:09:01 +0200
Date:   Tue, 4 Sep 2018 09:10:59 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Daniel =?ISO-8859-1?Q?Gra=F1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 1/9] submodule: add a print_config_from_gitmodules()
 helper
Message-Id: <20180904091059.3474f58873f82f4e160e06aa@ao2.it>
In-Reply-To: <20180824185251.be9374239a7a9ec0a796afe7@ao2.it>
References: <20180824132951.8000-1-ao2@ao2.it>
        <20180824132951.8000-2-ao2@ao2.it>
        <87wosfesxl.fsf@evledraar.gmail.com>
        <20180824185251.be9374239a7a9ec0a796afe7@ao2.it>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 24 Aug 2018 18:52:51 +0200
Antonio Ospite <ao2@ao2.it> wrote:

[...] 
> I'll wait for other comments to see if a v5 is really needed.
> 

Ping. In case someone missed v4.

Thanks,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
