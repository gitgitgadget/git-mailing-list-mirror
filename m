Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C105B2035F
	for <e@80x24.org>; Fri, 11 Nov 2016 18:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934646AbcKKShU (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 13:37:20 -0500
Received: from mout.gmx.net ([212.227.17.21]:64615 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934597AbcKKShU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 13:37:20 -0500
Received: from virtualbox ([37.24.142.46]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LzoSt-1crdzk0YYl-0154xS; Fri, 11
 Nov 2016 19:37:15 +0100
Date:   Fri, 11 Nov 2016 19:37:14 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Lars Schneider <larsxschneider@gmail.com>
cc:     git-for-windows <git-for-windows@googlegroups.com>,
        Git Mailing List <git@vger.kernel.org>, me@ttaylorr.com
Subject: Re: [git-for-windows] [ANNOUNCE] Prerelease: Git for Windows
 v2.11.0-rc0
In-Reply-To: <F2B1E33E-3C31-45A3-8A5B-098A59CD399D@gmail.com>
Message-ID: <alpine.DEB.2.20.1611111936510.3746@virtualbox>
References: <alpine.DEB.2.20.1611051025030.3108@virtualbox> <B2BEB5B4-5CF0-4CD7-A8E2-50D51E00D2FF@gmail.com> <alpine.DEB.2.20.1611102237230.24684@virtualbox> <F2B1E33E-3C31-45A3-8A5B-098A59CD399D@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:U7cU3W7X7r20Gm1uvfqHzb6NlCdoAywqP7UGe7QxfAMyNIrLfKT
 IgBw6B7nwxN1mwiEnIeFI9qZOKvUxlByXqeSyMFJiZDRedWOtViztnUmhCmLA3coHtvXpst
 VljL8zK1/oTaAZEx41cyYh8KvrutId9SloOpv7jeGKEtodRaUXfc9KgpSA5i1WP2U8EJnK6
 Wf11b9SqBJ+wcUZIUPWOg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lE/bKWUPyuo=:IrBG958EaHm+oBkBcj3kn1
 uLlLQSHq/gBAMugKTP7mZPTzc4lK0bCRUCs1IUbMkQvQcpO/t4oWfrgd73wnvrJy04CGt0t/V
 Hl7czeDjOI3Ur0sT4Ky6DFYbM3ZjWAXwK4OxyDVFkm/lLPhFwmwl+kNaOm18sYx3uPrwg+F91
 bCcYKiA2gW0gfKQTPKDPdZvh+tM1ZgrtodHxrguVeh0XIzzi4gHV5IJU5yAiHwWBUK1O3JDmL
 5G2xxan4xBSzFbDpwcWC+lFcBfbd+5YyTVrVYd71xJz6NyOjBYBSIWmgrzI9p9Hh2XlXommw1
 NXyFyCmxGVqvq/I/Axq/Rp3KTXUxLOhixKqzvjYYeXCzGkXdbJIzxkLmPlOsFwLL4jhFbi8uS
 JdznvsXh/tbgOA5CqsM/SGqix+g33N2m7dKg/FPiRrcpwQbcVrdhVuqAVWMNQyaS+mUaOhEld
 JV7CaRylF6aVqnn7yT+9+zPpfnlEPL2JPu7s/ySuxZf+Pd5oEAKdq+3s0gCit464sbYk4kwui
 /S0MgygZW+dj8OuT9bcYobT1aYg3ElbMGx6Muiu8P0/g6LNoHKx47DANkMBan//iBV8auI+fY
 lJM9KZUwvhljpx7axLCqFtnlGV9MZ0PU7Be18cLLpYiT7rBSS/CgNtr/iZTGDol99nKGMtIlK
 y7JoYOm2Jqjkwray0F2kSDdZKY99iB65HSFqVs2uXVB444YlS+mBROP/EdAzUtqtKqdhGDBV9
 ZEyny9fax6AfneCPdOoyM+ltd5ESz/GSnlwQkRKYfvC1TlKzoqsDP5Bv13XSC09lGUk9QsjJE
 Gy3X1v7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lars,

On Fri, 11 Nov 2016, Lars Schneider wrote:

> 
> On 10 Nov 2016, at 22:39, Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
> 
> > Hi Lars,
> > 
> > On Wed, 9 Nov 2016, Lars Schneider wrote:
> > 
> >> On 05 Nov 2016, at 10:50, Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
> >> 
> >>> I finally got around to rebase the Windows-specific patches (which seem to
> >>> not make it upstream as fast as we get new ones) on top of upstream Git
> >>> v2.11.0-rc0, and to bundle installers, portable Git and MinGit [*1*]:
> >>> 
> >>> https://github.com/git-for-windows/git/releases/tag/v2.11.0-rc0.windows.1
> >> 
> >> 
> >> I tested a new feature in 2.11 on Windows today and it failed. After some 
> >> confusion I realized that the feature is not on your 2.11 branch.
> > 
> > Oops. That must have been a major snafu on my side, very sorry for that.
> > 
> > I just tagged v2.11.0-rc0.windows.2 in https://github.com/dscho/git and
> > will make a new prerelease tomorrow.
> 
> No worries! I am looking forward to the new release!
> 
> For some reason my own build of Git for Windows cannot use HTTPS properly.
> I need to debug this further at some point.

Here it is:

https://github.com/git-for-windows/git/releases/tag/v2.11.0-rc0.windows.2

Thanks for catching my snafu,
Dscho
