Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C0771F991
	for <e@80x24.org>; Mon,  7 Aug 2017 06:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbdHGGIe (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 02:08:34 -0400
Received: from smtp122.ord1c.emailsrvr.com ([108.166.43.122]:49876 "EHLO
        smtp122.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751795AbdHGGId (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 7 Aug 2017 02:08:33 -0400
Received: from smtp24.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp24.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 001F560338
        for <git@vger.kernel.org>; Mon,  7 Aug 2017 02:08:32 -0400 (EDT)
X-SMTPDoctor-Processed: csmtpprox beta
Received: from smtp24.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp24.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id F2EE96033D
        for <git@vger.kernel.org>; Mon,  7 Aug 2017 02:08:32 -0400 (EDT)
Received: from smtp192.mex09.emailsrvr.com (unknown [184.106.73.70])
        by smtp24.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTPS id D415660338
        for <git@vger.kernel.org>; Mon,  7 Aug 2017 02:08:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=statseeker.com;
        s=20170629-l0wbkvum; t=1502086112;
        bh=1I8UcdDC2gf6hbHgCs+vbRkme/EZ/Qdkhs9tmyGZT5g=;
        h=From:To:Subject:Date:From;
        b=NNxqpyRC/yjMjSRaf511WYKrGRkOHN+4ekBMQwZ2d+yP8q6txp4tYraflDMj4e4SV
         xhlXBMn0NDXrd3DPszaNeCr2JwXwtvsQ0QYPVK/PWNTVhHiwM5JwzSDKbgHeXJ6C7g
         romlEiaMeSbOMuu7yFk1nBF1OlDH0gpWJY90unG8=
X-Sender-Id: james.wells@statseeker.com
Received: from smtp192.mex09.emailsrvr.com ([UNAVAILABLE]. [184.106.73.70])
        (using TLSv1.2 with cipher AES256-SHA256)
        by 0.0.0.0:25 (trex/5.7.12);
        Mon, 07 Aug 2017 02:08:32 -0400
Received: from MBX04D-ORD1.mex09.mlsrvr.com (172.29.128.30) by
 MBX04D-ORD1.mex09.mlsrvr.com (172.29.128.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Mon, 7 Aug 2017 01:08:32 -0500
Received: from MBX04D-ORD1.mex09.mlsrvr.com ([fe80::40b3:1086:160a:405e]) by
 MBX04D-ORD1.mex09.mlsrvr.com ([fe80::40b3:1086:160a:405e%21]) with mapi id
 15.01.0669.032; Mon, 7 Aug 2017 01:08:32 -0500
From:   James Wells <james.wells@statseeker.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: upgarding GIT
Thread-Topic: upgarding GIT
Thread-Index: AdMPQ2NPbrFDYd5KTIq487yWwoqxgg==
Date:   Mon, 7 Aug 2017 06:08:32 +0000
Message-ID: <9a2576ed8b7146459585af4238613286@statseeker.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [14.203.103.145]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All

I am fairly new to git, however I have a challenge of upgrading git from 2.=
0.4 to 2.4.12 and my initial 2.0.4 install was done via TAR BALL on my serv=
er.

I have a centos server running git and Atlassian STASH and my challenge is =
for me to upgrade the STASH application I need to move to a newer version o=
f git.

How do I go about upgrading git from TAR BALL installs , is there an easy w=
ay as I would prefer not to have to create a new server and migrate everyth=
ing across , I would like to perform the upgrade on the current local serve=
r if it is at all possible.

Any assistance is most welcome and I would appreciate your feedback or comm=
ents on how you would go about achieving this task.

Thanks
J








