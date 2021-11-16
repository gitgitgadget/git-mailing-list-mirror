Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F83C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 21:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E30D160EBC
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 21:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhKPVSO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 16:18:14 -0500
Received: from smtp-8fae.mail.infomaniak.ch ([83.166.143.174]:35943 "EHLO
        smtp-8fae.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229532AbhKPVSN (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 16 Nov 2021 16:18:13 -0500
X-Greylist: delayed 1774 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Nov 2021 16:18:13 EST
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4HtzNg2vsRzMpxxD
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 22:15:15 +0100 (CET)
Received: from [10.10.10.4] (unknown [51.15.56.3])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4HtzNg0kbczlh8Tm
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 22:15:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=etguillot.fr;
        s=20191114; t=1637097315;
        bh=qhREOly5QhYfDxHGvTasoVqnmm1GiootqdkgCQBuxCc=;
        h=Date:To:From:Subject:From;
        b=FevvjuyTrSrDd7yKUNDi9s+mDgSy2eIrCeSs28Ara3URo4YgUAgWu0cxJsELzzQyK
         9G8hCNWoXykFvwLCqHIHJkcwTczErkX9rmetgu4bJoqAwKUbuST0QZsayIR7RuvXbd
         UrM791vK09n2IezgEBQMITgbbpX+0KMiIKhiHQqo=
Message-ID: <127c9dbd-4861-beea-a85b-af7412ce141f@etguillot.fr>
Date:   Tue, 16 Nov 2021 22:15:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     git@vger.kernel.org
From:   Etienne Guillot <git@etguillot.fr>
Subject: Need help in understanding how to submit a patch
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I found a typo mistake in the french translation of git-gui.
I did read the instructions on this page
https://git-scm.com/docs/SubmittingPatches
but I still not sure where should I push the correction.

Thanks for your help

Etienne Guillot
