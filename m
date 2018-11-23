Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B9071F97E
	for <e@80x24.org>; Fri, 23 Nov 2018 10:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409244AbeKWUtY (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 15:49:24 -0500
Received: from mout.gmx.net ([212.227.17.22]:35251 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393839AbeKWUtX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 15:49:23 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MexlN-1g5z1M1BXt-00OXo9; Fri, 23
 Nov 2018 11:05:45 +0100
Date:   Fri, 23 Nov 2018 11:05:45 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Paul Gureghian <paulgureghian@att.net>
cc:     git@vger.kernel.org
Subject: Re: 2.19.2 wont launch
In-Reply-To: <6b43658b-73e3-e009-642f-c46c5bbe2b21@att.net>
Message-ID: <nycvar.QRO.7.76.6.1811231103340.41@tvgsbejvaqbjf.bet>
References: <6b43658b-73e3-e009-642f-c46c5bbe2b21@att.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VD13XjUlaDaH05G9aFn5JDksxQIUbJ5OlIILrumVH6lit0Y0vgt
 yYrOdd7NZ3qToDIa0EYKsbIrtQZUyHit8HK5iQ5V0Hbg22nr1s9KhS/PH45ixoi/ze+qT5z
 J86FMk0ZRhREudGou/u9RZZJQr71lQ9cd7Coga4fqOMM3Pi9Z58/SngbnX7B/RKPTXw8J5X
 TadppB+lkJqIp7Fuzgqwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RM/yxlaLaT8=:vGTBwJTmnIutSoR2e1m2bG
 62pVytlM+U5YgkKJIH8RyCLhEj0w7u+d52fORh1CWbgU/3fVfbx2SAhw3LxLsNeIK3kl2HTyI
 wdpGhhpECdcCd3MCo/5pYkzh6Vs9HMPDCZhMPdmJfT9y2z6iglHAC0lroMg5g98KLQALzlxCj
 V8IOwKPlVJJF9phoOFBJrSirXrxJ0AH9zHXEemiOVt78XAGyBGM6U5D2whRhpquINyP3QpyUc
 4WESQuPqrpRRw9KGLF7NEGcShPPeASIMTsH34HBh7TJflWOiR7sKN8MyGwvEonelScb2OTi5O
 4RXVYkhfrH1SGSimGeI5NfCnelLh92oGXE3Mq38OmWVlMzJrDXqNqwYX0GDTb1/nznIjI+wFA
 TPNKzKeWXHYHBK4wo0ftJSeAMgDnPb+tEtnRrcjOdkKg5mpEIPfctG0OihNrmKyzXG7zlt2rh
 yX2E3x5GSYNZSLWOsTiXrhEz6KGcFxixvTk/fttiIx/ZoFG3Se4dR1NLWfJf58SDjKQv8ZlMh
 XJXC7BZmRIgv4qfmHk6KSmCRLgCqDFSqjMS8QCkgmGLjkonThN7btNjPyInviVmFeyG6DNa3y
 Ca20RIvh9eL9y38QYjeytQJUuoLAsFW0BrzcEZ3BGiOHnhZLrOZkO+VIADCXDYWqlT3Bi5/FV
 SkuZn3GqYFi7tnbUX2zvsWwxu99RZ5QEAzqvnWSOtAuh/oebRK/Rs3oqVNs+cb3uGaLrPAyrE
 CnzT7YcchjoYpX5kCt/zGOov4Qzne9RoN7QAvtGWEbEHEBd8XZl1k+f4LpXQOOPpcmx9HOWew
 LmMvb6hSZUUCjhxQMqt762lN4FK00JkDAOxfFLYbu9q1hDXGd6iwqpWIY/NAzF+J36AMxKYQV
 W6VziQIF8CAuf4axHyCG3iyCBn299omnFYYSqIFXLRVO5RLE9kip9KTfnyD5D1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On Thu, 22 Nov 2018, Paul Gureghian wrote:

> I installed 2.19.2 on windows 7 , 32 bit and it wont launch.

This has been reported on Gitter and fixed in
https://github.com/git-for-windows/MINGW-packages/commit/deb0395d031401ffe55024fb066267e2ea8d032b

For the time being, please either use v2.19.1, or copy the file
`git-bash.exe` from a portable Git v2.19.1 into your v2.19.2 installation.

Sorry for the trouble,
Johannes
