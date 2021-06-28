Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_05,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE97C2B9F4
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 13:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F37C61C6B
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 13:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhF1Nsa convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 28 Jun 2021 09:48:30 -0400
Received: from mail2.nordlb.de ([80.146.181.6]:26312 "EHLO mail2.nordlb.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230086AbhF1Ns3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 09:48:29 -0400
IronPort-SDR: H2qUKnR7oEV8pYQKSRmFeI0ikLGBL1lD6420f/G42lJf4YiJNmObB3es+zi/VooOOy46qLGm6z
 lJzoq0J/YPNw==
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AnVoP8KFEWKm5OGMgpLqFKJHXdLJyesId70?=
 =?us-ascii?q?hD6qkvc20tTiXIrbHJoB1E726StN9GYgBppTnyAtj0fZq8z+863WB1B92ftW?=
 =?us-ascii?q?bdyRiVxe1ZnPrfKnjbalrDH41mpNldmspFeanN5DFB5K6WkWzId6dZsaL3jN?=
 =?us-ascii?q?HWuQrH9QYRcegpUdAX0+4QMG2m+yZNNUB77PQCZeqhDkQunVadkah+VLXlOl?=
 =?us-ascii?q?A1G8XOutHAiZT8QTNDPgUg4gWVlz+kgYSKTSRw6i1uGA+njI1StFQsx2bCl9?=
 =?us-ascii?q?+emsD+7iWZ+37Y7pxQltek4MBEHtawhs8cLSipohq0Zax6Mofy5gwdkaWK0h?=
 =?us-ascii?q?IHgdPMqxAvM4BY8HXKZFy4phPrxk3JzCsu0Xn/0lWV6EGT+vARfAhKVvapuL?=
 =?us-ascii?q?gpKycxqnBQ+u2U6Zg7mF5xYqAnVS8p1U7Glqr1vxIDrDv1nZNtq59Os5Vla/?=
 =?us-ascii?q?pSVFZml/1fwKpkKuZLIMvE0vFqLABPNrCe2B8ESyLZU5jm1lMfj+BFXB8IcS?=
 =?us-ascii?q?tuFXJthiXS6UkToJggpXF4+CQZ9U1hyHo6IKM0hNgtNs9T5dNzcvM=3D?=
From:   =?iso-8859-1?Q?K=F6ppen=2C_Thomas?= <thomas.koeppen@nordlb.de>
To:     "'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: Release notes: mIssing version information for git-LFS
Thread-Topic: Release notes: mIssing version information for git-LFS
Thread-Index: AddsIjQ730tF1VykTD6kQ1yIAuP5Gw==
Date:   Mon, 28 Jun 2021 13:46:02 +0000
Message-ID: <21210b30b6c44361aef0c99ca5983f52@nordlb.de>
Accept-Language: de-DE, en-US, en-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [14.108.64.145]
x-exchange-nodisclaimer: 1
MIME-Version: 1.0
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Content-Language: de-DE
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

in the release notes for git i miss the information which version of git-LFS was implemented.
Am I just reading over it or is this information really missing?

With kind regards
Tom
**************************************************************** Die in dieser E-Mail enthaltenen Informationen sind vertraulich. Diese E-Mail ist ausschliesslich fuer den Adressaten bestimmt und jeglicher Zugriff durch andere Personen ist nicht zulaessig. Falls Sie nicht einer der genannten Empfaenger sind, ist jede Veroeffentlichung, Vervielfaeltigung, Verteilung oder sonstige in diesem Zusammenhang stehende Handlung untersagt und unter Umstaenden ungesetzlich. Sollte diese Nachricht nicht fuer Sie bestimmt sein, so bitten wir Sie, den Absender unverzueglich zu informieren und die E-Mail zu loeschen. **************************************************************** The information contained in this e-mail is confidential. This e-mail is intended solely for the addressee(s) and may not be accessed by anyone else. If you are not a named recipient, any disclosure, copying, distribution or related action is prohibited and might be unlawful. If the e-mail is not intended for you, please 
 notify the sender immediately and delete it. ****************************************************************
