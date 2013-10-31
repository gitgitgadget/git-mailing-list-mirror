From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 03/16] pull: cleanup documentation
Date: Thu, 31 Oct 2013 15:16:57 -0600
Message-ID: <CAMP44s14_GbN0nEm4Eu2Jdb5cO+jVaTVOnDqzwv0GK4_jfD93w@mail.gmail.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
	<1383211547-9145-4-git-send-email-felipe.contreras@gmail.com>
	<xmqqiowd71kv.fsf@gitster.dls.corp.google.com>
	<CAMP44s3AKnZUJy0O0Hg+G=ER2bRn1nHMBeoJQ=ugCzO4d2WZ-g@mail.gmail.com>
	<xmqqob655kqi.fsf@gitster.dls.corp.google.com>
	<ADB546B4-992E-4B54-953E-B721BECD19B2@quendi.de>
	<xmqqzjpp447x.fsf@gitster.dls.corp.google.com>
	<xmqqfvrh41e0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Max Horn <max@quendi.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 22:17:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbzby-0000Vw-Cq
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 22:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033Ab3JaVQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 17:16:58 -0400
Received: from mail-wg0-f54.google.com ([74.125.82.54]:43276 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710Ab3JaVQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 17:16:57 -0400
Received: by mail-wg0-f54.google.com with SMTP id c11so3307916wgh.33
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 14:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Aifkn5A76OiuWeHEMVmLtWwQFOAzV6LaZVqFigo0e2k=;
        b=MSndx6DCqOEYJudywk+bkWW6gcu3BujA5W1LXG10ECNy+ZUfr0ocgTGna6TB9mV5hi
         G13F6INyhvavmKLVowCiROBbFWOaXoMPj4t2XlDQGBN0N92n+uLMU4T3YB9p0rU/liH/
         ai8onin/P3U2EGI/LEgl7kMjgCuacWILIW7eg/OFoQlV3COff/yfYxYMX/qFPpZCv2Kv
         ExzM3C7ApjnOkTr7eMtmqZ2X05JH0gPyj5fMzSXFApldHT4Ldx/X6BBXGplggMzd95uP
         Sq/1aUDGpTWdUmhsCt0jGnIFZybM5ni6XXsVGK7aNRYQl/L7ui5qUCs4km34SVNsMgkq
         EiTg==
X-Received: by 10.180.182.82 with SMTP id ec18mr13270wic.13.1383254217069;
 Thu, 31 Oct 2013 14:16:57 -0700 (PDT)
Received: by 10.194.242.167 with HTTP; Thu, 31 Oct 2013 14:16:57 -0700 (PDT)
In-Reply-To: <xmqqfvrh41e0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237185>

On Thu, Oct 31, 2013 at 2:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:

> The other reason the original did not say "origin/master" is because
> this holds true even if you do not have such a remote-tracking
> branch for the master at the origin, but the illustration that shows
> the history after "git pull" finishes spells remotes/origin/master
> out, so I think it would be an improvement to make the two pictures
> consistent by drawing where the origin/master is before this "git
> pull" is run.

So you care about "reality" when it fits your argument, but not when
it doesn't. Got it.

-- 
Felipe Contreras
