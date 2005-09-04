From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Could not interpret heads/dbrt-test as something to pull
Date: Sun, 4 Sep 2005 22:05:51 +1200
Message-ID: <46a038f9050904030517f6ddda@mail.gmail.com>
References: <87psrp5gvp.fsf@litku.valo.iki.fi>
Reply-To: martin.langhoff@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 04 12:07:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBrOW-0006aK-Jj
	for gcvg-git@gmane.org; Sun, 04 Sep 2005 12:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbVIDKF5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Sep 2005 06:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbVIDKF4
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Sep 2005 06:05:56 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:46321 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751329AbVIDKF4 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2005 06:05:56 -0400
Received: by rproxy.gmail.com with SMTP id i8so552563rne
        for <git@vger.kernel.org>; Sun, 04 Sep 2005 03:05:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NNuFqsKQuTtHFxW1Kj4K1A/DDCQmSXzjpERX9/w30+ue8IFU/gsUpyQaBqeS/Em/CO/6HJXjMDm34SkPKizqrkJfCM3jZ8GCZsKgsgVscWQ/w2OvTYnZz3Km3VlwiQ8ckxJjYC8xLaG75YyRNoFS64/oEf4Ir0lJhe1POyeKN7E=
Received: by 10.38.11.74 with SMTP id 74mr392268rnk;
        Sun, 04 Sep 2005 03:05:51 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Sun, 4 Sep 2005 03:05:51 -0700 (PDT)
To: Kalle Valo <Kalle.Valo@iki.fi>
In-Reply-To: <87psrp5gvp.fsf@litku.valo.iki.fi>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8054>

On 9/4/05, Kalle Valo <Kalle.Valo@iki.fi> wrote:
> I was trying to clone the git repository this morning and it fails
> every time:
> got 15891f81e0fa99333ad81e9271df5b2a72ba368e
> error: Couldn't get http://www.kernel.org/pub/scm/git/git.git/refs/heads/dbrt-test for heads/dbrt-test

Tried to repro, but takes ageson my puny cablemodem. Cloning via rsync
seems to work well though.

cheers,


martin
