Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171B3C38A05
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 21:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379773AbiDDVU4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380529AbiDDUWs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 16:22:48 -0400
Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB26736B60
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 13:20:51 -0700 (PDT)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4KXMbg0MjSz5tlD;
        Mon,  4 Apr 2022 22:20:46 +0200 (CEST)
Message-ID: <624935bb-0612-76e7-64f1-3614db0765a2@kdbg.org>
Date:   Mon, 4 Apr 2022 22:20:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 7/7] git-sh-setup: don't mark trees not used in-tree
 for i18n
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>
References: <cover-v2-0.5-00000000000-20211119T202455Z-avarab@gmail.com>
 <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com>
 <patch-v3-7.7-7a82b1fd005-20220326T171200Z-avarab@gmail.com>
 <2e2d20d6-a33d-b223-d364-ab43d92dd220@kdbg.org>
 <220327.8635j3fx3t.gmgdl@evledraar.gmail.com>
 <63bf6e97-1dca-c2b1-5673-301039e73acf@kdbg.org>
 <220328.86lewudzw3.gmgdl@evledraar.gmail.com>
 <45c963da-19a5-de51-34d4-5b29f461c9ec@gmail.com>
 <220331.86a6d6qqfe.gmgdl@evledraar.gmail.com>
 <12c7c651-49d2-d38b-122a-3fb5c29e94df@kdbg.org>
 <220402.86r16fn2bx.gmgdl@evledraar.gmail.com>
 <cc9aaba3-6904-4f96-db50-a368b9d9f0f2@kdbg.org>
 <220403.86fsmukvp5.gmgdl@evledraar.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <220403.86fsmukvp5.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please appologize that I do not reply to your arguments directly. I
think I have said all I can. Perhaps I am unable to express my concerns
sufficiently clearly.

-- Hannes
