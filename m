From: =?UTF-8?B?IkFuZHkgR3JlZW4gKOael+WuieW7uCki?= <andy@warmcat.com>
Subject: Re: [StGit PATCH] Parse commit object header correctly
Date: Wed, 15 Feb 2012 10:40:44 -0800
Message-ID: <4F3BFC2C.8020007@warmcat.com>
References: <4F3120D4.1050604@warmcat.com> <7vvcni1r5u.fsf@alter.siamese.dyndns.org> <7vd39pzsmq.fsf_-_@alter.siamese.dyndns.org> <4F3247CA.1020904@alum.mit.edu> <CAHkRjk451=_XaQuUXmxAvB3sRRz6-J+c7A2ZrfLwfGz=z05Lag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?S2FybCBIYXNzZWxzdHLDtm0=?= <kha@treskal.com>,
	git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 15 19:40:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxjmh-0008A5-Az
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 19:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754277Ab2BOSkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 13:40:49 -0500
Received: from warmcat.com ([87.106.134.80]:53275 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754103Ab2BOSkt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 13:40:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:9.0) Gecko/20111222 Thunderbird/9.0
In-Reply-To: <CAHkRjk451=_XaQuUXmxAvB3sRRz6-J+c7A2ZrfLwfGz=z05Lag@mail.gmail.com>
X-Enigmail-Version: 1.3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190847>

On 02/15/2012 04:24 AM, Somebody in the thread at some point said:

Hi -

> Thank you all for comments and patches. I used a combination of
> Junio's patch with the comments from Michael and a fix from me. I'll
> publish it to the 'master' branch shortly and release a 0.16.1
> hopefully this week.

I cloned the master branch and installed it locally, it's working well.

Thanks a lot to the guys who spent time on this bug and stgit overall,
which I rely heavily on!

-Andy
