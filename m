Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02B301F453
	for <e@80x24.org>; Wed, 23 Jan 2019 10:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfAWKlP (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 05:41:15 -0500
Received: from mout.gmx.net ([212.227.17.22]:33441 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727153AbfAWKlP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 05:41:15 -0500
Received: from [10.49.154.233] ([95.208.58.36]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LeRKD-1hY1Sl1jP3-00qCNn; Wed, 23
 Jan 2019 11:41:10 +0100
Date:   Wed, 23 Jan 2019 11:41:03 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Eric Wong <e@80x24.org>
cc:     git@vger.kernel.org
Subject: Re: testing some changes to a public-inbox .onion
In-Reply-To: <20190121210024.7ywfhke2rwxzjx77@dcvr>
Message-ID: <nycvar.QRO.7.76.6.1901231137040.45@tvgsbejvaqbjf.bet>
References: <20190121210024.7ywfhke2rwxzjx77@dcvr>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:aObkDvauC+ZwAd96w/Xkk0rJJL2l/Y+9h8P44vAND1ahNoI3eoI
 1vhpNq1ibXN2rmvzxwkPW56pFvvhsA5PTGhR3d7X0atL9J7nB7rYwy56bUq0EyjUPHWlLRj
 ubfPDY/Ld8FixPzJWwo7S9LXEfsV+wAFDUsMP3u8AXiYSciI+q8GRjPp0h+ub33nBEvpIbe
 n13FP/IoB9OLdS2aCpp/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lvYtWaaiwig=:a3eekbLNYMK/9x+SgZqPDq
 d8PmC8snsptm5NsEliNpAucV4B7W4gXC0Xv6CvWO7YEBfPVB9+3i4a1cMAOnmfVfMr9mh8mwf
 1MbOYRk7xUFUKdYyfGJLSoCazEQQDjHQ+e4AcvnuXO8920Wphr8gUocS9ZDLu4Wn70qIbA8fb
 qgGom/AAkukHYY0+V54nX0EuxvBg71rQn/u8k0MvH9qECNUvI3L1h5JS4DRTcY9oswlNwG9rP
 PSqILxfXdITCZ/iYBtRNmTaMEKyjjmulSHeEwD15RWZmSpevsZuAn/OWHA3JiEJd0IbUTlexw
 JrY0PJcGTXbgaTyBFmHM3GK+6znkg5b+psfidI+H9zyWIVJEquVItotntARYcuqqGSA7Lp6rA
 4eBO81LclORnHA5momZgE30glkDSKy4sTaBSGAk5R+aIhcvQarIEhIH9k2IilLd5+9IRVmdSl
 YXOsYXSyp5GRvQFp/UMumMxeQQfLZi5VvtaPwQyAfwRYVvVufmT8GFf0dF9XHEjcyAFbeEKyT
 CA1i5DMRVgmbHsBrR3qw/n2iwWuTOQBj4ujDuiXMPZiQLHNgeI07jP63nFt/YYWkfUrCNE/+K
 96VHW+tPFfyS664OmL1FXyNdRuHixk4i4iHYPcXp3GUrHXP+AvJoAUw70l5QDC37G7WrJxwgf
 5RLi50q4bfL/kK41VNZrxVZYPlP5sirxsg8KRpVJY+Gs1Oae8WAoWqTu8JQbbbuuyQjE5kJlg
 Md4pKm8+5Cfx2Rcvoy0cVTJdKLskIvJeqYU72v4E1ke9+1DaBGXze28GQRDI5zhGBk4nI/qDQ
 sdb5d3253UMdHNbFpWyBhhtmgYydnOVMo0wjgCiSuYZMFdQLoz57s+ld4DMHWrwKq6o8gkclS
 bWnxf2AEFcgZEjxn7qpqBdKQe+ylhU72A+JdYfcjkm6M0gxPa7IlPAkLjsRx6bcR8kBK5ap9d
 FKsIydq4Yxw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 21 Jan 2019, Eric Wong wrote:

> WITHOUT reading meta@public-inbox.org, maybe some of you
> can spot some differences :)   You'll need to use Tor
> to access .onions, of course:
> 
>        http://hjrcffqmbrq6wope.onion/git/
> 
> Tested with Netsurf and dillo.

Nice.

Do you also plan on taking care of the regular thread view? I still find
it *very* hard to navigate it, and I have to admit that I am spoiled by
the web UIs I use regularly: an aesthetically pleasing interface does
contribute to my joy.

Thanks,
Dscho

> 
> People with machines powerful enough to run Firefox
> (or Tor Browser Bundle) can use "View -> Page Style" to
> adjust colors.
> 
> Unfortunate downside is current page rendering on the
> server-side is 10-20% slower than before.
> 
> And there's a big fairness problem with the current
> implementation of bl^H^Ha "new feature" :>
> 
> So I'll need to address the fairness problems before I can
> comfortably deploy it on the non-Tor endpoint.
> 
