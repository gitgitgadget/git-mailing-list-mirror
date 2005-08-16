From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: How do I track pu branch?
Date: Tue, 16 Aug 2005 15:17:49 +1200
Message-ID: <46a038f90508152017290a4de9@mail.gmail.com>
References: <46a038f9050815185629e5c4b6@mail.gmail.com>
	 <7v4q9qr4gn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 05:19:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4rxf-00031c-Ed
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 05:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbVHPDR4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 23:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965080AbVHPDR4
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 23:17:56 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:54653 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965058AbVHPDRz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 23:17:55 -0400
Received: by rproxy.gmail.com with SMTP id i8so883667rne
        for <git@vger.kernel.org>; Mon, 15 Aug 2005 20:17:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kStv7UGbYeQqUUIw4ntyvBBOybLJdmyCWAvbjW6vGsg0nxaDMRhrEnAnTZHQUCnnlQrMdv7SzH0Iuig6qxM3796m6Mphnp4edeuPt0du0/+dQsto8QGHTdjVEJWdgfzWYQwlBaq5siYNvnLJASYHaqXoBX7Cf4a4svExqBcnE84=
Received: by 10.38.79.11 with SMTP id c11mr2167741rnb;
        Mon, 15 Aug 2005 20:17:49 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Mon, 15 Aug 2005 20:17:49 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q9qr4gn.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 8/16/05, Junio C Hamano <junkio@cox.net> wrote:
> Martin Langhoff <martin.langhoff@gmail.com> writes:
> 
> > Following an extenal repo, I am not getting all the heads. This is by
> > design, AFAIK, and the question is how do I find what heads the repo
> > offers and pull them in so I can call them by name?
> 
> I suspect the Subject: line and your question do not mesh well,
> but anyway..

And even then, your answer is great. Thanks! 

I was half-expecting a mechanism to track "all branches/heads from a
remote repo" by rsync'ing the refs/heads directory outside of the git
protocol. That's perhaps why I had the wrong mindset.

All in all, it is a bit of a roundabout way of tracking things. 

cheers,


martin
