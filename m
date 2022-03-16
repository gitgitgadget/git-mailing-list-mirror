Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8937AC433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 17:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357624AbiCPRhp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 13:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357617AbiCPRho (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 13:37:44 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90471674C1
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 10:36:25 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nUXZP-000CAm-Ex;
        Wed, 16 Mar 2022 17:36:24 +0000
Message-ID: <42d8eebd-f987-a24e-e47c-67334583568b@iee.email>
Date:   Wed, 16 Mar 2022 17:36:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Let's have a user experience workshop
Content-Language: en-GB
To:     Alice Merrick <amerrick@google.com>, git@vger.kernel.org
References: <CA+Yb-VSaeKy-g_ywkZzQuEX=k3EXM+Ky-rHOb2az0SHGVbdaVw@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <CA+Yb-VSaeKy-g_ywkZzQuEX=k3EXM+Ky-rHOb2az0SHGVbdaVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alice,

On 15/03/2022 21:04, Alice Merrick wrote:
> Hello Git,
>
> I’m doing a 20% project with the Git Core team at Google. I've been
> encouraged by Emily Shaffer and Jonathan Nieder to reach out to the
> Git community to help incorporate UX practices into the Git
> development cycle. My goal is to 1) gauge interest in improving Git's
> user experience and 2) recruit interested folks in organizing or
> attending a workshop where you can learn more about what UX is and
> discuss ways to bake UX into the process of making changes to Git to
> improve the experience for all users.
>
> Some additional context about me: I am a UX (user experience)
> professional at Google. I have experience applying UX and
> accessibility practices[1] to developer tools for searching,
> reviewing, debugging code, etc. For the past couple years I’ve worked
> with the Golang project on their websites and helped set project
> priorities by collecting community feedback through their annual
> developer survey[2].
>
> Interested?
> * Join the git UX Google group (https://groups.google.com/g/git-ux) if you
> are interested in participating in an event.
I joined the group, but there are no current entries, and, at present I
can't post anything.

I am interested in the UX from the perspective of Human Error and how we
form our mental models of the task at hand (e.g. see historic
discussions about the 'staging area').

Git does have rather a lot of non physical concepts to grasp, and now
that it's way beyond being just an SCM for the Linux kernel, the user
base has become rather diverse.

I'm a retired systems engineer who worked in defence electro-optics in
the UK. I am mainly on Windows.

> * Reply directly to this email if you are interested in organizing the
> event to discuss git UX (scheduling the event, sending invites,
> communicating with invitees)
>
>
> [1] https://doi.org/10.1145/3411764.3445544
> [2] https://go.dev/blog/survey2020-results
>
--
Philip
