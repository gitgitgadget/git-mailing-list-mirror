Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E9A51F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 22:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933053AbeGHWW6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 18:22:58 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:48462 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933001AbeGHWW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jul 2018 18:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1531088788; bh=xtdHna34+uyc6XyETfySyY7upJz6djtjyLyAB7CV2dc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Bx6MLE8dVr0HQ2iEVpIWaXks7GALqIX2GBcy/qf0HD5NkXmoI6FmEinu55h5pXLXF
         8O8c/t6CeGU+GQV7TcmmgseUea2W5Le22HWgGKfv17o0+pF77DKAjp4zpKTV2fF42h
         DssdNYeaZpHaCI+IZtJBH/UOxNRcdE2vS7KuBKfg=
Date:   Sun, 8 Jul 2018 18:22:54 -0400
From:   Drew DeVault <sir@cmpwn.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/4] Automatic transfer encoding for patches
Message-ID: <20180708222254.GA10282@homura.localdomain>
References: <20180706022357.739657-1-sandals@crustytoothpaste.net>
 <20180708221713.518276-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180708221713.518276-1-sandals@crustytoothpaste.net>
X-GNU:  Terry Pratchett
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

LGTM, thanks for the v2.
