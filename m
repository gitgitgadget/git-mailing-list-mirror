From: Graham Hay <grahamrhay@gmail.com>
Subject: Re: Seems to be pushing more than necessary
Date: Mon, 23 Mar 2015 10:56:59 +0000
Message-ID: <CAABECY3xLHr1CWsezF6EjSWKkYpAW9VPFk31zznzn12_GVgAeA@mail.gmail.com>
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
	<CAABECY2xqH9ya3WGO_VR54c4Yi4CJ2355Wdh=cggpUV348D6cg@mail.gmail.com>
	<CACsJy8Cddt7S0NLcdz1ji_dDWUn_wCxie4+zxs5Akx1ObAvNEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 11:57:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ya02c-0005Ir-4J
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 11:57:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbbCWK5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 06:57:01 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:34662 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbbCWK5A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 06:57:00 -0400
Received: by oier21 with SMTP id r21so137241233oie.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2015 03:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FDYsa+9pjAnGaYsfZTmwGb0wVVsgX5hPUXD/CBa2cNY=;
        b=hARK2oaKv/gb/lEQFi3mVMWMYW0zmuqyEVn1BSupOeTgvhwTsJXaZZH1aAqunXJbLD
         6LXXHmD1HraJy8oIfSv3nkGxU9s1xAHTkLp4Evh2RKlphzRIPVF0PgJRyQVpMiibauJH
         sVUMYuoSs0UhhmmH7bdZWbbZPwQY1bMGqNDIpKrEGYcBs0qiUpP7oiwMbYhlxMEH6k9M
         I1uHPt1fl3eH9d248L9Vj/hcrRxWTXFGz5sX8pNUTd2OuAG7R+wGeYSNcDaY9oppU03+
         UScBdO9PnEoWP1cJXxOo7ZYl4XqdN/C5RscJwPPqUecSPtvJ7MfVmA93r+zlYLNkppYu
         wLuw==
X-Received: by 10.182.250.193 with SMTP id ze1mr75326513obc.70.1427108219839;
 Mon, 23 Mar 2015 03:56:59 -0700 (PDT)
Received: by 10.76.13.8 with HTTP; Mon, 23 Mar 2015 03:56:59 -0700 (PDT)
In-Reply-To: <CACsJy8Cddt7S0NLcdz1ji_dDWUn_wCxie4+zxs5Akx1ObAvNEw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266137>

If I push straight to the other repo, it only pushes the 3 objects I'd
expect (instead of 10,000+). So it looks like that is the problem, but
I don't really understand why.

>From my point of view, there should be no difference, but I clearly
don't understand how it actually works. How does git decide what refs
and/or objects are the same?

For a bit of background, the reason I have 2 remotes is to try and
avoid pushing to master. We work in a highly regulated industry, and
our code needs to be reviewed before hitting the mainline. So I push
to my fork and create a PR to the blessed repo, that way if I
accidentally commit to master (I have form!) then I have an extra
chance to catch it and don't have to back it out.

The two repos started out the same though, the only differences should
be the new work I have done. Is there any way I can continue to work
like this, or do I have to choose between slow pushes and safety?

On 23 March 2015 at 10:41, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Mar 23, 2015 at 5:35 PM, Graham Hay <grahamrhay@gmail.com> wrote:
>> Hmm. I'm using a "private" fork of a repo, I pull from one and push to
>> the other, e.g.
>>
>> git fetch foo
>> git rebase foo/master
>> git push --set-upstream origin bar
>>
>> It's quite possible my workflow is causing the problem, but I'm not
>> sure what I could do differently. What do you mean by a "no-share
>> remote"?
>
> I mean the refs (and associated objects) that are available on "foo"
> may be not available on "bar" so when you push to "origin" you just
> need to send more. That rebase could generate lots of new objects to
> push out too, I think.
> --
> Duy
