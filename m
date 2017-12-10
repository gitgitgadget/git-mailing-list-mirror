Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D8551F404
	for <e@80x24.org>; Sun, 10 Dec 2017 11:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751942AbdLJL6W convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 10 Dec 2017 06:58:22 -0500
Received: from cisrsmtp.univ-lyon1.fr ([134.214.188.146]:39470 "EHLO
        cisrsmtp.univ-lyon1.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751860AbdLJL6V (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Dec 2017 06:58:21 -0500
Received: from localhost (localhost [127.0.0.1])
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTP id 88A28A0067;
        Sun, 10 Dec 2017 12:58:19 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at cisrsmtp.univ-lyon1.fr
Received: from cisrsmtp.univ-lyon1.fr ([127.0.0.1])
        by localhost (cisrsmtp.univ-lyon1.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id z0Xj2--zUBlq; Sun, 10 Dec 2017 12:58:19 +0100 (CET)
Received: from BEMBX2013-01.univ-lyon1.fr (bembx2013-01.univ-lyon1.fr [134.214.201.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTPS id 30AE7A0023;
        Sun, 10 Dec 2017 12:58:19 +0100 (CET)
Received: from BEMBX2013-01.univ-lyon1.fr (134.214.201.247) by
 BEMBX2013-01.univ-lyon1.fr (134.214.201.247) with Microsoft SMTP Server (TLS)
 id 15.0.1263.5; Sun, 10 Dec 2017 12:58:18 +0100
Received: from BEMBX2013-01.univ-lyon1.fr ([fe80::b1ea:14ef:61b9:d4cd]) by
 BEMBX2013-01.univ-lyon1.fr ([fe80::b1ea:14ef:61b9:d4cd%15]) with mapi id
 15.00.1263.000; Sun, 10 Dec 2017 12:58:18 +0100
From:   BENSOUSSAN--BOHM DANIEL p1507430 
        <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
To:     Eric Sunshine <sunshine@sunshineco.com>
CC:     Git List <git@vger.kernel.org>,
        MOY MATTHIEU <matthieu.moy@univ-lyon1.fr>,
        ALBERTIN TIMOTHEE p1514771 
        <timothee.albertin@etu.univ-lyon1.fr>,
        "PAYRE NATHAN p1508475" <nathan.payre@etu.univ-lyon1.fr>
Subject: RE: [PATCH] doc: reword gitworflows for neutrality
Thread-Topic: [PATCH] doc: reword gitworflows for neutrality
Thread-Index: AQHTcDfPGyWRey7Y1U6m8Byh7CEBQ6M5q/GAgALPRDg=
Date:   Sun, 10 Dec 2017 11:58:18 +0000
Message-ID: <1512907098563.90200@etu.univ-lyon1.fr>
References: <20171208151807.3569-1-daniel.bensoussan--bohm@etu.univ-lyon1.fr>,<CAPig+cTgJepi6xVn0+qP3SW0Y0g-6Nf4LvCjCkvEHfZwugY1Hg@mail.gmail.com>
In-Reply-To: <CAPig+cTgJepi6xVn0+qP3SW0Y0g-6Nf4LvCjCkvEHfZwugY1Hg@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [134.214.126.172]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>As a native English speaker, I find the new phrasing odd, and think
>this may a step backward. How about trying a different approach? For
>example:

    >Occasionally, the maintainer may get merge conflicts when trying
    >to pull changes from downstream. In this case, it may make sense
    >to ask downstream to do the merge and resolve the conflicts
    >instead (since, presumably, downstream will know better how to
    >resolve them).

Indeed, this is an other possibility.

Thanks for the review.

Daniel BENSOUSSAN-BOHM
