From: =?UTF-8?B?0JvQtdC20LDQvdC60LjQvSDQmNCy0LDQvQ==?= 
	<abyss.7@gmail.com>
Subject: Re: Error message: unable to open object pack directory:
 .git/objects/pack: Too many open files
Date: Wed, 13 Nov 2013 11:00:39 +0400
Message-ID: <CAJc7Lbp4tM2a=1zNxnv=p6yjJmXZg7pLFbNs8pg-hBQd0pOFXQ@mail.gmail.com>
References: <CAJc7LbpSgRLxj62YRb3+n9Ty=LphoGv+Ox=R-nMS+458rrjw-w@mail.gmail.com>
	<CACsJy8BiBmeYuZ3VVyvocB969sYpdFNCOJ8GYSA2his5Vebg=g@mail.gmail.com>
	<CAJc7Lbqaas0Czdvcfn8+iceoyxaVSHOaV9jCJsy4mWH+AbV41Q@mail.gmail.com>
	<CACsJy8AHjAgSFzZ2R2Nup=GcuQJdaedbGXhRpcCT6HuaaLUtaQ@mail.gmail.com>
	<CAGyf7-GO1x5xCN-W_K+mvYU2-HdF1Gxu15wwZW7uiGWfdZfybw@mail.gmail.com>
	<CACsJy8CMrA9SkeHypQnTqOtigjb_NM3A3gyLPeD_KR_P5EBtdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Bryan Turner <bturner@atlassian.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 13 08:00:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgURZ-0003oA-7n
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 08:00:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758629Ab3KMHAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Nov 2013 02:00:46 -0500
Received: from mail-ve0-f177.google.com ([209.85.128.177]:64422 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758324Ab3KMHAk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Nov 2013 02:00:40 -0500
Received: by mail-ve0-f177.google.com with SMTP id jz11so4064803veb.36
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 23:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MjVz8i5TltFyPCOyPt5GNyKll+ubIcC9o9Y/2bmAl1A=;
        b=D71e7untn8yIMmeWxqwbjpNAi5R6zFjyLXtM1AUd7HJJmEnq48URKgaQfzVkDrUB3/
         wWbMpr8eDC3FWK81HRL80XpdNxRKaSPuap4vpMcfYsvoepZPS6gmxqram+3omhCr2h+9
         uASGj8H6SD3VibxufPjLEVmUfpXzswR4idW9PjF3YQcCeJFEXioChTdMtF286ddTJ/qf
         vrLfs136qyvwaAhBfr2GSTGI1y366RualaWjofZbr36fBuRsLkYUJrPshn3jbsUd10zj
         FfNPiFJ6E15iGek1ro3+2NasiuV4yypFCXjPDCCZRZZYN+V9yznLFEHrvI8FAu1YtfLf
         YCnA==
X-Received: by 10.220.174.200 with SMTP id u8mr32895591vcz.6.1384326039942;
 Tue, 12 Nov 2013 23:00:39 -0800 (PST)
Received: by 10.58.109.71 with HTTP; Tue, 12 Nov 2013 23:00:39 -0800 (PST)
In-Reply-To: <CACsJy8CMrA9SkeHypQnTqOtigjb_NM3A3gyLPeD_KR_P5EBtdQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237779>

I've tried your commit.
No more error messages.

Looking forward to the next git version.
Thanks.

On 13 November 2013 07:32, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Nov 13, 2013 at 10:04 AM, Bryan Turner <bturner@atlassian.com> wrote:
>>> but it's only available in v1.5.0-rc0 or rc1. Could you try that
>>> version?
>>
>> I believe you mean 1.8.5-rc0 or 1.8.5-rc1, is that correct?
>
> Yes. Looks like my fingers are not controlled by my mind anymore.
> --
> Duy
