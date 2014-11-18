From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: ag, **, and the GPL
Date: Tue, 18 Nov 2014 13:20:11 +0700
Message-ID: <CACsJy8CBUmfD9RotMzy=8FdMzetV01WQmgNgLvOhTFs86Z98wg@mail.gmail.com>
References: <CACr0F2iGY_vxWzsNaPQNJ2cLUDRZPS70i79EhyA9OkA7qLaUQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthew Kaniaris <mkaniaris@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 07:20:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqc9h-0006ST-7b
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 07:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbaKRGUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 01:20:43 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:61238 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbaKRGUm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 01:20:42 -0500
Received: by mail-ig0-f180.google.com with SMTP id h15so6549959igd.1
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 22:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Gmxpc7mLzOICY/kMhp3drZW7irJyAncmrHIUGhMh2fY=;
        b=wjpCHiLhWir9CVw6kVvJSh1ES8gxaMBVar5f5ZHd0a14aAvAosLbGnkpFTjZ9rChRQ
         kh0rJJ1YQV/tueaVNs41uMH/Q91WavOTeWQhhqsSC8E2XEd9x7TZdmd4+ShkQhK2GHCP
         ff8j8w1kJ27bU9xc5bC2d+XPaBN+10mzNuwhSNxBGnGr4KVGNw5WA0Rkmq1oooiLMDqd
         +5ON+DvHrLluMNZzuib+VqTeREhJ+cKpyPxBq0lmSdGcKNj3G2WX7JlDNeGs08cFCZvE
         YKiWmPIH3LfbTeJIBUMKk96KzU0XtEXjJYMPE3DaISytbsyDRCTWfFo+TC11sns4WZgm
         MorA==
X-Received: by 10.50.66.179 with SMTP id g19mr983503igt.40.1416291641837; Mon,
 17 Nov 2014 22:20:41 -0800 (PST)
Received: by 10.107.176.8 with HTTP; Mon, 17 Nov 2014 22:20:11 -0800 (PST)
In-Reply-To: <CACr0F2iGY_vxWzsNaPQNJ2cLUDRZPS70i79EhyA9OkA7qLaUQQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 18, 2014 at 11:50 AM, Matthew Kaniaris <mkaniaris@gmail.com> wrote:
>  Would you grant me
> permission to reuse wildmatch.c (and necessary includes) for use in

wildmatch (in git) is originally from rsync. You need to ask them for
permission as well. I'm ok with relicensing my changes in
wildmatch.[ch] to Apache License Version 2.0.
-- 
Duy
