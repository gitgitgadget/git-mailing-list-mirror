Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23FFB2035A
	for <e@80x24.org>; Sat,  8 Jul 2017 04:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752673AbdGHEBA (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jul 2017 00:01:00 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:47062 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752190AbdGHEAq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2017 00:00:46 -0400
X-Greylist: delayed 43405 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Jul 2017 00:00:46 EDT
Received: from homiemail-a1.g.dreamhost.com (homie.mail.dreamhost.com [208.97.132.208])
        by hapkido.dreamhost.com (Postfix) with ESMTP id E42FA975B2
        for <git@vger.kernel.org>; Fri,  7 Jul 2017 08:57:20 -0700 (PDT)
Received: from homiemail-a1.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id 678C5348070
        for <git@vger.kernel.org>; Fri,  7 Jul 2017 08:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jidanni.org; h=from:to
        :subject:date:message-id:mime-version:content-type:
        content-transfer-encoding; s=jidanni.org; bh=it9R3PVfJLH9pkECtud
        Wkig9Vss=; b=A1KRYAPhCZkdr6QnKu2xEsKu8QrmH3te8rhCMg2x97oXvQmPCYN
        ffXUPJUp18sRh8wMTZvFgqdDnaMpoSms05FmxGxQdlTJhtnDsVajY6pe19CNiCHf
        NreUfPU7W2iOBtLCAWBocRMfJKclI4urHGHUXilMWN4wcIRCTrAg1Cas=
Received: from jidanni.org (114-41-20-60.dynamic-ip.hinet.net [114.41.20.60])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: jidanni@jidanni.org)
        by homiemail-a1.g.dreamhost.com (Postfix) with ESMTPSA id 2FB2B34806F
        for <git@vger.kernel.org>; Fri,  7 Jul 2017 08:57:20 -0700 (PDT)
From:   =?utf-8?B?56mN5Li55bC8?= Dan Jacobson <jidanni@jidanni.org>
To:     git@vger.kernel.org
Subject: 0 bytes/s vs. =?utf-8?Q?=E2=88=9E?= bytes/s
Date:   Fri, 07 Jul 2017 23:57:14 +0800
Message-ID: <87lgo02qat.fsf@jidanni.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Receiving objects: 100% (1003/1003), 1.15 MiB | 0 bytes/s, done.
Receiving objects: 100% (1861/1861), 11.74 MiB | 4.58 MiB/s, done.
Receiving objects: 100% (474/474), 160.72 KiB | 0 bytes/s, done.
Receiving objects: 100% (7190/7190), 26.02 MiB | 6.53 MiB/s, done.

If the connection is too fast to calculate, please report
=E2=88=9E bytes/s or
inf bytes/s or
? bytes/s or
anything but 0 bytes/s, which means nothing (transmitted.)
