From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Why git shows staging area to users?
Date: Sun, 14 Oct 2012 07:39:17 +0530
Message-ID: <CAMK1S_hLDabfANbjrWEF6ZND7OZkAxxpGEeKdv2-3B5pmjiU1g@mail.gmail.com>
References: <CAFT+Tg-g6KOs3YUKV_GWbZiO9qUG3LP8-T3Tdyd3LinnheQZ8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: semtlenori@gmail.com
X-From: git-owner@vger.kernel.org Sun Oct 14 04:09:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNDe4-0000uU-If
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 04:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119Ab2JNCJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2012 22:09:19 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:54189 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099Ab2JNCJT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2012 22:09:19 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so2710819lag.19
        for <git@vger.kernel.org>; Sat, 13 Oct 2012 19:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LBI/wUX1/gF9VF8rp+CMfYWUOlkf9bIuqR+3kmVG/ZM=;
        b=IhJYsWW4HkjfFSgKfSwTd0lI6dTkbKFUoerqNfx5kOgs3a5no9M++kf+KnN0nSlfjP
         mLKXIoPhNJXP4qvLnUpsHy9hiO67DfveAilMdPt7XVKQff86kZgPt3bUBzxo7QVmmrSA
         Bifn4mh8VeQnaKYVBtQeKW/EVwdyY4mN044zo5SizDoNanaFeMkng+QkFWCZVxLsspX/
         8km99f5U8anaVIP+YwFmnrqfCNbin3WD2UN8yvvToGZ86nolFizEJ4kIfjMEO/e5Xgfx
         tcOdpwNWrNM/LNl7WM+a0bw2xEoHaZQ7Zg7QpU51E4xqjeFb2N4YgKzxLsP5OfWIBtHg
         QUlg==
Received: by 10.152.148.169 with SMTP id tt9mr7042039lab.15.1350180557648;
 Sat, 13 Oct 2012 19:09:17 -0700 (PDT)
Received: by 10.112.84.97 with HTTP; Sat, 13 Oct 2012 19:09:17 -0700 (PDT)
In-Reply-To: <CAFT+Tg-g6KOs3YUKV_GWbZiO9qUG3LP8-T3Tdyd3LinnheQZ8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207590>

On Sun, Oct 14, 2012 at 2:38 AM, Yi, EungJun <semtlenori@gmail.com> wrote:
> Hi, all.
>
> Why git shows staging area to users, compared with the other scms hide
> it? What benefits users get?
>
> I feel staging area is useful, but it is difficult to explain why when
> someone asks me about that.

I wrote this a long time ago, more for my understanding than
otherwise, but maybe it is useful:
http://sitaramc.github.com/concepts/uses-of-index.html
