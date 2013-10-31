From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 03/16] pull: cleanup documentation
Date: Thu, 31 Oct 2013 16:40:49 -0700
Message-ID: <20131031234048.GA41400@gmail.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
 <1383211547-9145-4-git-send-email-felipe.contreras@gmail.com>
 <xmqqiowd71kv.fsf@gitster.dls.corp.google.com>
 <CAMP44s3AKnZUJy0O0Hg+G=ER2bRn1nHMBeoJQ=ugCzO4d2WZ-g@mail.gmail.com>
 <xmqqob655kqi.fsf@gitster.dls.corp.google.com>
 <ADB546B4-992E-4B54-953E-B721BECD19B2@quendi.de>
 <xmqqzjpp447x.fsf@gitster.dls.corp.google.com>
 <xmqqfvrh41e0.fsf@gitster.dls.corp.google.com>
 <CAMP44s14_GbN0nEm4Eu2Jdb5cO+jVaTVOnDqzwv0GK4_jfD93w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Max Horn <max@quendi.de>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 01 00:41:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vc1rH-0005ak-Tz
	for gcvg-git-2@plane.gmane.org; Fri, 01 Nov 2013 00:41:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754195Ab3JaXk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 19:40:56 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:56288 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645Ab3JaXkz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 19:40:55 -0400
Received: by mail-pb0-f47.google.com with SMTP id rq2so3474279pbb.20
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 16:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=TijLYWuZpcAt6GJELZBaBkuucqI8w7bA3xLtRiuwDOs=;
        b=h+w4dQ+RSgrKyPYrh0fz5KFftwdAA/zVsXPaOa7AD4h62vppdH6pY7IRD7oJIt1d14
         vBScLA1o3GFPPjIX/XWU9ypags+IV+QXR2eZKu565zMqLXmTTAuNzVUT1w+S6nRERCwa
         Lk1tzuaWpEedXyLWdkc4P3MRSaUopN8L83M3cNE3BuK+UexcpyYMBg1Ugl5VMVNsl69Q
         k0hXTMcWS7DyTgoDLoy3qZ3sc9htghG0+8hQIC+xcA6SwMy6B6MQnG2ift2PlP9k7Ubk
         okiDKTsesHTXVkzjNJ/oYN31Ez/dYSC5eCDzAtljgWal7P5gs6DOibs3PS5fwzLsiB2E
         PPjw==
X-Received: by 10.68.224.38 with SMTP id qz6mr237558pbc.156.1383262854067;
        Thu, 31 Oct 2013 16:40:54 -0700 (PDT)
Received: from gmail.com (w.disneyanimation.com. [198.187.190.241])
        by mx.google.com with ESMTPSA id ql10sm5367089pbc.44.2013.10.31.16.40.53
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 31 Oct 2013 16:40:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s14_GbN0nEm4Eu2Jdb5cO+jVaTVOnDqzwv0GK4_jfD93w@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237194>

On Thu, Oct 31, 2013 at 03:16:57PM -0600, Felipe Contreras wrote:
> On Thu, Oct 31, 2013 at 2:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> 
> > The other reason the original did not say "origin/master" is because
> > this holds true even if you do not have such a remote-tracking
> > branch for the master at the origin, but the illustration that shows
> > the history after "git pull" finishes spells remotes/origin/master
> > out, so I think it would be an improvement to make the two pictures
> > consistent by drawing where the origin/master is before this "git
> > pull" is run.
> 
> So you care about "reality" when it fits your argument, but not when
> it doesn't. Got it.

What exactly do these flippant remarks accomplish?
Keep these to yourself.  No one deserves this treatment nor does
anyone care to read it.
-- 
David
