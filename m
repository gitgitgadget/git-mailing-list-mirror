Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884B4C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 17:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CCA661BA2
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 17:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239672AbhKQRy4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 12:54:56 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:48469 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237331AbhKQRyx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 12:54:53 -0500
Received: (Authenticated sender: me@yadavpratyush.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 4FAF7240006;
        Wed, 17 Nov 2021 17:51:51 +0000 (UTC)
Date:   Wed, 17 Nov 2021 23:21:49 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Etienne Guillot <git@etguillot.fr>, git@vger.kernel.org
Subject: Re: Need help in understanding how to submit a patch
Message-ID: <20211117175149.7slohfqqwsmn3ua6@yadavpratyush.com>
References: <127c9dbd-4861-beea-a85b-af7412ce141f@etguillot.fr>
 <6fa0b1dd-ac20-ff55-95ea-1c22347f9199@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6fa0b1dd-ac20-ff55-95ea-1c22347f9199@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Etienne,

On 17/11/21 03:47PM, Philip Oakley wrote:
> On 16/11/2021 21:15, Etienne Guillot wrote:
> > Hi,
> >
> > I found a typo mistake in the french translation of git-gui.
> > I did read the instructions on this page
> > https://git-scm.com/docs/SubmittingPatches
> > but I still not sure where should I push the correction.
> >
> > Thanks for your help
> >
> > Etienne Guillot
> Hi Etienne
> 
> The Git Gui is managed by Pratyush Yadav (cc'd) and hosted at 
> https://github.com/prati0100/git-gui
> 
> Not sure what the latest is on contributing translations (not covered in
> the GitHub Readme..).

I usually ask people to post patches on this mailing list and I review 
them here. But I make an exception for translation changes since they 
never get any reviews anyway.

So I am fine with either a Pull Request on GitHub or a patch on the 
mailing list.

-- 
Regards,
Pratyush Yadav
