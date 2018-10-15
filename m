Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34B8E1F453
	for <e@80x24.org>; Mon, 15 Oct 2018 08:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbeJOPxX (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 11:53:23 -0400
Received: from mout.gmx.net ([212.227.15.19]:46727 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbeJOPxX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 11:53:23 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MK0Np-1gB8zL3ugH-001RM2; Mon, 15
 Oct 2018 10:09:11 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MK0Np-1gB8zL3ugH-001RM2; Mon, 15
 Oct 2018 10:09:11 +0200
Date:   Mon, 15 Oct 2018 10:09:13 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     Git List <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (Friday, Oct 12)
In-Reply-To: <e30a9c05-87d8-1f2b-182c-6d6a5fefe43c@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1810151007430.561@tvgsbejvaqbjf.bet>
References: <e30a9c05-87d8-1f2b-182c-6d6a5fefe43c@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zHCPOPemwSAtyLiDKmyVLdr4cz/bYCuWB3jFpi+73pYtq68Vs8q
 A4d1VNJPFL9Wr9Nr407mdtdFrT+cZwad2pwHk/ki5vLsr3KQbtHU3vG8wpyNjuXBnKpvMy3
 KRzNBvIs8gf395Pjwatu80zyeQAmBCKf4c8fVlGBCz8Vvkmv+2fr7v1Iku67Mp5Pi3Hijy6
 epxLwchT0i4FLp9rDlASw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Kl61BDUIh60=:nhSHVHgJH4CJzxcUc+Ddn+
 eNs0eVUTfFUYbSnVuezuHmW/qoV1/LZx5x07FaL3s6YyTKLusHvh3+ByMn6ljkIxJzDBPONca
 tAYtFeFY+XgvJm2s/ZXfcvFBonffrcx8b6kW3uoT3tcDl3/rt5txQf8YzzRKqNwO94Jk+DpA3
 kmjUDYHj7lCujtY8dgSb/ZdslXalByaU+KuTFrFnHtcXM4b3VFLxV4qSO/M9hd2i7dJQovEpC
 1bYSoyPHP2XEN0S+PeRdExwhsytZvkLZtohzx/FR+viqHXiflt109bO/Qv/HJuupDwDtzfY59
 wNHTLH6+jxOapEgqrZFfrwEws6xyHsQSROQsvrCqLPA1o+Rzkzv8wezyuL2V0K+Ng3k0pZ+jm
 kNReHGCktfXoVeiZEO2KUzYz6EVgHa2WksOPQrwOjy/AHDP7ZC6ZW7nHNNVfoqbOzqaVvxZee
 0wsVpndS0BRjgDr/bIrprOt/sxoRWMfd0T6tui+UxnQAkY1SKpIbxoyVTXjMZmAhI5ikIV+f+
 +MDSnwND0ElA1sR8jxz+ebAB5HTmqquz79f0wexdqx0gk/bbGFqnfpaXl5hBpva5TZhq+bpC2
 MIRv93RtQU7LEOJezXZJIbLidQjz6swygz1YRRkI8d37Y9RHZM9NqzuRMbl/2hbtpAYSfzwRW
 kEvoq5gKx9g/ULWydg72WlZSVMgg50HSK3UFdQJpZQWvoFeVJ7+y9eLdXUeDSOLBbdk08Wc6q
 E6rhLv2KtIE8HotVNCoH6QjS5ZK2vCc7jaju9qaj/yIiIHspcBZX/RUElBOrdj3nUaHqM2Ofc
 R+VMnj64Js1FlthIh2IGWtXyonY1lh5ZF7Xc/YZ3COa9DXiGkk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Fri, 12 Oct 2018, Derrick Stolee wrote:

> 
> In an effort to ensure new code is reasonably covered by the test suite, we
> now have contrib/coverage-diff.sh to combine the gcov output from 'make
> coverage-test ; make coverage-report' with the output from 'git diff A B' to
> discover _new_ lines of code that are not covered.

Thanks for doing this. I do notice, though, that there are a few mentions
of BUG() lines, e.g.

> 0af129b2ed builtin/rebase--interactive2.c 267) BUG("invalid command '%d'",
> command);

I do not think that we will ever want to ensure that all of these lines
get code coverage ;-) Maybe it would be possible to exclude those lines
from the analysis?

Thank you,
Dscho
