From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: GSoC - Some questions on the idea of
Date: Thu, 12 Apr 2012 16:08:15 -0500
Message-ID: <4F87443F.10207@gmail.com>
References: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com> <CACsJy8APtMsMJ=FrZjOP=DbzuFoemSLJTmkjaiK5Wkq9XtA4rg@mail.gmail.com> <loom.20120328T131530-717@post.gmane.org> <CA+M5ThTPyic=RhFL2SvuNB0xBWOHxNTaUZrYMB144UjpjCiLoQ@mail.gmail.com> <20120330203430.GB20376@sigill.intra.peff.net> <CA+M5ThR6jtxqs0-Kz-8fcRuOFRbLr-GvsJcTmrOQ7_geNspDLg@mail.gmail.com> <4F76E430.6020605@gmail.com> <4F772E48.3030708@gmail.com> <20120402210708.GA28926@sigill.intra.peff.net> <4F84DD60.20903@gmail.com> <20120411213522.GA28199@sigill.intra.peff.net> <4F872D24.8010609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Bo Chen <chen@chenirvine.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 23:08:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIRFg-0000Kd-51
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 23:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756245Ab2DLVIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 17:08:19 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54464 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755958Ab2DLVIS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 17:08:18 -0400
Received: by yenl12 with SMTP id l12so1377911yen.19
        for <git@vger.kernel.org>; Thu, 12 Apr 2012 14:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=PdvFci2A8f8+6ygoiJ7MNn0DTays7nG4y87mtcvJ+Ak=;
        b=OePZW1tF5EuY6clGWxkHUbTweSAVkiPm5mbA/5va+l9h0WRzedePcDSskFUOF8Zlsl
         XIAwVBV69M3i2n5+g2Crg5ks86ZrQORl69bMQwyqZ21kDEeJXLc+SF6FhnE7UCR3nzXM
         vOkBTCwkj6YM1EaXkhJhaqHisNziIhxg1dv8KuPee/dX6kgfjpARBO5psogE0lb/PGLx
         ccIeuDrfiQhUEu0CmQo/Bn+DlqiDjSVQOm13s2dTdjhR7/gekF1b/c2A2lCuimY9y7oz
         n8W8WxFJoz/0h4D2TKAOfSvpPovi1uFGxNTTeHaV2BCud4gn+ztmS8BGZ7lNvYesfLZL
         cSgA==
Received: by 10.60.13.196 with SMTP id j4mr5171951oec.14.1334264897483;
        Thu, 12 Apr 2012 14:08:17 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id i6sm8033082obv.5.2012.04.12.14.08.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Apr 2012 14:08:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <4F872D24.8010609@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195372>

On 4/12/2012 2:29 PM, Neal Kreitzinger wrote:
>
> ...ironically I am probably the only git user who has to import from 
> git (powers-that-be mandated cvs-style menu controlled git-repo) into 
> git (separate normal git repo and commandline), do the work in normal 
> git, and then export it back into git (cvs-style menu controlled 
> git-repo).)
>
>
aka, git-cotton-picking  ;-)

v/r,
neal
