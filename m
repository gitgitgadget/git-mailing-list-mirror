Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5F691FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 18:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbcFWS5K (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 14:57:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49267 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbcFWS5J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 14:57:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 59BB361388; Thu, 23 Jun 2016 18:57:08 +0000 (UTC)
X-Spam-Checker-Version:	SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mfick1-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mfick@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 1823161378;
	Thu, 23 Jun 2016 18:57:08 +0000 (UTC)
From:	Martin Fick <mfick@codeaurora.org>
To:	John Ajah <john@spinlet.com>, git@vger.kernel.org
Subject: Re: GIT admin access
Date:	Thu, 23 Jun 2016 12:57:06 -0600
Message-ID: <4246181.WMWZBxU0cj@mfick1-lnx>
User-Agent: KMail/4.8.5 (Linux/3.2.0-97-generic; KDE/4.8.5; x86_64; ; )
In-Reply-To: <CAMoxcSXTVUBAECoNk0ePzWLZ2ShRXz5uZ8mHNgEcu0FqZMADSg@mail.gmail.com>
References: <E9A37D7D-AA14-48CD-83CA-819766313D78@spinlet.com> <1707153.Ui0LYF9gxZ@mfick1-lnx> <CAMoxcSXTVUBAECoNk0ePzWLZ2ShRXz5uZ8mHNgEcu0FqZMADSg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Brigning this back on list so that someone else can help...

On Thursday, June 23, 2016 05:01:18 PM John Ajah wrote:
> I'm on a private git, installed on a work server. Now the
> guy who set it up is not available and I want to give
> access to someone working for me, but I don't know how to
> do that.

I don't know what type of setup a "private git" means?  Is 
this a machine with ssh access, is it git-daemon, git-hub, 
git-olite, gerrit, ...?


> This is the error the developer got when he tried cloning:
> 
> FATAL ERROR: Network error: Connection timed out
> fatal: Could not read from remote repository.
> 
> Please make sure you have the correct access rights
> and the repository exists.
> 
> My partner wants to set up another Git server and transfer
> our content to the new server from the one we're
> currently using. I think this is very risky and I also
> think there has to be a way to provide access without
> doing this.

We need to know what product you are running to help.  

What risks are you concerned with setting up another server?  
And what kind of server would you be setting up?

-Martin


-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

