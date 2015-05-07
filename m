From: Alangi Derick <alangiderick@gmail.com>
Subject: Re: [PATCH] Fixed translation error in config.c file
Date: Thu, 7 May 2015 12:36:56 +0100
Message-ID: <CAKB+oNtkKQ+za8VkO0B9m0K=UqNoOSn_+zwZeFW_aOiV7Wk5aQ@mail.gmail.com>
References: <554a8472.8c3bc20a.458e.ffffdae7@mx.google.com>
	<xmqqpp6ds5jh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 07 13:37:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqK6w-0007n9-8X
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 13:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017AbbEGLg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 07:36:57 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:33021 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbbEGLg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 07:36:56 -0400
Received: by qgdy78 with SMTP id y78so19010295qgd.0
        for <git@vger.kernel.org>; Thu, 07 May 2015 04:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9SJbHbPRFJ4RgB9G8ZtuWI7VlW2ox95XufeR/PRpj9E=;
        b=MNzd9b3d8td8JZuTwX+YKlKbVd24JLcO4laBnXBTabcnLl9VxYlQWIqAjxeo5tp1j8
         Iu/TMIzJ+BCsR8kryhymsi4aAQ/d7HNzJSh3gI2nRKawplJl5MsmXcOu7zmuhSg1GDSh
         0+5aGIqlCG6iNgLxdZhFhOVxt7UrKchij92doQrPMqGoE0P8ioKxIJi5y4J64KTVrUXP
         WXcpq2GLUmBIaM6BBE3+ELbXpGCxk05HZO678DOpS8DmoZg9RHoR14VbvGRTJceAIxRn
         p1nMcX6aO3w/kELoDsUOFQSSKaDDVBMecEqGRxGfjDzVJR11/+6kk7A327J0hs+3S6bU
         kCrA==
X-Received: by 10.55.40.132 with SMTP id o4mr7077235qko.61.1430998616204; Thu,
 07 May 2015 04:36:56 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Thu, 7 May 2015 04:36:56 -0700 (PDT)
In-Reply-To: <xmqqpp6ds5jh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268528>

So what should the Title be? Please i am learning this community so i
have to make a lot of mistakes. Pardon me.
Regards
Alangi Derick Ndimnain


On Wed, May 6, 2015 at 11:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>>> Cc: unlisted-recipients:; (no To-header on input)
>
> Not again X-<.
>
> You are sending this to a single recipient which is the mailing
> list.  Send it "To: git@vger.kernel.org".
>
>>> Subject: Re: [PATCH] Fixed translation error in config.c file
>
> Ehh, how many times do I have to say this is *not* "fixing
> translation errors"?
>
> maintainer starts wondering if he is deliberately being ignored, and
> stops reading...
>
>
>
