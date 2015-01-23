From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH 0/7] Coding style fixes.
Date: Fri, 23 Jan 2015 18:09:37 +0600
Message-ID: <CANCZXo4Ga5a0OjNhqSOP39p76RfOOX+N5cZhA8j9hjhKodTqcg@mail.gmail.com>
References: <1422011208-3832-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 13:09:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEd3W-0001Ut-73
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 13:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314AbbAWMJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 07:09:38 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:52376 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbbAWMJh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 07:09:37 -0500
Received: by mail-ob0-f176.google.com with SMTP id va2so6785691obc.7
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 04:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=D7lMvy9zKJLYl6MxzOHO0ScoLqUQGZyY2Q8LO0oyB5U=;
        b=NrQIx9o6dkQBVieKXJW+53z8J2h5xdydpH5ERHFEJ+24hnMzX1RDfITKxn+1UT6lBX
         Gnf9xxftNXvGl25tnslFj/KQyek/jYfgOvwPZMLdJGBXHqsvFTYeV55w8TNaZe1kIo2C
         YMxv2/IhTR3G2VmvACqrm7/9nkte6Oz1xgh/Oe+lenoJJ1RaeVubzI1G2OIW5UWxIkEp
         UosFX3zuPj8y3EX0nW4kz5tMhCVDmkJJtNooGdEYcB7rPE6QwLIoeYHceTx66MXfbEuw
         52H/3Ah30Y9GlCbSWylUjPkR0l1yvY4jBSLtIzhWdqbjbFCuUmznYRTY+yP1lZmh4eNm
         9IVw==
X-Received: by 10.182.103.232 with SMTP id fz8mr4160502obb.59.1422014977097;
 Fri, 23 Jan 2015 04:09:37 -0800 (PST)
Received: by 10.182.26.116 with HTTP; Fri, 23 Jan 2015 04:09:37 -0800 (PST)
In-Reply-To: <1422011208-3832-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262915>

I made separate patch for every file. Please, let me know if need to
squash it into one commit.


2015-01-23 17:06 GMT+06:00 Alexander Kuleshov <kuleshovmail@gmail.com>:
> This patch set contatins minor style fixes. CodingGuidelines contains
> rule that the star must side with variable name.
>
> Alexander Kuleshov (7):
>   show-branch: minor style fix
>   clone: minor style fix
>   test-hashmap: minor style fix
>   http-backend: minor style fix
>   refs: minor style fix
>   quote: minor style fix
>   fast-import: minor style fix
>
>  builtin/clone.c       | 2 +-
>  builtin/show-branch.c | 2 +-
>  fast-import.c         | 2 +-
>  http-backend.c        | 2 +-
>  quote.c               | 2 +-
>  refs.h                | 2 +-
>  test-hashmap.c        | 4 ++--
>  7 files changed, 8 insertions(+), 8 deletions(-)
>
> --
> 2.3.0.rc1.275.g028c360



-- 
_________________________
0xAX
