From: Dave Airlie <airlied@gmail.com>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Thu, 23 Jun 2005 22:25:43 +1000
Message-ID: <21d7e99705062305255b1ec58e@mail.gmail.com>
References: <42B9E536.60704@pobox.com>
Reply-To: Dave Airlie <airlied@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 14:20:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlQgH-0006yo-T1
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 14:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbVFWMZv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 08:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbVFWMZv
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 08:25:51 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:65334 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262278AbVFWMZn convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2005 08:25:43 -0400
Received: by rproxy.gmail.com with SMTP id 1so66258rny
        for <git@vger.kernel.org>; Thu, 23 Jun 2005 05:25:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bTlhJAW7e2jYu69XBNzCgIRUP3mU6p9JjjschjuM5IbjvA22Nh4iU0E6zbLcTDZ23iT7NWU8plvBZTqrntN/3aVTPi0tTrBgODFSKCia6sOc7O+vLRz8dMbG6mJxd/8u9KejRFV5Je5rSke9CHp6hcwRbofJ7Hk5KrNru0aUTOo=
Received: by 10.11.119.2 with SMTP id r2mr67931cwc;
        Thu, 23 Jun 2005 05:25:43 -0700 (PDT)
Received: by 10.11.117.46 with HTTP; Thu, 23 Jun 2005 05:25:43 -0700 (PDT)
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <42B9E536.60704@pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> jgarzik helper scripts, not in official git distribution:
> http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-new-branch
> http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-changes-script
> 

Do you have some sort of magic bk-make-sum type util at all... 

For sending trees to Linus I used to run bk-make-sum and gcapatch and
then just throw my own stuff in the top of the mail ....

I'm being lazy I probably could write it myself, but bk-make-sum was a
very useful script for me...

Dave.
