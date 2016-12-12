Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99815206A4
	for <e@80x24.org>; Mon, 12 Dec 2016 14:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbcLLOFR (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 09:05:17 -0500
Received: from mout.gmx.net ([212.227.15.19]:62123 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751774AbcLLOFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 09:05:16 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MJjvw-1cFKlS0h9g-0017gp; Mon, 12
 Dec 2016 15:05:06 +0100
Date:   Mon, 12 Dec 2016 15:05:05 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Klaus Ethgen <Klaus@Ethgen.ch>
cc:     git@vger.kernel.org
Subject: Re: [BUG] Colon in remote urls
In-Reply-To: <20161212115030.qx2y276bxnzbtxkj@ikki.ethgen.ch>
Message-ID: <alpine.DEB.2.20.1612121453020.23160@virtualbox>
References: <20161209140215.qlam6bexm5irpro2@ikki.ethgen.ch> <20161209152219.ehfk475vdg4levop@sigill.intra.peff.net> <88bed7c9-4d5d-45d5-5d13-6a8ae834e602@kdbg.org> <20161210093230.26q7fxcrs2cpll6g@ikki.ethgen.ch> <alpine.DEB.2.20.1612101918040.23160@virtualbox>
 <20161211110208.642unp7c2i653sav@ikki.ethgen.ch> <alpine.DEB.2.20.1612121133220.23160@virtualbox> <20161212115030.qx2y276bxnzbtxkj@ikki.ethgen.ch>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:npevtsOyA0CME7rgE4PKaS0OWAuIuEKenxOFhIVCj4waEANrsMJ
 Bepw7QXF/ABPCRySMDio8FknsjsaqekvdXmoYNdzskh5GTIoTkBKk3A6drkGZ+q2TY0SWbv
 nxY1JG8jMTiG65eNyrTVIX6LT6xZjhdqnuTXgwq16v+CJTM/nWm3YlGfUSgeAmM3yIe5gcO
 SEV4NrMwYBPd9fTOL2rrQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pGodnjFKNLE=:HmSprcKyZJl+v2PhewxQGt
 v+49LId5rSMpOYhsXzbBVNvcARpw7CiP+IDss15pAHmZ4oGXpYDs4zY2rGQxbCLyR/roVwKOq
 /XMtx5R73eEoAVJxXhBz1NIhujvlr1OAMsWdJtpfRUngTocHMq0qmT7nswksf9B8bFapEr82U
 QEqIS+qbTLeuape319n8U0h89sP6S2a5v/0jkdwV8f+aziqLuHBjI6bNr0eK+qszOQ5aBzotn
 1NvbcCj6SX9izoT41mEI3Eu4C1pIZbeIZ3xQ74AeiCyxxCLg1+Hq4dl/8sRijqZ9d8luvYAvn
 yd/D3xw03h+fS5vc1YgsduZyoQAncklRPB40MAIMYWxoS2zzRzbM9OdVi847nnUz+qf1LPkhb
 UXzFyC4PTVXDpCHLdo2n4wst2MrA4OD0koEh62yi8nYYPtVdkKMy77U0QN4J/Y5t3oGXos/BU
 DL/PO7s+ACDrMTn8gh2owOa7YugTE+Ynsjg9eivH5g+GCSxCRIODz72zRClHH+YdaZESaWSXE
 s7OZBZf3HwFLzBwCX7ayzq1LxDa4qEuAIjy5OiDTj68Uqz6Cu/3EZugbA9G4srfCDenFWiLAX
 RlRdplsHwPy6NLs3g0jNSLqDDMIN5w2csGxbVmPJkpoZS1VO/676hqIG09ymRFpGK5+L+n6ZL
 CuCtPyM7SDSkm59wxG2+IVqKYoxj9SRVldb2/4xC3Qg2pfDz0oIKNRDAs6OhtvzrIaMU3PTn0
 hBwfzJI201/SyMednMBFI+5NyNrlQXm6BRkT7luyUsA8R97e7BDNtLuWMbRUSDCPFypXagWTw
 V9iXh2w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Klaus,

you probably missed the note about reply-to-all being customary on this
list. The reason is that this list is high-volume, and open to
non-subscribers. You may want to get into the habit of hitting
reply-to-all when responding to mails from this list, in case that you
plan to continue communicating on this forum.

On Mon, 12 Dec 2016, Klaus Ethgen wrote:

> Am Mo den 12. Dez 2016 um 12:03 schrieb Johannes Schindelin:
> > On Sun, 11 Dec 2016, Klaus Ethgen wrote:
> > > Am Sa den 10. Dez 2016 um 19:18 schrieb Johannes Schindelin:
> > > > On Sat, 10 Dec 2016, Klaus Ethgen wrote:
> > > > > Am Fr den  9. Dez 2016 um 22:32 schrieb Johannes Sixt:
> > > > > > There are too many systems out there that use a backslash in path names. I
> > > > > > don't think it is wise to use it also as the quoting character.
> > > > > Well, the minority, I believe. And only the minority where the command
> > > > > line git is used anywhere.
> > > > Please provide evidence for such bold assumptions.
> > > How is it "bold" to see that the majority of widows users does not use
> > > or even like command line tools.
> > 
> > Second, you still did not back up your claim with anything resembling
> > evidence, instead just reiterating your beliefs. That is not good enough.
> 
> Well, my evidence is what I seen with many windows users in the past. I
> have no link or something like that. I just shared that observation.

Thank you for confirming that you just shared a personal observation and
did not plan to back that up by scientific evidence.

In light of that, let's continue according to Johannes Sixt's insightful
suggestions.

Ciao,
Johannes
