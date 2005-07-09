From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: cogito Mac OS X compatibility
Date: Sun, 10 Jul 2005 01:40:10 +1200
Message-ID: <46a038f905070906402c6b543e@mail.gmail.com>
References: <42CF0D9F.8040909@gmail.com>
Reply-To: Martin Langhoff <martin.langhoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 09 15:40:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrFZ7-0007gb-JI
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 15:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVGINkN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jul 2005 09:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVGINkM
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jul 2005 09:40:12 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:18127 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261394AbVGINkK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Jul 2005 09:40:10 -0400
Received: by rproxy.gmail.com with SMTP id i8so538286rne
        for <git@vger.kernel.org>; Sat, 09 Jul 2005 06:40:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pva+MBA6Fm/pphwuckK/rt5//lhG6UEhSKGtYX7aPHSrJOEJke77jn2lMs7hvZ5syc9BYpBU2WAsw171KWg4w/aL7wk7TEzfSlcSErjXS9HH3544ZOMd9phKbR56HZfaZGR5nt+MiBClxKhXhot55PurRo5JMUKpnnNLrXIZBzQ=
Received: by 10.38.65.46 with SMTP id n46mr2734209rna;
        Sat, 09 Jul 2005 06:40:10 -0700 (PDT)
Received: by 10.38.101.3 with HTTP; Sat, 9 Jul 2005 06:40:10 -0700 (PDT)
To: Bryan Larsen <bryan.larsen@gmail.com>
In-Reply-To: <42CF0D9F.8040909@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 7/9/05, Bryan Larsen <bryan.larsen@gmail.com> wrote:
> On Mac OS X

It also uses on GNU xargs, and the xargs options aren't compatible
between GNU and BSD xargs.

Sad thing is, some of the dependencies, like xargs, aren't available
in fink, so you can build your toolchaing or boot into GNU/LinuxPPC.
Debian actually has git (cogito?) experimental packages.

cheers,


martin
