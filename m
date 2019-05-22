Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B3A51F462
	for <e@80x24.org>; Sat, 25 May 2019 12:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfEYM5R (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 May 2019 08:57:17 -0400
Received: from m12-18.163.com ([220.181.12.18]:55459 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbfEYM5R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 May 2019 08:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Mime-Version:Subject:Message-Id:Date; bh=DewNi
        GC/KqjaFHYY5KUiIuNBI/qNJizveybe1dgWKVk=; b=gLreCHBkS6w7vJo7nKi+h
        /AJx+WbqlxBv2I1qFbjIO8rtgr8RLygIiGIxX+uaiQtNf5DmkIRJvIrQoC1syVv6
        os+LliCal+y5PmoNUdFP7zGIjo2UVUmeeFXDLvIYQqKtGvSlB8u7SGjTsD/TE7sT
        lYjch+bzmNnRXGo5CvQgqk=
Received: from [192.168.1.102] (unknown [120.244.60.115])
        by smtp14 (Coremail) with SMTP id EsCowAAXc9GpO+lcGbkcHw--.64934S3;
        Sat, 25 May 2019 20:57:14 +0800 (CST)
From:   Mobro <mobro_chu@163.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Mac OSX git uninstall unsuccessful
Message-Id: <AECF845F-1353-4A95-A349-69E9B6D5F26F@163.com>
Date:   Wed, 22 May 2019 20:52:43 +0800
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.102.3)
X-CM-TRANSID: EsCowAAXc9GpO+lcGbkcHw--.64934S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUw6pPUUUUU
X-Originating-IP: [120.244.60.115]
X-CM-SenderInfo: xpre20pbfk3qqrwthudrp/1tbiwAq-f1XllDcvhAAAsy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Through the MAC system prompt direct installation of git, after =
installation found that the local sshkey and GitHub account link, has =
been prompted "Connection closed by 192.30.253.112 port 22", check the =
log found no problem. So it is suspected that the GIT installation was =
wrong. Under terminal, you can see the git's address at "/ usr/bin/git" =
and enter "sudo rm-rf/usr/bin/git", but it is unsuccessful.

For uninstalling git, please reply as soon as possible. Thank you!=

