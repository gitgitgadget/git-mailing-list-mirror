From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 9 Jun 2006 20:00:36 -0400
Message-ID: <9e4733910606091700s49018cd5p3b66f8ef51b22d2e@mail.gmail.com>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
	 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
	 <9e4733910606091113vdc6ab06l2d3582cb82b8fd09@mail.gmail.com>
	 <Pine.LNX.4.64.0606091158460.5498@g5.osdl.org>
	 <9e4733910606091317p26d66579mdf93db293f93fb50@mail.gmail.com>
	 <Pine.LNX.4.64.0606091331170.5498@g5.osdl.org>
	 <9e4733910606091356w391b4fdao23db5b2ce3c3e282@mail.gmail.com>
	 <Pine.LNX.4.64.0606091450180.5498@g5.osdl.org>
	 <46a038f90606091637o6a0194d5yb413237253a372fc@mail.gmail.com>
	 <Pine.LNX.4.64.0606091640200.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 10 02:00:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Foqu8-0004lZ-LJ
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 02:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbWFJAAh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 20:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030563AbWFJAAh
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 20:00:37 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:31259 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030393AbWFJAAg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jun 2006 20:00:36 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1214751nze
        for <git@vger.kernel.org>; Fri, 09 Jun 2006 17:00:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=upsjVd5h0RewozIqe/xng3lrxQp0fF1oyqCzFryrlUOP3gZtslUHMASooxutOr5dB9ZOZjtovJctXAYqoZV76BjdUlSSW9nu3YTEnBm5HQxQxUsZwd/e3DMPX0mjAiDU6OyfPzFh0lmvi/8OZSU3askJNPJIKF5QvjRu3OrQYM0=
Received: by 10.36.250.47 with SMTP id x47mr798590nzh;
        Fri, 09 Jun 2006 17:00:36 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Fri, 9 Jun 2006 17:00:35 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606091640200.5498@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21570>

On 6/9/06, Linus Torvalds <torvalds@osdl.org> wrote:
> On Sat, 10 Jun 2006, Martin Langhoff wrote:
> > In any case, and for the record, my cvsps is 2.1 pristine. It handles
> > the mozilla repo alright, as long as I give it a lot of RAM. I _think_
> > it slurped 3GB with the mozilla cvs.
>
> Oh, wow. Every single repo I've seen ends up having tons of complaints
> from pristine cvsps, but maybe that's because I only end up looking at the
> ones with problems ;)

Are we sure cvsps is ok? It is generating 500MB of warnings when I run it.

I have cvsps running at dreamhost currently. I had to modify cvs,
cvps, git, etc to not repsond to signals to keep them from killing
everything.

I can clone 2GB git tree there. Let me know when it is up.

-- 
Jon Smirl
jonsmirl@gmail.com
