Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10AC52022A
	for <e@80x24.org>; Tue,  8 Nov 2016 14:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751615AbcKHObq (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 09:31:46 -0500
Received: from vs19.mail.saunalahti.fi ([62.142.117.200]:51866 "EHLO
        vs19.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbcKHObp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 09:31:45 -0500
X-Greylist: delayed 351 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Nov 2016 09:31:45 EST
Received: from vams (localhost [127.0.0.1])
        by vs19.mail.saunalahti.fi (Postfix) with SMTP id 6382A2017A
        for <git@vger.kernel.org>; Tue,  8 Nov 2016 16:25:52 +0200 (EET)
Received: from gw03.mail.saunalahti.fi (gw03.mail.saunalahti.fi [195.197.172.111])
        by vs19.mail.saunalahti.fi (Postfix) with ESMTP id 4A2A52017A
        for <git@vger.kernel.org>; Tue,  8 Nov 2016 16:25:52 +0200 (EET)
Received: from macpro.local (62-78-248-13.bb.dnainternet.fi [62.78.248.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by gw03.mail.saunalahti.fi (Postfix) with ESMTPSA id 9421720062
        for <git@vger.kernel.org>; Tue,  8 Nov 2016 16:25:48 +0200 (EET)
To:     git@vger.kernel.org
From:   Heikki Lindholm <holin@iki.fi>
Subject: Git packages for obsolete OS X'en
Message-ID: <5821E066.90206@iki.fi>
Date:   Tue, 8 Nov 2016 16:25:42 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello list,

I packaged git for some obsolete platforms for my own use. In hopes that 
the work might prove useful to someone else, too, the packages can be 
found on sourceforge.

OS X 10.5 / PowerPC
https://sourceforge.net/projects/osxpowerpcpackages/files/Git/

OS X 10.6
https://sourceforge.net/projects/os-x-10-6-packages/files/Git/

My usage of git's feature set is rather limited, so there could be some 
features that do not work or are not even available in the builds.

Regards,
Heikki Lindholm
