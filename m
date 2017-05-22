Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 231802023D
	for <e@80x24.org>; Mon, 22 May 2017 15:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935202AbdEVPm0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 11:42:26 -0400
Received: from mout.gmx.net ([212.227.15.19]:51745 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935433AbdEVPmV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 11:42:21 -0400
Received: from virtualbox ([95.208.58.16]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MF4eJ-1d9rbe0E8J-00GFj9; Mon, 22
 May 2017 17:41:53 +0200
Date:   Mon, 22 May 2017 17:41:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Konstantin Khomoutov <kostix+git@007spb.ru>
cc:     Rabii Elguermouni <rabii.elguermouni@gmail.com>,
        git@vger.kernel.org
Subject: Re: Git 2.13 silent install
In-Reply-To: <20170522135816.cufdxxadsjdhge6p@tigra>
Message-ID: <alpine.DEB.2.21.1.1705221741170.3610@virtualbox>
References: <CBD45BD0-623B-4301-B02A-5051CDAC1569@gmail.com> <20170522135816.cufdxxadsjdhge6p@tigra>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:2aBu/cJuvgU0wwJCsqTK849f6xwye37tO+nJKpJKAErV0Qxe6RC
 YonnnJqyZ2Dx7ERV0qQCrhbSsEhLHVtxg0Y5gCXCKQ/7agjjSHE75SC/A+Bc9wZrWQ5/yUG
 7rltw7PD21gxGNLOqX04WErzBH4BmqsyQd0rwpUBTA7ZPiiVkbC5+wi8dAG0MKybxLr/okc
 x+XoAFJYoBr7xyILXevwg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qy3Guq5yHiY=:eqKPzEPWYtPGmPnKre03I+
 MT3MM8KWDCVxkpmUtYZytobSq1Ze8s9fUPTwyq8t0e3i2YqeAq4Av95oojdVjjVEW03nwfUf4
 A95uVAzAHu/ipeJgcol9nCWPiMNcryhLH8nJxBIK0iW/r7BsYE4GcmL8v2ZOYnrbDk8c/J0gt
 y9FNWYVZ0qA+NxysuKeMUUB2nnyozaecYfqsk6eIeXhgxhS4a7bVYYM1Q4MEgUIeGW8qK2jWB
 A/3Ys6VJGuImNF1vYImySSVAgrIEe1ocgk4SiOy3eYmE3DoU4OtP102ejY2aAY15tGr/ZnUCO
 8hnlL4U/Z71A+Lbydh8mIpWzkgmrKB3R02VUZa3+/M3Nqa3SvvByjvCyFHz+JO076WppWuens
 4UmW8jRKnSGsSoh4hkIFUvzWSzHfDfCMPkQNtSU/e0OJ6SrT827CZROLHVqIQa6+jbsCnZ5Mf
 aNkyXIKen62fFBekv+lr5I3OpB8GsHvRv/8FW1zpTBTA/4kDHWVdA4c0+onWzAyvfM2bHhhbN
 iq3PXb8lR1jcUYVU6iexiSvDVSOydzwYC+ozKkWQowiAXjkdTxlVhMHUJLWR8OO8xyTExouTv
 VQvSASlD9PRcisFvI+p77+WaGoRgohUwziMYpNOBbMnIGZN/68vtcjuZrksvMyxSYS8uoXQ0f
 3cox3w2v4160Xry/3yozMfK5V+EQ+CxWTqfVRUThrjs4BXga/IStxzrLhPLuaWYsOB8ZMtKY4
 kwlntKDNai7JDRVU7OlQTu3JYqSZYS0Q1Yi949xw23eGDF6ROTyA9wxxIUBg62eQNnU7R5NTZ
 rBxBSpy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Konst,

On Mon, 22 May 2017, Konstantin Khomoutov wrote:

> On Fri, May 12, 2017 at 09:55:04AM -0400, Rabii Elguermouni wrote:
> 
> > Just wondering if someone can send me the instructions for an
> > unattended/silent install for Git 2.13. 
> 
> This guide [1] is outdated but should be applicable (see the new
> installer file [2] and its "[Components]" section for an up-to-date list
> of components to select).
> 
> 1. https://github.com/msysgit/msysgit/wiki/Silent-or-Unattended-Installation
> 2. https://github.com/git-for-windows/build-extra/blob/master/installer/install.iss

Please note that [1] was copy-edited to Git for Windows 2.x' wiki:

https://github.com/git-for-windows/git/wiki/Silent-or-Unattended-Installation

Ciao,
Johannes
