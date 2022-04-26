Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4516C433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 20:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354442AbiDZUKW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 16:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354441AbiDZUKV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 16:10:21 -0400
X-Greylist: delayed 576 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Apr 2022 13:07:11 PDT
Received: from st43p00im-zteg10071901.me.com (st43p00im-zteg10071901.me.com [17.58.63.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4B11597A5
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 13:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1651003054;
        bh=/6/e7Yo/AsJKd3NidSiWcqSBpPDVAfGepmlg+wmkNFk=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=LDbDUgFXs7s1RrBHB3XUQ6cpbNAGVmo758H8myBuoVvL8XNlr8SYnWZ/KIsQIN/Wb
         1U9SsXQpkcTow+KqKucBlnBV2K9BADYh7l/URtB+SC2F2VQx8fBmAzxOWoC9l4r9Y1
         riCo8/PNYWRYaV1MyYwzb0Axkrshmsh6+CJBURLL84qQikjr/Yjm1lOy3/GJ6hraoR
         bYFUlsMltTIXS+PQ0ez3t6WHfK2QSkgI36vCOc1ZZHjcWqDHN5ZKZ4qHMGavE2tw97
         4g7n4MkTMBkkw9DUndIpDtQJt2EheuKNz3/jl0W27IhqB6KctdYMwY8Ibj3UiAVKqI
         X9/xCHJaRS/Qg==
Received: from smtpclient.apple (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
        by st43p00im-zteg10071901.me.com (Postfix) with ESMTPSA id C19C9840625
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 19:57:33 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Artem Semenov <artem.semenov@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Tue, 26 Apr 2022 15:57:32 -0400
Subject: GitBash Paste with Insert Key on Windows 10 not Working
Message-Id: <66F55DFB-0CB5-4A70-B23E-8EE7844C4B56@icloud.com>
To:     git@vger.kernel.org
X-Mailer: iPad Mail (19E258)
X-Proofpoint-ORIG-GUID: oSmG540b8Nkkq5CWA2TPcQfx0sr7Ax6r
X-Proofpoint-GUID: oSmG540b8Nkkq5CWA2TPcQfx0sr7Ax6r
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-14=5F01:2022-01-14=5F01,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 spamscore=0
 mlxlogscore=387 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260127
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Quick question, the Insert key used to work for pasting text, but it appears=
 to no longer work with the latest version. Was the Insert key disabled as a=
n option to paste text?

Thanks in advance.

Artem Semenov=
