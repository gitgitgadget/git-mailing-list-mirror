Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9367C77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 15:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244199AbjD0PcL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 11:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244139AbjD0PcI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 11:32:08 -0400
X-Greylist: delayed 159 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Apr 2023 08:32:02 PDT
Received: from mail.sysgo.com (mail.sysgo.com [159.69.174.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B3C4C37
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 08:32:01 -0700 (PDT)
Received: from lantia.sysgo.com ([172.20.1.5]:38002)
        by mail.sysgo.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <guillaume.noailhac@sysgo.com>)
        id 1ps3Ya-0005kl-2X
        for git@vger.kernel.org;
        Thu, 27 Apr 2023 17:29:16 +0200
Message-ID: <235af3bc-57e3-283f-6d4d-177ccf273909@sysgo.com>
Date:   Thu, 27 Apr 2023 17:29:16 +0200
MIME-Version: 1.0
To:     git@vger.kernel.org
Content-Language: en-US
From:   Guillaume Noailhac <guillaume.noailhac@sysgo.com>
Subject: difftool does not support --submodule=diff
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-512; boundary="------------ms070304070309000305000508"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms070304070309000305000508
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello


I would like to see the complete directories diff of my git project 
using the command difftool.

Today the command difftool does not support --submodule=diff.

Is it fixable ?


My current version of git is:

git version 2.34.1

and my difftool is meld;


Best regards

Guillaume Noailhac


--------------ms070304070309000305000508
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
AAA=
--------------ms070304070309000305000508--
