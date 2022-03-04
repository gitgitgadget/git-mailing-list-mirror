Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7248CC433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 20:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiCDUwX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 15:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiCDUwV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 15:52:21 -0500
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4245972E4
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 12:51:33 -0800 (PST)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id B37F87E954; Fri,  4 Mar 2022 15:51:02 -0500 (EST)
References: <87fso0qphj.fsf@vps.thesusis.net>
 <CA+JQ7M8SF2cmZ7jagH-VdrZeR9Kfcw0GV=A1fpDeDubwJS1B8g@mail.gmail.com>
User-agent: mu4e 1.7.0; emacs 27.1
From:   Phillip Susi <phill@thesusis.net>
To:     Erik Cervin Edin <erik@cervined.in>
Cc:     git@vger.kernel.org
Subject: Re: gitk external diff on Windows
Date:   Fri, 04 Mar 2022 15:50:24 -0500
In-reply-to: <CA+JQ7M8SF2cmZ7jagH-VdrZeR9Kfcw0GV=A1fpDeDubwJS1B8g@mail.gmail.com>
Message-ID: <877d99bfwp.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Erik Cervin Edin <erik@cervined.in> writes:

> I'm guessing you're running this from git bash, in which case try
> cmd //c C:/Program Files/WinMerge/winmerge.bat
> See
> https://stackoverflow.com/a/21907301
>
> Basically a song and dance has to be done to work with Windows quirks.
>
> If you're still having issues, it's best to follow up in the Git for
> Windows discussion group
> https://groups.google.com/g/git-for-windows

Nope, that didn't help.  I guess I'll try there.
