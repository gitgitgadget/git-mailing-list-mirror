From: "Josh Boyer" <jwboyer@gmail.com>
Subject: Re: Default refspec for branches
Date: Wed, 19 Apr 2006 12:52:21 -0500
Message-ID: <625fc13d0604191052r15226583qf145172cea67429b@mail.gmail.com>
References: <625fc13d0604190558tf0e8b69n5f5a830a3131f1d4@mail.gmail.com>
	 <7v3bg9bgsz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 19:52:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWGqo-0006I6-LQ
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 19:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWDSRwY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 13:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbWDSRwY
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 13:52:24 -0400
Received: from uproxy.gmail.com ([66.249.92.175]:39058 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751026AbWDSRwX convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Apr 2006 13:52:23 -0400
Received: by uproxy.gmail.com with SMTP id c2so868346ugf
        for <git@vger.kernel.org>; Wed, 19 Apr 2006 10:52:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oERb+WrSin0tD7q2+uisdpIaxL4awxbE0JcHXS0DNsNKZlYM7UA2Z/YNpAjyBJgtxF+HTIXeUK7x7IR9Tmi7ego4xyx3e88mZKCqIXzH1SZDeQPeTm2cfJld4e1yK/nMs5mLIsNmyZJTGNVtm71mSJb/Uh+/Q2iwmXdj2E3mqPE=
Received: by 10.78.40.10 with SMTP id n10mr107942hun;
        Wed, 19 Apr 2006 10:52:21 -0700 (PDT)
Received: by 10.78.15.16 with HTTP; Wed, 19 Apr 2006 10:52:21 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v3bg9bgsz.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18934>

On 4/19/06, Junio C Hamano <junkio@cox.net> wrote:
> "Josh Boyer" <jwboyer@gmail.com> writes:
>
> > Is there a way to change the default refspec that git pull uses on a
> > per branch basis?
>
> No.
>
> But it is a _very_ reasonable thing people would want to be able
> to.  Please look at the last entry in:
>
>         Subject: Recent unresolved issues
>         Date: Fri, 14 Apr 2006 02:31:36 -0700
>         Message-ID: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>

Hm, ok.

I'd offer to work on that, but I have a bit of a learning curve in
front of me before I could make something useful.  If others beat me
to it, I certainly wouldn't mind ;)

josh
