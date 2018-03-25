Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 584F11F404
	for <e@80x24.org>; Sun, 25 Mar 2018 21:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeCYV5J (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 17:57:09 -0400
Received: from mr22p34im-asmtp001.me.com ([17.111.211.48]:40162 "EHLO
        mr22p34im-asmtp001.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752025AbeCYV5I (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 17:57:08 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Mar 2018 17:57:08 EDT
Received: from process-dkim-sign-daemon.mr22p34im-asmtp001.me.com by
 mr22p34im-asmtp001.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) id <0P6500500Z53D100@mr22p34im-asmtp001.me.com> for
 git@vger.kernel.org; Sun, 25 Mar 2018 20:57:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;     s=04042017;
 t=1522011427;  bh=EcfRyI5KrCwp+I2O/UvDbOtVmC8aecJJYqkLqpPMTC4=;
        h=Content-type:From:MIME-version:Date:Subject:Message-id:To;
        b=u4wPNs+hH+W7o6AOvaPHcAW2EocpNNOo0jbvMV2dluSV6xc2gOrnF5rAFId4kfho6
 7sGbb3Jz3lS/16PN317WD6vRSG/lr1qWcfkgQCWLBdXjOR878MD1sFLCyxL34m2zpE
 ssaO5GoCWq7bow/g/wZXw8Cjzx02NZJwnxFa1je6CWO4WG/VDugOxbAFMMQ+CJ2O9B
 o3wd/HTncatwYvbqKCbNerQrblbyOD/uAfOTt2+54w6uxyQDtC2g+j/o9z7qNQKeZo
 FDVw1wxpRS7cvSIoSMpaJ7D2rycS1qdecIEs5kr7g1eobLUr6hU/q12d/SL4hvU+gA
 osaTe3/bOpiVw==
Received: from icloud.com ([127.0.0.1]) by mr22p34im-asmtp001.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) with ESMTPSA id <0P65004IAZJ3PJ00@mr22p34im-asmtp001.me.com>; Sun,
 25 Mar 2018 20:57:07 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2018-03-25_08:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1011 suspectscore=1 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1803250253
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: quoted-printable
From:   Recep Aslan <r.aslan0@icloud.com>
MIME-version: 1.0 (1.0)
Date:   Sun, 25 Mar 2018 23:57:02 +0300
Subject: Re: [PATCH v2 4/8] completion: factor out _git_xxx calling code
Message-id: <E7A54C0A-027F-4D4F-8454-CC207CA9CBEB@icloud.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, szeder.dev@gmail.com
To:     pclouds@gmail.com
X-Mailer: iPhone Mail (15D100)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sssss

iPhone=E2=80=99umdan g=C3=B6nderildi=
