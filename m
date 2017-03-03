Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4425120133
	for <e@80x24.org>; Fri,  3 Mar 2017 15:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751792AbdCCPyf (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 10:54:35 -0500
Received: from mout.gmx.net ([212.227.17.20]:51401 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751677AbdCCPyf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 10:54:35 -0500
Received: from virtualbox ([37.201.194.68]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lk81O-1c8pdP0IcE-00cD3O; Fri, 03
 Mar 2017 16:46:37 +0100
Date:   Fri, 3 Mar 2017 16:46:36 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Denton Liu <liu.denton@gmail.com>
cc:     git@vger.kernel.org, davvid@gmail.com
Subject: Re: [PATCH 3/3] Remove outdated info in difftool manpage
In-Reply-To: <20170303115751.GA13225@arch-attack.localdomain>
Message-ID: <alpine.DEB.2.20.1703031645470.3767@virtualbox>
References: <20170303115751.GA13225@arch-attack.localdomain>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NvcxYoogcwt4Q+EPpuCwAOu7QruELpdKDdR44c9aFzpGmSZcPVw
 3rwHPNkPxHI+IP6Q6H6tLOuPjJXphcqH/PWo1zEmyAsWHRZR8THBqeN1S9IBVKdgdd9dT5a
 m6tG1Iatfx1ZSW4FuIsNcJwKAl5kiYNvlyfkVGDv9DB40wgNNcu88r5xw+6i1Tp89S7s6P7
 WJQ0s/EM0HPZfCgpux48w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RgGKnVU6JsU=:Z6cpyfJKmnYnRsIXesQxWi
 bQvLvtrnzEn/78LqsafNF4EId8ho7kPdbw4p95DML21ENPzXHHx6ZHlEMeazDYVmHcmmAdi2Y
 A6FSYFVlNaRvd+vaHPPRpvoPCTspuMDR9Lu3N/wmwRXl9+Dwkk6gJBHRKPLpOR3+hgVuJrCJH
 bi+H+pu4e5UEYCrt/KIpWD71/UIVaPTELBVePxMarFihVICxrWPOBTykXA9/eXg3Mislo2yvF
 E9GH1K7YVK9wkIlni0Z2t9j9m+fIXFXTpAiKaZvT+vik7UwIBVXx7fETd266+gOoY/d7TDd/b
 /5ljsKWRtaoosU6FAG4kmxiEy8L8tByynditE+NqvXwAUtaBGA9AW9T0tUQ05HmF/vUipMSLJ
 4dX+zsBYjfEEBlGxwR5IAp8+O4JezWfrBCeg8hgw0MkJvs//QgtcEGNm3ohQrtDUn2ByRIBg+
 ZVTGcSNIXAZxMkFdz4J3a/eU4rn5melzn/6AUaJT53dvSuzcYIQlIVFrrxTU+n2XvNEsy3sMO
 Hn6ReZ9VPa1Yh/Cw4VEzpkgICDEPv2mQQwa+nwH8UaTXajQ8lqYftDKpuge9dGbtS754kWGKG
 JV3TpYtXC+TnCWyU3qETLE2OMcJiUxCjiADRvYlyNlLN0yDvfFCECrDJYPP7xwGuxN9X7SgXN
 I9ECNNtSk0jjAa+KKIPdtpA9gWDDr5tu2Se9uyUJIROdSxR0fbSLyX9KIAMJoWO9lBKdw3K8V
 HJjNCa8/S7zGrl26mW6WseaT7ZMzXNlNvjGTXoxGOPV5hm5euG9lyhBHMEVDnti/4zztQtM9n
 5f4YCSQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton (or should I address you as Liu?),

On Fri, 3 Mar 2017, Denton Liu wrote:

> When difftool was rewritten in C, it removed the capability to read
> fallback configs from mergetool. This changes the documentation to
> reflect this.

Thanks for pointing that out. But that is probably an oversight on my
part, not an intentional change...

Ciao,
Johannes
