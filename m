Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7E8D2013E
	for <e@80x24.org>; Sat,  4 Mar 2017 11:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbdCDLPa (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Mar 2017 06:15:30 -0500
Received: from forward14o.cmail.yandex.net ([37.9.109.194]:56859 "EHLO
        forward14o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751336AbdCDLP3 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 4 Mar 2017 06:15:29 -0500
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Mar 2017 06:15:29 EST
Received: from mxback10j.mail.yandex.net (mxback10j.mail.yandex.net [IPv6:2a02:6b8:0:1619::113])
        by forward14o.cmail.yandex.net (Yandex) with ESMTP id 3E5F221244
        for <git@vger.kernel.org>; Sat,  4 Mar 2017 14:00:24 +0300 (MSK)
Received: from web28h.yandex.ru (web28h.yandex.ru [84.201.187.162])
        by mxback10j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id wddB6YP0Xl-0NvG5vvS;
        Sat, 04 Mar 2017 14:00:23 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtolstov.org; s=mail; t=1488625223;
        bh=kjeX0gZ0LZKOVzTfeL9/xmV+7D6ZziC1UG+4lqvui8g=;
        h=From:To:Subject:Message-Id:Date;
        b=rMPKb3BzfRB+v1uMfJzojfLcAETfco6i4hWaH456GpYnBoz4zmWWixBvq0zL8gV37
         kz9kNNuaET02AB5Qs4LbjTPyg/8x1gIBxVWwTkmiGOoewIZ1GukR0ouvuO7q6MAaUk
         NRKdAGxIkwd24Hb1GpizwMssnQ6XdIFlx5mbG50k=
Authentication-Results: mxback10j.mail.yandex.net; dkim=pass header.i=@vtolstov.org
Received: by web28h.yandex.ru with HTTP;
        Sat, 04 Mar 2017 14:00:23 +0300
From:   Valery Tolstov <me@vtolstov.org>
To:     git <git@vger.kernel.org>
Subject: GSoC 2017
MIME-Version: 1.0
Message-Id: <5334661488625223@web28h.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sat, 04 Mar 2017 14:00:23 +0300
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

Want to participate in GSoC 2017 with Git.
Can I choose "Make 'git tag --contains <id>' less chatty" as my microproject?

Thanks.
