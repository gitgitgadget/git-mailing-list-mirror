From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Add new git-cc-cmd helper to contrib
Date: Thu, 6 Dec 2012 16:45:37 +0530
Message-ID: <CALkWK0m3RVaykPUBw9upc5kpwUwJd4q9D_TecSASxMJ=r3iXoA@mail.gmail.com>
References: <1352653804-2203-1-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0ksDBbWfxbT=PbKiWaC87vghTADPqcy+ujgJ9iZOVZv0w@mail.gmail.com> <CAMP44s1--1i+ZtG7eKe0ZpRizcBfq+wJv_VOVZfU+A+gpjLyhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 12:16:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgZR9-0006np-8V
	for gcvg-git-2@plane.gmane.org; Thu, 06 Dec 2012 12:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423082Ab2LFLP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2012 06:15:59 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:60887 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964890Ab2LFLP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2012 06:15:58 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so6138070oag.19
        for <git@vger.kernel.org>; Thu, 06 Dec 2012 03:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tiJjYA+CKP7BRTtupfNnUc5O2TA0jIS9ZWim8koHkvQ=;
        b=PtDaIaz0CC+t3bh4+rRgs5IuNg661+N/b9dXOQ5d//IIeO1vqowwTO1Ymjf85WYF3w
         HP6tgpWIFXr8ObNZGCjrojjGoQruvvDl9BfMqCLvE/Pnqa19jYhhUdzYN33SSIHefDpq
         nGxYXAv9/NogOx6cDeirc2njqLIkpN7IpcQHyBUbgb796JggPAzJzBriBu1JIdvrIJoZ
         AXyAvT7cZ26OQ8FRmPrqxevnINNm+EM7Wvp/HhKdySEa+jbKNKcaH3u3/bW08iYuXC+v
         Ft7uRvK1DljwIkV0VHc3cqCtuGxotQd25XrYRPcDTTyl7w/ochSroiJZmnzX65XrBasC
         TgDw==
Received: by 10.182.51.66 with SMTP id i2mr618482obo.43.1354792557874; Thu, 06
 Dec 2012 03:15:57 -0800 (PST)
Received: by 10.76.75.198 with HTTP; Thu, 6 Dec 2012 03:15:37 -0800 (PST)
In-Reply-To: <CAMP44s1--1i+ZtG7eKe0ZpRizcBfq+wJv_VOVZfU+A+gpjLyhQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211162>

Felipe Contreras wrote:
> [...]

What happened to this code?  I don't see it in `pu`.

Ram
