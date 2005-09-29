From: David Leimbach <leimy2k@gmail.com>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Thu, 29 Sep 2005 08:18:49 -0700
Message-ID: <3e1162e605092908187e181936@mail.gmail.com>
References: <433BC9E9.6050907@pobox.com>
Reply-To: David Leimbach <leimy2k@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932193AbVI2PSx@vger.kernel.org Thu Sep 29 17:19:46 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932193AbVI2PSx@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL0Bv-0007Fp-GB
	for glk-linux-kernel-3@gmane.org; Thu, 29 Sep 2005 17:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbVI2PSx (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 29 Sep 2005 11:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbVI2PSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 11:18:53 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:62444 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932193AbVI2PSw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 11:18:52 -0400
Received: by zproxy.gmail.com with SMTP id i11so160162nzi
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2005 08:18:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gXYT3mKMFZZpdrfS5YMQzWgrD8/0xnEXHIdq79II60PMWf7Mujk2TNuvMFlgiAZdm+aEV3wlc4aCn+PFpo1VGhQPLTlq7JL3DM+pYmCJTHhNBmLucW7gqF2jEiw2VuJpTOnPEPpufN54HFUyAfMdvDWmAUiCyXNNg2AedEjn3yo=
Received: by 10.36.126.9 with SMTP id y9mr617421nzc;
        Thu, 29 Sep 2005 08:18:49 -0700 (PDT)
Received: by 10.36.42.7 with HTTP; Thu, 29 Sep 2005 08:18:49 -0700 (PDT)
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <433BC9E9.6050907@pobox.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9485>

On 9/29/05, Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Just updated my KHGtG to include the latest goodies available in
> git-core, the Linux kernel standard SCM tool:
>
>         http://linux.yyz.us/git-howto.html

Can you update the date on that page to reflect your latest updates? 
I was digging around with git yesterday and had a few surprises...
like checking out the kernel and being told I modified a bunch of
files I never touched.

- Dave
