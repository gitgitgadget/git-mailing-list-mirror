Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19722208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 16:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeHHSav (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 14:30:51 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:52730 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727386AbeHHSau (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Aug 2018 14:30:50 -0400
X-IronPort-AV: E=Sophos;i="5.53,458,1531778400"; 
   d="scan'208";a="341852838"
Received: from zcs-store5.inria.fr ([128.93.142.32])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Aug 2018 18:10:22 +0200
Date:   Wed, 8 Aug 2018 18:10:22 +0200 (CEST)
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     jrnieder <jrnieder@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git <git@vger.kernel.org>,
        Antoine =?iso-8859-1?Q?Beaupr=E9?= <anarcat@debian.org>,
        Matthieu Moy <Matthieu.Moy@imag.fr>
Message-ID: <1760070169.15343864.1533744622227.JavaMail.zimbra@inria.fr>
In-Reply-To: <9a96cf8f5254446fa244e4107cef4f3c@BPMBX2013-01.univ-lyon1.fr>
References: <"https://public-inbox.org/git/20180730190612.GB156463"@aiede.svl.corp.google.com> <20180730204646.32312-1-sunshine@sunshineco.com> <9a96cf8f5254446fa244e4107cef4f3c@BPMBX2013-01.univ-lyon1.fr>
Subject: Re: [PATCH] mw-to-git/t9360: fix broken &&-chain
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [91.68.56.209]
X-Mailer: Zimbra 8.7.11_GA_2095 (ZimbraWebClient - FF61 (Linux)/8.7.11_GA_2095)
Thread-Topic: mw-to-git/t9360: fix broken &&-chain
Thread-Index: AQHUKEjxSIzIKWSJNkOLKqj1i5aV5lHeMomJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"jrnieder" <jrnieder@gmail.com> wrote:

> (+cc: some folks interested in git-remote-mediawiki)

Thanks.

In case it still matters, an obvious Acked-by: Matthieu Moy <git@matthieu-moy.fr>

-- 
Matthieu Moy
