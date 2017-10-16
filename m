Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8B2E1FF32
	for <e@80x24.org>; Mon, 16 Oct 2017 10:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbdJPK5b (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 06:57:31 -0400
Received: from mout.gmx.net ([212.227.15.18]:63799 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751358AbdJPK5b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 06:57:31 -0400
Received: from virtualbox ([95.208.59.105]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LgHvY-1dPEcu1xv2-00nleE; Mon, 16
 Oct 2017 12:57:28 +0200
Date:   Mon, 16 Oct 2017 12:57:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Steve Hoelzer <shoelzer@gmail.com>
cc:     git-for-windows@googlegroups.com, git <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git for Windows 2.14.2(3)
In-Reply-To: <alpine.DEB.2.21.1.1710151710340.40514@virtualbox>
Message-ID: <alpine.DEB.2.21.1.1710161254430.40514@virtualbox>
References: <20171012225339.2808-1-johannes.schindelin@gmx.de> <CACbrTHfnph8Cp9G7LrspPa4s-E2ATHWkLqj7WDPFSiLXzOSz7g@mail.gmail.com> <alpine.DEB.2.21.1.1710151710340.40514@virtualbox>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:w1IrJMXYAuFSax+jDnzr3xJHP3PiGG9CKdnIU7GDuRTTDI44OIy
 a6I5IJVQVyxx/KqKtsPJIy8Py7j6OG3aQKRxhWYlTS/dB6H8YfYksZ8BohB7LskKAmSFkfB
 Ha+sa5oJbrQmi8+aVT2Q8OtUR7AXDNzpHdiz/jjXPuejXzobXWzomPH6u2txD6Bo4z7xnCF
 ODr4Yvmv/jKwh0KNT0XNw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:u3D9eEJS/oU=:KkCu7UieVfNM/y3xqXwTbV
 J+deXWVTbGUTmBIicdgShe07ZEd0NGjOT+bFvXhD+I0whUXn4GkUyd1ZbHlpBhfkE8wjksR7L
 JT6h5rqYFHMTcWwhX1/a5TOAH30QyJl5mn9Clb/gpTREajwbPHYol9NDBJhtmXgFXeZfmBIXW
 Pf2BN12LSt9r2/bRtCpTXq4epw1qiSaZprkCR0qyli99iypuM5blym7nKiQltsJPyBgKyGOck
 DvckPg8s7oBmadxD97eT0d0NJUZSba2qjZGtNG8fGfZ0M3nUvvBUND6hRIC2LBTGP2ltlLK96
 6axfJtNR/acPhLdV//gv5a6wEdHyW2I+tNsG0QIVNwRX6Z6EBupMc5PayDrkWM/Ik/oIMQ+YJ
 LMriWFdMnOwfTNpkonrwKL0tfiYarsk2nSWpI5RUz1MaiFSBp4WPRhMPDPO1/WaNPFWfkL9dr
 /p6ZUCQH/AnIg5kOqVYY8DF/fC/aRaL/oUiMVtTfhqgS9xNgKzslAYa0zRdewR88YMdmVYTKP
 /90kYyOt9VUZXKDW9ow2Yz8bdnUZGxKepL/QLRqDAE4XppvrZgCMEMHLj5CiECtc0ucjHz/Av
 KZTmePz87rUbNFTxN6BAKDLAEokJLSDPzPb0czfXMCWBiaO53c9e4ckU85nNvNdSeWGZcb2In
 2RW3YFWBAweLLRoY2tKYBpCNLGmFaETOIDHW6S887lTL9BywVJtinEQbWe/Sg4/Z1c8b37dav
 ETzBttoxOUVaivYUEP72so7s8elaLnp+UnUb4dnAds1pNHuHKJG8hec9fo+cxB9Qn+XT/x8xB
 EF+xav0TzcCr/JUITisdSGOCM7YAQyYL9lir7dWGTq54hX3KSQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Steve,

On Sun, 15 Oct 2017, Johannes Schindelin wrote:

> On Fri, 13 Oct 2017, Steve Hoelzer wrote:
> 
> > On Thu, Oct 12, 2017 at 5:53 PM, Johannes Schindelin
> > <johannes.schindelin@gmx.de> wrote:
> > >
> > > It is my pleasure to announce that Git for Windows 2.14.2(3) is
> > > available from:
> > >
> > >         https://git-for-windows.github.io/
> > >
> > > Changes since Git for Windows v2.14.2(2) (October 5th 2017)
> > >
> > > New Features
> > >
> > >   * Comes with Git LFS v2.3.3.
> > 
> > I just ran "git update" and afterward "git version" reported
> > 2.14.2(3), but "git lfs version" still said 2.3.2.
> > 
> > I also uninstalled/reinstalled Git for Windows and LFS is still 2.3.2.
> 
> Ah bummer. I forgot to actually update it in the VM where I build the
> releases :-(
> 
> Will work on it tomorrow.

I'll actually use this opportunity to revamp a part of Git for Windows'
release engineering process to try to prevent similar things from
happening in the future.

Also, cURL v7.56.1 is slated to be released in exactly one week, and I
have some important installer work to do this week, so I'll just defer the
new Git for Windows version tentatively to Monday, 23rd.

Git LFS users can always install Git LFS v2.3.3 specifically in the
meantime, or use Git for Windows' snapshot versions
(https://wingit.blob.core.windows.net/files/index.html).

Ciao,
Johannes
