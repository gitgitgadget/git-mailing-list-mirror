From: David Aguilar <davvid@gmail.com>
Subject: Re: Why git shows staging area to users?
Date: Sat, 13 Oct 2012 17:56:39 -0700
Message-ID: <CAJDDKr7tUJ59jYDM-jhFnGMEB18taT7FsTJ24Hr=iBUgXXeYdg@mail.gmail.com>
References: <CAFT+Tg-g6KOs3YUKV_GWbZiO9qUG3LP8-T3Tdyd3LinnheQZ8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: semtlenori@gmail.com
X-From: git-owner@vger.kernel.org Sun Oct 14 03:00:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNCZb-0007ZX-AZ
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 03:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754244Ab2JNA4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2012 20:56:41 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:40905 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754180Ab2JNA4k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2012 20:56:40 -0400
Received: by mail-vc0-f174.google.com with SMTP id fk26so643472vcb.19
        for <git@vger.kernel.org>; Sat, 13 Oct 2012 17:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PTX5eLEbkLUVeI14dqW8CxzIBpfMbP+SA2MKM+6yjs4=;
        b=IWktPDirfT1Ijtedb5+ya6PxjUr6I6FSptWcjfHPY5VGEjQth3JUaOgJanAOHTfUyG
         H64uLPm5GL51nzTi242G7IqvEGjsWA0dXA3oeu8ZYh8nq+ZguuzdDMiOOX7N6dCYGMyY
         3d/1sp7nDS9tX3hdmmqwUPw6L2NR/a6Zu9/4eNq/Ysm5hHK6fLae+pLHfsEJ6Dvvbm6Y
         d3KE4RvckerpD1giWjlguyzr6ntKNRx622zmEQNggQhrxu/cA2pPZNciWPmLxfdU6Ca4
         0oukTdVFdUcGyjKeMb7wKJTAE3xQwsAbw2jhMZipWPpMZGq8nZ+iDhUKfLxPBYFUsmm0
         H0Ew==
Received: by 10.52.32.1 with SMTP id e1mr1328213vdi.68.1350176199516; Sat, 13
 Oct 2012 17:56:39 -0700 (PDT)
Received: by 10.58.182.10 with HTTP; Sat, 13 Oct 2012 17:56:39 -0700 (PDT)
In-Reply-To: <CAFT+Tg-g6KOs3YUKV_GWbZiO9qUG3LP8-T3Tdyd3LinnheQZ8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207589>

On Sat, Oct 13, 2012 at 2:08 PM, Yi, EungJun <semtlenori@gmail.com> wrote:
> Hi, all.
>
> Why git shows staging area to users, compared with the other scms hide
> it? What benefits users get?

http://thkoch2001.github.com/whygitisbetter/#the-staging-area
http://tomayko.com/writings/the-thing-about-git
http://gitready.com/beginner/2009/01/18/the-staging-area.html

Other scms do not "hide"; other scms lack this feature altogether.

> I feel staging area is useful, but it is difficult to explain why when
> someone asks me about that.

See above.
-- 
David
