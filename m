Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C70BC433FE
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 23:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiJCXsR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 19:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJCXsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 19:48:16 -0400
X-Greylist: delayed 423 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Oct 2022 16:48:14 PDT
Received: from pv50p00im-hyfv10021501.me.com (pv50p00im-hyfv10021501.me.com [17.58.6.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A68476D1
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 16:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1664840470;
        bh=7OkADUZNEZiduNy+aSAeSVIpg3iMnY6fyIjrs2mSWvY=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=vE23w7uHTDdiibBMmJb+U26S4KHt5VHcYKrS3MkMhGVooDs+ZRAirK+MGLeUHA51J
         +xzoUtbXRqi/1aPtAGnLoaxvkyTPip7Ra+XOp5u+0iMkjIDvQ+u4Urxw1VWuL6Wgk4
         qpo+en2dTPOUeuafhhVQE7p5QYxSAzK9bh3cNhwmGXQZxK4TFoXicS2J4kAclQRGod
         zXleLreidOSBuaWCEFDTjxFs8QpsSQhDmpgR3rNwzGnOaEb03nKWlzsqM5gZKIQvhb
         Ck5rzZQp4Cr7khfyQWQCVgBInjDZGhSqc+X6Em5KspFnpbUJfPGyWzY0+8ch2ipE3I
         ePplD9kMUOgGg==
Received: from smtpclient.apple (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-hyfv10021501.me.com (Postfix) with ESMTPSA id A0D912C073E
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 23:41:09 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
From:   Panupong Somrit <panupong2190@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Tue, 4 Oct 2022 06:41:05 +0700
Subject: General questions or comments for the Git community can be sent to the mailing list by using the email address
Message-Id: <95F03C26-3625-415F-8A6E-B9BDA422BA70@icloud.com>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (19H12)
X-Proofpoint-GUID: XWAjTOUfRFo76vrfx7s4KcTmJoQFCA51
X-Proofpoint-ORIG-GUID: XWAjTOUfRFo76vrfx7s4KcTmJoQFCA51
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 clxscore=1011 mlxlogscore=677 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210030140
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCuC4quC5iOC4h+C4iOC4suC4gSBpUGhvbmUg4LiC4Lit4LiH4LiJ4Lix4LiZ
