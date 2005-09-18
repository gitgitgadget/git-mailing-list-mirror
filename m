From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Newbie falls at first hurdle
Date: Sun, 18 Sep 2005 22:54:10 +1200
Message-ID: <46a038f9050918035436352f71@mail.gmail.com>
References: <alan@chandlerfamily.org.uk>
	 <200509171309.46893.alan@chandlerfamily.org.uk>
	 <200509180135.j8I1Z34n023252@inti.inf.utfsm.cl>
Reply-To: martin.langhoff@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Alan Chandler <alan@chandlerfamily.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 12:55:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGwob-00057d-5j
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 12:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbVIRKyN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 06:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbVIRKyN
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 06:54:13 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:27597 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751086AbVIRKyN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2005 06:54:13 -0400
Received: by rproxy.gmail.com with SMTP id i8so186729rne
        for <git@vger.kernel.org>; Sun, 18 Sep 2005 03:54:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AcMctqseZtDUKRTJI3XDZq93ULtIYwL9BqIax/l6ISAQ7uhJaRuYn3CsmJHS+JgdW1krfQvVsatfQAzocH/ZwoE/Jz+AkGHNOHQgpCNf081mb4tnsMlxrO82ibf5jAdtJV8Fv1WXea8xiKYySHDzGcIDczVbHEGRjg0F5IK8jXs=
Received: by 10.38.89.5 with SMTP id m5mr101161rnb;
        Sun, 18 Sep 2005 03:54:10 -0700 (PDT)
Received: by 10.38.101.53 with HTTP; Sun, 18 Sep 2005 03:54:10 -0700 (PDT)
To: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <200509180135.j8I1Z34n023252@inti.inf.utfsm.cl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8779>

On 9/18/05, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> The easiest way of doing this is using cogito (near where you found
> git). It automates some tasks using git as backendq, in this case it would
> only need:
> 
>    cg-init

+1 -- I work with a small team and we are migrating to cogito/git.
There's still a few things we have to call git utilities for (change
branch, for instance) but for "intuitive" usage, cogito is the cat's
whiskers.

cheers,


martin
