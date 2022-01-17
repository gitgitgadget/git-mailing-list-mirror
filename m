Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB7BC433EF
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 17:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238100AbiAQRwJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 12:52:09 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:17161 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233337AbiAQRwI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 12:52:08 -0500
Received: from host-92-7-140-211.as13285.net ([92.7.140.211] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1n9WAp-0006ZC-9z;
        Mon, 17 Jan 2022 17:52:07 +0000
Message-ID: <cd22f664-a930-1850-3c62-a03f158298cc@iee.email>
Date:   Mon, 17 Jan 2022 17:52:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] README.md: add CodingGuidelines and a link for
 Translators
Content-Language: en-GB
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1115.git.1642182615339.gitgitgadget@gmail.com>
 <pull.1115.v2.git.1642349490723.gitgitgadget@gmail.com>
 <6271ff4b-1821-0086-167c-b273ab252eb9@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <6271ff4b-1821-0086-167c-b273ab252eb9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/01/2022 09:00, Bagas Sanjaya wrote:
> On 16/01/22 23.11, Philip Oakley via GitGitGadget wrote:
>> +Those wishing to help with error message translation (localization L10)
>> +should see [po/README.md][] (a `po` file is a Portable Object file that
>> +holds the translations).
>> +
>
> I mean not just error messages are in po/*.po, but also usage and
> informational
> strings. We can say "Those wishing to help translating message strings
> (localization or l10n)...".
>
Thanks, I've expended the README description.

Philip
