From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: [PATCH] Clean weird documentation for 'git var' and 'git
Date: Thu, 10 May 2012 22:14:39 +0200
Message-ID: <CAGK7Mr4GJw4zZ5Qwab+co07JG5kBn-EFsfmU+Yzpm6LoD8j-Rw@mail.gmail.com>
References: <CAGK7Mr7QWrddaRLkr=1h=GYUNtNVOatQF1sj+p11mejzs65u8A@mail.gmail.com>
 <7vzk9gm0wa.fsf@alter.siamese.dyndns.org> <F89882854A7D45E2843F6F1F7CB21DB4@PhilipOakley>
 <CAGK7Mr6AjSY-D9p1vzs=xCg-TMCPiBJDOSxMVYtykeCZCPW2FA@mail.gmail.com>
 <CAGK7Mr7rzuPVmGsnx+uhmVgBepAav734uh6hHeqn25BC0_+0Lw@mail.gmail.com> <7vvck3najc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 10 22:15:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSZle-0004dX-G4
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 22:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541Ab2EJUPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 16:15:13 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36677 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631Ab2EJUPL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 16:15:11 -0400
Received: by yhmm54 with SMTP id m54so1882882yhm.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 13:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rVpSaxzF1psAYnSwDiy+sUXJI28iuc/8+Lr9xi7vC84=;
        b=wLa5XTiMbOntEUSTNsfaYChRwuEjHfs2XLI/4ShjUeG6+r3askPh1+jUEZBUxRgaEc
         4rT41PuNCHK4Kr2byZB+ExxeovCiIfWqMy1PjxEzIZ4M9mh9Dr9z8zeAnW3m7gGDMxfQ
         2i8Oy0GD1+jA0gVymWxt1ucbnsjDrOxPmutrFepVp6PpEVD699odustZch4HksXrtKgT
         XHUditNPCxjHV6bctSLN4yJHt6k5Cz3wjJWMynO2tRgAWVZW77qfoQLqvA7z86T+dh7b
         R2CbvgJ8kW9//H5WMJ6AEaJOT8SfBAUiKjbQQFm4L4HgNnISBC0LfZoNvqry4M3YiRKF
         Qyhg==
Received: by 10.50.154.167 with SMTP id vp7mr160243igb.55.1336680910187; Thu,
 10 May 2012 13:15:10 -0700 (PDT)
Received: by 10.50.65.101 with HTTP; Thu, 10 May 2012 13:14:39 -0700 (PDT)
In-Reply-To: <7vvck3najc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197625>

>> I guess I'm just unfamiliar with the "Diagnostics" section of a man
>> page.
>
> Ahh, that makes your initial message understandable.
>
> It indeed is not one of the very common and established ones, and it may
> help to give it a gentler introduction.

Yes that's much better. Thanks!

I think in the long term those error messages should be more
descriptive. For example "Your parents must have hated you" should be
"Your name is too long, maximum %d characters allowed" or whatever.

Philippe
