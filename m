From: Graham Hay <grahamrhay@gmail.com>
Subject: Re: Seems to be pushing more than necessary
Date: Mon, 23 Mar 2015 10:35:42 +0000
Message-ID: <CAABECY2xqH9ya3WGO_VR54c4Yi4CJ2355Wdh=cggpUV348D6cg@mail.gmail.com>
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
	<CACsJy8AqrBc4HKEKSHmkSq2wKwUgUEWrZu3=9-WGsM+txR8S-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 11:36:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZzi0-0000Is-NA
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 11:35:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350AbbCWKfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 06:35:45 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:36470 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013AbbCWKfn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 06:35:43 -0400
Received: by obdfc2 with SMTP id fc2so119731808obd.3
        for <git@vger.kernel.org>; Mon, 23 Mar 2015 03:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=i0X1LjqX1iALkNL+aedL4tlCdrL/iLPEfWYlu37KrZw=;
        b=aHZRjs18JPaXrYbzJShb+FLzEIIxxytOrFppnkHayytjcC3onUPrrvCspFC302J8vD
         CenZZqd8zUfGe33PsEv3jtS7Wdew7tMy0GLJIhIFXDPqrRWMIJ+wRInVqX6GhZ5G2X81
         /5STdOQO/HmjMur+NCxo29y416KCDht8Ffv5yH7VBRuIFT7bDMQTlJqCDi4XkNc6ALrY
         SWE4QeVaMuF77yC/YuiUEJ/FY5jpp+cNTKkazzFyMiCJyfAM7tNTMBaScemG3hwVKH12
         /+b6QdDyuZCFMOZmxbEHoQEmVzGfB9lpMTz1cpEi9r1VMbLFc/e2PWtUProjCGPZ2l4l
         Af8w==
X-Received: by 10.202.190.135 with SMTP id o129mr10625711oif.106.1427106943052;
 Mon, 23 Mar 2015 03:35:43 -0700 (PDT)
Received: by 10.76.13.8 with HTTP; Mon, 23 Mar 2015 03:35:42 -0700 (PDT)
In-Reply-To: <CACsJy8AqrBc4HKEKSHmkSq2wKwUgUEWrZu3=9-WGsM+txR8S-g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266134>

Hmm. I'm using a "private" fork of a repo, I pull from one and push to
the other, e.g.

git fetch foo
git rebase foo/master
git push --set-upstream origin bar

It's quite possible my workflow is causing the problem, but I'm not
sure what I could do differently. What do you mean by a "no-share
remote"?

On 23 March 2015 at 10:05, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Mar 19, 2015 at 6:11 PM, Graham Hay <grahamrhay@gmail.com> wrote:
>>> Try "fast-export --anonymize" as that would help us understand this.
>>
>> Attached.
>
> The bad news is it seems to be working for me (I recreated the remote
> repo from this dump). I notice that you have two remotes, one shares
> many refs (the remote "ref39"). The other, "ref2", does not share any
> SHA-1 with refs in ".git/refs/heads/". Any chance you push to a
> no-share remote, which results in a lot of objects to be sent?
> --
> Duy
