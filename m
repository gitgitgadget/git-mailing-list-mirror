Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C2101F859
	for <e@80x24.org>; Tue,  6 Sep 2016 11:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753949AbcIFL7N (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 07:59:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:60401 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753186AbcIFL7M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 07:59:12 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MI8iw-1bdNPW3Azu-003swW; Tue, 06 Sep 2016 13:59:08
 +0200
Date:   Tue, 6 Sep 2016 13:59:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Idan Shimoni <idan@grabcad.com>
cc:     stefan.naewe@atlas-elektronik.com, git@vger.kernel.org
Subject: Re: Context Menu is missing
In-Reply-To: <CAFfNYUmH4-Em++kJzdd-V8sDU-OrWp5Qy8kqMtfD7UmaQABg5Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1609061352040.129229@virtualbox>
References: <CAFfNYUmMdamkW=Ca-iRDJ35ucr=S8A_qLTmjoD5j1M_ohdCgSg@mail.gmail.com> <dd6180a8-8719-e87b-26c1-e73d43167f84@atlas-elektronik.com> <CAFfNYUk4QWii7AyG7u2B8G-JGT1Dn0OTopM=FTgaA7DBjYPhfA@mail.gmail.com> <939e5f85-341e-cca5-a818-0e8a43f7a88b@atlas-elektronik.com>
 <CAFfNYUmBaydosF8vYwfj1+px3uUfiH4F=jgdCYBdzEw3-5FUGQ@mail.gmail.com> <89b6f6a2-a793-011b-7351-581be0ee8128@atlas-elektronik.com> <CAFfNYUkUpaCo8uYv=fofPRyCgg7db4M2fh7BJRc4WCHZdbxvsw@mail.gmail.com> <50fc49a6-68a2-040b-beb1-feb162c458d2@atlas-elektronik.com>
 <CAFfNYUmH4-Em++kJzdd-V8sDU-OrWp5Qy8kqMtfD7UmaQABg5Q@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:uAhLgxi/qP+N9RrqmCUsvJToOU9fzLXrfnImQlOC6pRioN7WmNB
 74R7qQCNps5ZNncWR3M5bz7SOvxfGxGmN2OMu2E1/7u3z7haq5ykuntyXpK9qbe34UOdGku
 GkV/QW9D96NB+rqI7q25gPH5HHl9qbG47rHGFfEqNfeDCgMpUWomw0NnW+/AgyhcX9ddrqo
 XXZ2XF0YLxWhhPGMQpS6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KYAaPc5oH4U=:IVv4SsbO7CFbBgijYpzxwi
 DncwTlmzzhrlOpwZmbXdumwKSuVqhtUHFzX3adT0e/Anfx5o5SwGZYZBWwULxtywwMQo7GLd1
 bwTkBm2u+8X4N/SwlPmjXoEd2zOMJJiAVdVqhTTHw7+l6tt7IQpjxSdX+VnRXlJzaM1lY2NqY
 ObTpeCzVAN5jljxFzEMZ3OnXpChxC+DzCC+tLk18SwlZWzpFG4v9ciD3oJJmaB+mpveo3vXQC
 Ghc3uhiuVln3kSoJWrP+mqm6GzgF/lvBUQB9m1xzTKkjVx+loBHxeI5h0ay8htMg2zivpnfeb
 S6De8nNHheyAOOWIkP59IB5uffuYC1Z6+/vq7m3ahIyv88HMDqZKXGubV0HCCaumI0OKnNMlL
 QTl1P63k4bcW0m2yR2iGl4cucrZN+DR2Bc018W8H5W/dMe569DF6OsDy5PY0QVY7kawii0VgW
 zcCW02CSUZprD8XYRIStUaoeeHnLDvfV6ez28MZVAXeAOKhX5QM6yZpqGlVczjYhzcjE1jaL6
 l2Cz0HplZZUiBl7aJ5GOqIzDCB82ljLKQhBiTEueci9feUwadUxyxo2ar3FEANf3xviNYz1Hw
 kijOj+dzFH0qrRJmLslQtY70VW6Ho39SRJRXChbtL2M9Pm5OHdTuq3jXcBTXhbcvj3U4ZcoTd
 LtmHaY+/PcWBC7HVT6MjjbkVwb9jOwZSKSQWAFUwmrOQXd+o54JqjrG0E5IwfmvnEhPSfsg3t
 iOVvAJpV6RBjCHbky+9pSKJRSYM9KiQXbr6pXGJ3skQcNAjGC/47hq/29RClWwMDLFPF1CkNu
 WluFbFJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Idan,

On Tue, 6 Sep 2016, Idan Shimoni wrote:

> ???

Please understand that you continue to annoy Stefan, who is only trying to
help you, by adding your replies *above* the quoted email. This is called
top-posting and considered very, very rude on this mailing list.

Also, your replies are very succinct, to the point of being incomplete. So
Stefan required a couple of back-and-forths until he finally found out
what your problem is. You could have volunteered more information (as you
did in the issue https://github.com/git-for-windows/git/issues/875 that
you opened in the correct place: you mentioned the Windows version as well
as the Git version, although the answer to which options were chosen
("All") was most likely incorrect, because you have to decide e.g. whether
you want CR/LF line endings, LF line endings, or the same line endings as
are stored in the Git repositories, you cannot choose all of them at the
same time).

Unfortunately, the information given in that ticket is still too succinct:
it does not mention from which version you upgraded. You force us, once
again, to guess. My guess is: Git for Windows 1.9.5.

So now to your real question, which is: why is Git Cheetah no longer
bundled with Git for Windows 2.x?

The answer to that is easy: it was too cumbersome to maintain, there have
been almost no contributions, and most users chose to opt for TortoiseGit
or GitExternals (both of which are much, much larger than Git Cheetah, but
at the same time they happen to be maintained).

So there you go.

Next time you report a bug, please spend a little more time on the bug
report. It would certainly be appreciated by the people you ask to help
you.

Ciao,
Johannes
