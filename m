Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2E801F463
	for <e@80x24.org>; Sat, 14 Sep 2019 07:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfINHY5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Sep 2019 03:24:57 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:14226 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727188AbfINHY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Sep 2019 03:24:57 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 46VkY310V7z5tlB;
        Sat, 14 Sep 2019 09:24:55 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 2A5B4DE;
        Sat, 14 Sep 2019 09:24:54 +0200 (CEST)
Subject: =?UTF-8?Q?Re=3a_Git_Gui_-_enhancement_suggestion_-_Can_a_double_cli?=
 =?UTF-8?Q?ck_on_the_file_name_in_the_=e2=80=9cunstaged=e2=80=9d_area_move_t?=
 =?UTF-8?Q?he_item_to_=e2=80=9cstaged_changes=e2=80=9d?=
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Allan Ford <allan.ford17@gmail.com>, git@vger.kernel.org
References: <CAL-6oQorDOzAr4sDoddoAQv3hzAgUMx7K+V=bMcvScv8G=7oqg@mail.gmail.com>
 <20190913143229.5yop5oaascgavynl@yadavpratyush.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <e40eb879-125d-70c3-fed9-217c0f057bcd@kdbg.org>
Date:   Sat, 14 Sep 2019 09:24:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190913143229.5yop5oaascgavynl@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.09.19 um 16:32 schrieb Pratyush Yadav:
> Is partial single and partial double click behaviour acceptable? Or 
> should we make the entire row double click only? Or something else that 
> I missed?

I don't mind adding the suggested double-click action, but removing the
single-click action would be a step backward IMO.

-- Hannes
