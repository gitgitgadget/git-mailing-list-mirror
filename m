Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA079C433E0
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 18:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74C7664E4D
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 18:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbhCOSat (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 14:30:49 -0400
Received: from pv50p00im-ztdg10012001.me.com ([17.58.6.51]:37559 "EHLO
        pv50p00im-ztdg10012001.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230461AbhCOSaW (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Mar 2021 14:30:22 -0400
X-Greylist: delayed 520 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Mar 2021 14:30:22 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1615832500;
        bh=KO39vujztn0TNf0CIAck+miL7sexgdxTrXIRdUWL/DE=;
        h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
        b=MWUoJtuEnOA3e356RXjgkYmtA3hHhZpxfHaiXLIeT+zMUQMsleqLl8N0TgiVoWDQu
         DrrQ3FxDen/opQQC6aCRq1h7uGFxWmCMl5MqcKHL8YLzASJAqUMwQ4NxI6CywMS3++
         Ut+PD3S3wVWVnmEuL2YU/HfQK2/GCZ/21c+kuQVHu+unhs+is0JxYpLEsjz2gwwSCR
         oMdvG5c/QRos7YrslvRUtXd9vf2NzL0j2YqNI+j5RrrjumqpLya5vsfqD2y7O8f9SX
         4BOkTGwsRKa/8FLUV2H2vcrHk5498Iij92fD/79AAfeJLYNFdeemgJx96fgJ803HLR
         HrWS1JDivyxDA==
Received: from [192.168.1.5] (unknown [122.179.246.110])
        by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id D908D280385
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 18:21:39 +0000 (UTC)
From:   Piyush Sachdeva <cosmologist_piyush@icloud.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: [Newbie]
Message-Id: <191391AB-F82E-4786-A96C-FD14FA173FBD@icloud.com>
Date:   Mon, 15 Mar 2021 23:51:35 +0530
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3654.60.0.2.21)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-15_11:2021-03-15,2021-03-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=431 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2103150124
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To whomever it may concern,
Hi, my name is Piyush and I have no idea about contributing to large =
open source projects, yet I really wish to get some good exposure. =
I=E2=80=99ll be more than glad if you could point me in the right =
direction.

=E2=80=94
Regards,
Piyush Sachdeva
Phone: +91-7895201011
Email ID: cosmologist_piyush@icloud.com

