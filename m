From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Seems to be pushing more than necessary
Date: Mon, 23 Mar 2015 17:41:30 +0700
Message-ID: <CACsJy8Cddt7S0NLcdz1ji_dDWUn_wCxie4+zxs5Akx1ObAvNEw@mail.gmail.com>
References: <CAABECY3HbZ4q3uo82outUmCyQLXO39H+Fd2m8bLwkaubE9gJCw@mail.gmail.com>
 <CAABECY1_L34sq0VPmD9UwRcwb3Fuh95OFcF26LM2eX1z-+8vkQ@mail.gmail.com>
 <CACsJy8Au48iFoC=Eo4T-fm6r6tA7VffRJyH2JbuC==wa61=G5A@mail.gmail.com>
 <CAABECY2_MQWAkOu=6rR=mN=wKz-Yfzsu8o2+wb6F+h4FjBe9Mw@mail.gmail.com>
 <CACsJy8DdjDnacVGU83iUDj5Na1xxS6kNDbK2D0Apfv0LAuzDvA@mail.gmail.com>
 <CAABECY2_A83tWaqb_6YzXwr0Tv5AYVq0KW70j+EHqrx69k2P_A@mail.gmail.com>
 <CACsJy8AFi8-EgUJNr+KTOngeUaGfi_O5f_=qba08qJs1jcEj=w@mail.gmail.com>
 <CACsJy8BqA2dm8DpDrrFN4FxHG+4gnG3Q7c3kM=YmBrkuHftvog@mail.gmail.com>
 <CAABECY13XT3+rEGGtKfe3Xwg4RtzcWtpL=Nm7aivv4_35TvL0w@mail.gmail.com>
 <CACsJy8D16ERGH=P4etGRpZM_3BR9iYZBsUnWBGAbayVqmEhhXw@mail.gmail.com>
 <CAABECY2x=G+nYdSyxpz8MvE4G6RSwcGSXu1LzwAKYG7Mqwk1kA@mail.gmail.com>
 <CACsJy8B=Dx2+OWch1zx_xg91de9yhttVMwgE1SxDOuSTns2b_w@mail.gmail.com>
 <CAABECY063__YDW2jXPSnuvxp0kj=jB+k09mOEW3suEn5syAyXQ@mail.gmail.com>
 <CACsJy8AqrBc4HKEKSHmkSq2wKwUgUEWrZu3=9-WGsM+txR8S-g@mail.gmail.com> <CAABECY2xqH9ya3WGO_VR54c4Yi4CJ2355Wdh=cggpUV348D6cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Graham Hay <grahamrhay@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 11:42:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZzo7-0004Gu-Ib
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 11:42:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195AbbCWKmC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 06:42:02 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:38262 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbbCWKmB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 06:42:01 -0400
Received: by igbqf9 with SMTP id qf9so34555314igb.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2015 03:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Wcc2Yd5aaYQzCuu0VhRjjRNxYmZ00IyM9oK0mz2GlGk=;
        b=soGOP6LZZOU/FRudgs5OqvFdS7amWCzso2jAxr8LDI3w7GZYnA3hpcoK/Fq7B7QTNx
         Bsm7Mdh0eTUhLhHzXKk3bdFEoBNI7f1bsOxhVLTeI9uXJ5gTBj/dnWT0Zb1qhRht2PuV
         kafTw0p8i0GUyuBJHGOVSZLxtEU/0qMb90vFhOdsvXckYSDByiOgcqWY5HDEACwCaP/G
         w75UQLzV3fAa3plds/teeUKHo1Z+q8bfMElOHW0pHfwKMiSM4ylJetAWe3+kKE6CewbW
         D5DO6p6VvjQuUGJJXjgVFm+QUy2QybgPsJQLiJKWRKvCOXyOpPTl6AEF8MG9ynzUd6Tk
         Dt8A==
X-Received: by 10.107.8.67 with SMTP id 64mr82313847ioi.61.1427107320630; Mon,
 23 Mar 2015 03:42:00 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Mon, 23 Mar 2015 03:41:30 -0700 (PDT)
In-Reply-To: <CAABECY2xqH9ya3WGO_VR54c4Yi4CJ2355Wdh=cggpUV348D6cg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266136>

On Mon, Mar 23, 2015 at 5:35 PM, Graham Hay <grahamrhay@gmail.com> wrote:
> Hmm. I'm using a "private" fork of a repo, I pull from one and push to
> the other, e.g.
>
> git fetch foo
> git rebase foo/master
> git push --set-upstream origin bar
>
> It's quite possible my workflow is causing the problem, but I'm not
> sure what I could do differently. What do you mean by a "no-share
> remote"?

I mean the refs (and associated objects) that are available on "foo"
may be not available on "bar" so when you push to "origin" you just
need to send more. That rebase could generate lots of new objects to
push out too, I think.
-- 
Duy
