From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Teach git-checkout-index to read filenames from stdin.
Date: Thu, 2 Mar 2006 14:14:24 +0100
Message-ID: <81b0412b0603020514i2e4531efxafc38d95656ce9de@mail.gmail.com>
References: <20060301024333.GB21186@spearce.org>
	 <20060301155053.GC1010@trixie.casa.cgf.cx>
	 <81b0412b0603020512i429481f7i4a0dbe4599dbb5a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 02 14:14:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEndW-0003Cv-6B
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 14:14:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWCBNO0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 08:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbWCBNO0
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 08:14:26 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:52153 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751422AbWCBNO0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 08:14:26 -0500
Received: by nproxy.gmail.com with SMTP id b2so274494nfe
        for <git@vger.kernel.org>; Thu, 02 Mar 2006 05:14:24 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uLSb9Rm+XmVJ1w1l5FBHhPNUtE9pF0dKBnuS0mvcpYVwfqgKHLkZ1zVc8Xaw8aW4Eg1vS3Y7XC5/M36/997bHTzbZCwOsX/Yf9ktWlrtkNtPB01Qi2OdZ9mjGhX2tasQKo//2M78A5hKoSzWFhROqrZtdBhyEAoxnq7DKk7KdRw=
Received: by 10.48.207.2 with SMTP id e2mr639218nfg;
        Thu, 02 Mar 2006 05:14:24 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Thu, 2 Mar 2006 05:14:24 -0800 (PST)
To: "Christopher Faylor" <me@cgf.cx>
In-Reply-To: <81b0412b0603020512i429481f7i4a0dbe4599dbb5a6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17067>

On 3/2/06, Alex Riesen <raa.lkml@gmail.com> wrote:
> On 3/1/06, Christopher Faylor <me@cgf.cx> wrote:
> >
> > For native Windows programs, the command line length is ~32K but I don't
> > think that git uses any native Windows programs, does it?
> >
>
> Yes, ActiveState Perl is as native as it gets.
>

It does use native windows programs, I mean.
At least for me it does.
