From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: Re: Git ticket / issue tracking ERA: Git shouldn't allow to push a
 new branch called HEAD
Date: Wed, 23 Nov 2011 14:44:30 +0100
Message-ID: <CAHVLzc=SPD+AHhAPP_=mEVv5cJvn0oiJ_k-KBEkG=Qhcw2UxHA@mail.gmail.com>
References: <1321970646.3289.19.camel@mastroc3.mobc3.local> <7vd3ckdjx9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Daniele Segato <daniele.bilug@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 14:45:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTD8D-0003en-2Z
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 14:44:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755716Ab1KWNow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 08:44:52 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46400 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755606Ab1KWNov (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 08:44:51 -0500
Received: by qadc14 with SMTP id c14so2511419qad.19
        for <git@vger.kernel.org>; Wed, 23 Nov 2011 05:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yPYp+FEV4Y0YlPGSdI5VOpb6FqLp/bZu/7BHYloyX6c=;
        b=mXO650LtmdJ/2AtN4QZqBe9unuesLM54aKxEhTeE8J3XeULjqTjKRT/UFEvJ0Wn/ee
         CU4U9DwCyxpcDOyRe44OjzNvyLfJZaRvnN+hXEIG+ftSX4zPIWug40hdmPREDjm/YqQT
         CEumhjVl5EAc/r4YmjB19m3iIVgHx6KmPlt/A=
Received: by 10.224.117.74 with SMTP id p10mr10892987qaq.28.1322055891120;
 Wed, 23 Nov 2011 05:44:51 -0800 (PST)
Received: by 10.229.249.210 with HTTP; Wed, 23 Nov 2011 05:44:30 -0800 (PST)
In-Reply-To: <7vd3ckdjx9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185849>

On Tue, Nov 22, 2011 at 8:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Daniele Segato <daniele.bilug@gmail.com> writes:
>
>> [1] according to http://git-scm.com/ the link on "Git source repository"
>> is https://github.com/gitster/git
>
> That one is as official as anybody's "git clone" from many of the
> distribution points.
>
> I do not see any reason to name an official repository, but if I were
> pressed, that copy at github is not the one I would nominate.

But that's the only repo mentioned in the git-scm home page.

Regards,
   Paolo
