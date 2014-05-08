From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Thu, 08 May 2014 15:15:58 -0500
Message-ID: <536be5feea670_3ce710a12ecc0@nysa.notmuch>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com>
 <536a83097302f_76ff7a52ec6c@nysa.notmuch>
 <xmqqvbth8ha9.fsf@gitster.dls.corp.google.com>
 <536a999e2c0c_76ff7a52ec1e@nysa.notmuch>
 <xmqqoaz95ees.fsf@gitster.dls.corp.google.com>
 <536ad9601b73b_3caaa612ecdc@nysa.notmuch>
 <CAHYYfeGvOnonm0fd=Fa9p_if+8dRo2zg_N9c=gjjqyko=ipJag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	John Keeping <john@keeping.me.uk>,
	=?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>,
	Scott Chacon <schacon@gmail.com>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: James Denholm <nod.helm@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 08 22:26:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiUu6-00071M-Bj
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 22:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753994AbaEHU0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 16:26:50 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:44168 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856AbaEHU0t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 16:26:49 -0400
Received: by mail-ob0-f178.google.com with SMTP id va2so3753998obc.9
        for <git@vger.kernel.org>; Thu, 08 May 2014 13:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=CJpYM1RcijFekE1KfX6Td5UMTrCyC18Fdp2uvuNQixY=;
        b=wNXfIz2o4+UPr4+HNcNuhz45Fu78MwCMnqdf9OYoEH4otHcRSd32WPMbAAKovG39/o
         8DVW+xU9KRVdLWl+KI50Q+6nvJ5a//a/bjQcBN29IdmkRNnXPG3SyXxFYcpzozQknFwo
         eU71qgUYnyW390EvdaVC7wth1vtG3Amfj+BlU9ZWzmMkh4zAMkJP/A8XfCy88QtNdj3P
         qQiHPBett0QO+DX4+1mm9DsTrdynIFB5ynMxjlMc7m2z+fGsjmlaTADhTQpMzBo2B/9z
         gdPa5lM+9sGmX9mWTgVHlOOG7vugYCJ8Y9+bDEiIu7tGEFruR7KISmYi8pfQL/qHuURV
         szLw==
X-Received: by 10.182.72.167 with SMTP id e7mr8085089obv.3.1399580809199;
        Thu, 08 May 2014 13:26:49 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id js4sm8319150oeb.3.2014.05.08.13.26.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 13:26:47 -0700 (PDT)
In-Reply-To: <CAHYYfeGvOnonm0fd=Fa9p_if+8dRo2zg_N9c=gjjqyko=ipJag@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248441>

James Denholm wrote:
> Felipe, I would ask, suggest, beg, implore you to calm down.

I am calmed down. I waited a day before replying to make sure of that.

> It's generally not a good plan to alienate the maintainer of a
> project, regardless of the correctness or incorrectness of one's
> arguments, but I fear that's only what you will achieve at the moment.

He has already alienated me. In fact he asked me before to leave the
mailing list. And I did for a while.

However, at some level he knows my patches are beneficial to the
project, so he is applying them again.

Either way it doesn't matter if I'm calmed down or not, abrassive or
civil, this ad hominmen double standards bullshit is going to continue.

See what was his reply to my mail? *Nothing*.

What was his reply when I argued if he even admitted he could
potentially be wrong, and if so would essentially trash a project I've
worked very hard for? *Nothing*.

What was his reply when I argued that git-remote-hg has more quality
than all the tools in contrib, even some in the core and therefore
doesn't belong there? *Nothing*.

What was his reply when I said double standards were applied for
git-remote-hg. *Nothing*.

How about when I argued there was no mechanism for out-of-tree tools to
be properly maintained and promoted, and moving tools outside of the
tree shouldn't be done before that happens? *Nothing*.

What did he say when I suggested to move out git-p4 and git-svn, if he
is so sure important tools can "flourish" out-of-tree? *Nothing*.

The truth is that it doesn't matter how I present my arguments, calmly
or otherwise. He is *never* going to accept he was wrong, especially not
when that would mean I was right.

Don't expect any more git-remote-hg patches from me. If Junio thinks
it's just another crappy contrib tool, then I'll threat it as one.

And unfortunately Junio would rather let an important part of Git die a
slow death rather than admit he was wrong. Just watch him ignore the
problem.

-- 
Felipe Contreras
