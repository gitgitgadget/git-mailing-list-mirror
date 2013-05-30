From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v7] Add new git-related helper to contrib
Date: Thu, 30 May 2013 17:38:25 +0530
Message-ID: <CALkWK0=LfhDtOAgsq2KYSCbTocf2R8FjTWg4S6jxGiGxDxeg1A@mail.gmail.com>
References: <1369884777-7227-1-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0=ZbOy6sXOvnTNAqz_UBsUymY1CR_WczT-O3Q+18HJjzQ@mail.gmail.com> <CAMP44s25vX1p1Np7yqc9_AqVBme+MCTY88hjhfWdL6KZkxgs7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 14:09:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui1fN-00079F-0y
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 14:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346Ab3E3MJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 08:09:09 -0400
Received: from mail-bk0-f42.google.com ([209.85.214.42]:38183 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab3E3MJH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 08:09:07 -0400
Received: by mail-bk0-f42.google.com with SMTP id jk14so101433bkc.1
        for <git@vger.kernel.org>; Thu, 30 May 2013 05:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=holkGLXTt13KdOwlT8G+9iwUj7ll1V8UZxgtMmX6XWw=;
        b=qHtE48v6yCve3D1vlx30ue7i+T/Z3fVQpMLL8kh9khbYTbG1TL4d1hL3QewQ7H/Ksa
         jFCcxuu2npW48210NifzRI38jEH/yHh2xymFxLWyhD7wrrPTsLz1RCC95dfvUHGcRgIw
         K1W+3hTooo6aCOoephj6/mnia/eqmHc2ZaZ4BHvryhEXdDahjbj5zX7CqQ3unpiBJ4m2
         wsTeO0MBTCyELX9Y7vZjqNFqEYMOMUwB4ilWd/ck3T+oebE6NI6AU1qV0exdWI+87LxQ
         QVE+1yjQJOHlKanj/s7xdNP5xcNErCNDm6p0H/c3QGnvDVI4Y4rfXuqeD2tr+tcj4a8Q
         YNAQ==
X-Received: by 10.205.44.193 with SMTP id uh1mr1766566bkb.14.1369915745854;
 Thu, 30 May 2013 05:09:05 -0700 (PDT)
Received: by 10.204.172.209 with HTTP; Thu, 30 May 2013 05:08:25 -0700 (PDT)
In-Reply-To: <CAMP44s25vX1p1Np7yqc9_AqVBme+MCTY88hjhfWdL6KZkxgs7Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225974>

Felipe Contreras wrote:
> What's your objective? Block this patch from ever going in?
>
> Not a single one of these comments makes a difference at all, all of
> them can wait until after the patch is merged, many of them are a
> matter of preferences, and some of them have already been addressed as
> precisely that: disagreements in style.

You posted a patch, and I reviewed it.  End of story.  I never
explicitly or implicitly indicated that I want to block the patch, so
stop pulling stuff out of your arse.

If you don't want a review, write "DO NOT REVIEW" (or better yet,
don't hit my inbox).  I'm not interested in wasting my time either.
