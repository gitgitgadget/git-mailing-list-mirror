From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: a small git proposal
Date: Thu, 23 Aug 2012 08:16:59 -0700
Message-ID: <CAE1pOi0MXhQyKBa=s0ecwzUZhNkYcCA-_pwM0VC7vx9ECFrG0Q@mail.gmail.com>
References: <CACZFoOGjRX_CT5hpYcqN4_67he5gyAC-oGaPwZfcOx6w4QuxVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Catalin Pol <catalin.pol@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 17:17:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4ZA6-0005kw-JJ
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 17:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757376Ab2HWPR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 11:17:26 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58256 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753936Ab2HWPRV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 11:17:21 -0400
Received: by bkwj10 with SMTP id j10so285349bkw.19
        for <git@vger.kernel.org>; Thu, 23 Aug 2012 08:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1vwUN5hfQG8vJHxkMq7tJPSpOTbsI/qdIY6wc6pMt5M=;
        b=T0kx1qHYtQsUwgvbwRNNlDVUMS1xmt+Koysb3VY849WSl/z1POMhAczFj/gtxOA/9v
         z8Gr8j/Wkn5VfQdF7eHMsZJkZr0v63v3qODWbE6bPXTSdlHcKCvo3Vsn3X6GLmcQaDlK
         1TkITf22SDAFL2ekkE8FHdgycQc1DYXz4NejIe8xh6vs1qv+LizcWcYQDVcWDXl3Fw/T
         NVV5HwzQc3yvwEx2VMrRG037iAmqveFrvSQLO8x4DJZoT5Dr+FJwMSwCB4E3rxBTZ7fs
         b2h44gas7CU0z0juRsG9fHE2eCzgeZXgI+e7hlvhfEVh8ym1Hq1rcV/4lJJj3vvDVEWO
         M5Jg==
Received: by 10.204.133.193 with SMTP id g1mr687978bkt.2.1345735039991; Thu,
 23 Aug 2012 08:17:19 -0700 (PDT)
Received: by 10.205.32.15 with HTTP; Thu, 23 Aug 2012 08:16:59 -0700 (PDT)
In-Reply-To: <CACZFoOGjRX_CT5hpYcqN4_67he5gyAC-oGaPwZfcOx6w4QuxVQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204151>

On 23 August 2012 08:10, Catalin Pol <catalin.pol@gmail.com> wrote:
> Hi everyone,
>
> This is my first email to this mailing list, so this may be somehow
> too straight forward... the idea is that I was thinking to develop a
> new feature in Git (although I'm kind of new to git myself).
> I wrote a small description of what I intend to do and I figured I
> could use some pointers (how I can improve it, any possible usage
> scenarios you can think for it and so on). Details are available at
> the gist link below or as attachment to this email (I zipped the text
> file since it was more it is larger than 10k and I didn't want it to
> get rejected by the email server... although it still might)
>
> gist link:    https://gist.github.com/3437530
>
> I made the gist public, so feel free to edit it directly... or, if you
> prefer, just email me with any comments. I'm opened to any suggestion,
> so feel free to send me any kind of comment (maybe I'm trying to
> implement something that is already in git for example, and since I'm
> a bit of a newbie in the git world, I didn't notice any way to obtain
> my desired workflow).
>
> Thanks in advance for any feedback,

Have you looked at "git notes"?
