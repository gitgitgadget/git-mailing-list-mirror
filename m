From: Scott Chacon <schacon@gmail.com>
Subject: Re: Best newbie / advanced / expert reference texts for Git?
Date: Fri, 19 Nov 2010 15:54:24 +0000
Message-ID: <AANLkTimckSDtkfoVqvEACNUhMHAKVvTKcCCmm=VdavJL@mail.gmail.com>
References: <AANLkTikctrASqX0FLCOapyJCt1VqG6_cxs_oXJ6fExZC@mail.gmail.com>
	<AANLkTik5ZYC66NicUvbDxJMiR_0iK3vPRAf9dGAQu+qW@mail.gmail.com>
	<AANLkTin_kS_2d=ajuGo-V_OWsF91xSb=SeKmrX9Aghe8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Patrick Doyle <wpdster@gmail.com>, Git ML <git@vger.kernel.org>
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 16:54:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJTIF-0003Ne-Uy
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 16:54:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754742Ab0KSPy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 10:54:27 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:65232 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054Ab0KSPy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 10:54:26 -0500
Received: by eye27 with SMTP id 27so2755701eye.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 07:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=UnLuumqZo8/l/7k7obPsjqLiYG61MgUo+yRSkNTlwT0=;
        b=mgOajKY51yBqhllE+ofv8+BINnn+ay0MtUcI1kJqEPvoctPxF8Ur1zeQtHlzbulcvO
         zZ0bAA/51IkrYgaaM8vF1utYL+O0SSokUzXdOfZQCSAUEPXrrTp0UVVvmZ0McUcLDv5V
         PEI2gwC+X6uA8eP9g09Gz1gZYFlSLSP3u8Uxk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=rMhbmruxAY28l2s5i8/7LiMseQ86cKkCkkuZLVZQQgyWa367BhkR5d7B7o5iq3gsal
         AKh48q9OjyTy9smTtA0LxRcUU4H7KyRKw9hpnWbmNtpx9HpXi5Yipa5kTJT2+60IC9c/
         /K1o8wbyhJazN9RbV/F3XvJBZRXyNzDtP0OFI=
Received: by 10.14.37.7 with SMTP id x7mr1411835eea.48.1290182064866; Fri, 19
 Nov 2010 07:54:24 -0800 (PST)
Received: by 10.14.119.197 with HTTP; Fri, 19 Nov 2010 07:54:24 -0800 (PST)
In-Reply-To: <AANLkTin_kS_2d=ajuGo-V_OWsF91xSb=SeKmrX9Aghe8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161761>

Hey,

On Fri, Nov 19, 2010 at 11:38 AM, Dun Peal <dunpealer@gmail.com> wrote:
> Thanks; sounds like it should serve well for the Advanced and possibly
> Intermediate categories. Still need a good text for the Newbie class.

For newbies as a sort of shorter tutorial/reference I also have
http://gitref.org
These and other resources are listed out in http://git-scm.com/documentation

> P.S. I glanced at it briefly and it seemed a bit out of date, but
> perhaps my inspection was too cursory.

It is up to date as of 1.6.x - I have pulled in updates in some parts
and added blog posts on newer features and whatnot, but the main text
even should not really be noticeably out of date.  At some point I
will roll the blog post updates back into the main text.

Do you have any examples?

Scott
