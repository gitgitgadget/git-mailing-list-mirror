Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 139E5202AE
	for <e@80x24.org>; Sun,  9 Jul 2017 16:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752335AbdGIQsH (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 12:48:07 -0400
Received: from mout.gmx.net ([212.227.17.22]:56706 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752267AbdGIQsG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 12:48:06 -0400
Received: from [192.168.178.24] ([78.54.56.184]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfzEP-1dIKjW3Qrl-00NUDf for
 <git@vger.kernel.org>; Sun, 09 Jul 2017 18:48:03 +0200
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Subject: enhancement request : If 2 commits to be squashed together do have
 the same title and comment ...
Message-ID: <66e0ec72-699c-f71b-55c7-e1f780111853@gmx.de>
Date:   Sun, 9 Jul 2017 18:48:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:kVssxf1GkZDBnEoWbmHr9tsbGSOEU6uu8obiBStkGIt+HfKJpP4
 aTWNfLL/i3gaDi+5cfBSJDLvzEPdPf4DeaG/icJgKayRtn26ifFOF/8BOvWIXj1hwtkTpVZ
 LwV5/2cHqOJuEjFD0kvynt10horEwK2QS4dS/xVhUBB0Tdu+3yUE+yQpflpSd3zbbJ3wrrE
 lFK9EB9Ri/4DjiYwVJdMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HFkA8vTA7cw=:nJqiZI8gmHkD0u5diZV7su
 i7/04QQ5A1HIMNr7sHQp4pWV5roSak16mEXIC3mO0mtFq7H4kiHp6qCRa9mnjkH9eWmPApWs/
 Wjmg2/3btA3xrAke9OptZHRH0DQywyO0GlFmTXiTBCCGMaGXReRAI0l0CA7sCA2QwuGLscGTN
 g1aPMjxU4o62ToZebnje+xNjqQTy6qUMefBQLRTDZgWztwJ5XLkfpqv3rfSG3CqG2IG/fVh55
 sLlroc6LwKkLj3VWhcGsw7aztwAd5AE7OGBPg3jzirr9ULCVyhzS/+KjTzF+Tc+mibpQrY+Gz
 +mwGxGttRWCGgZGWGW3ecn9OlKpsa0GU8OmoQIc/7Nv8lR5mykVekMLD+aV0yHzJhcAb38fI5
 6EDwb0o3QhSy3ume5Rno5MgzmN9g90nSbsDaTy54DXVh/g2hCzDbAcnD4q6Oct7mc61IuNniZ
 J7hi+153+TqeqJgiH9dnztbWd8IGOV0M6BFMFUKmk1CPA4qNN4tEkWWPQm48fbygS4bMB3lqS
 bZf6Ubjn6fAIplkwZteDMLVux4V+zmCNKpgQvnuFED/PTQVeslquN+8J2Tz693Do7svsz9gJa
 yS8rDgOpXjBEMmI5SXBfRJkzsvZnrKKHLAJTQbYdTuKOzYwJMeJNlK4rvP+LKZk1Y7oAzN2zU
 q3TxRf6xOm6z0IRuM+FunyQ5ptOpb5eVFJredvtJgbyu+IM0XI34EMsmlcqXAgo/digQG5XVN
 k8iffwil8kDaMNw/2U/TOotsYpH8lzxNGCjQAkoJ3mgmQV+UUnZjeWwi/x1LfXcCF72sPVaF9
 +21Zlca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

... then jast squsash them w/o questioning.

Is this a valid RFE ?

-- 
Toralf
PGP C4EACDDE 0076E94E
