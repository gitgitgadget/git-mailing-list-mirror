From: Tom Lord <lord@emf.net>
Subject: Re: [Gnu-arch-users] Re: [GNU-arch-dev] [ANNOUNCEMENT] /Arch/
	embraces `git'
Date: Thu, 21 Apr 2005 14:51:45 -0700 (PDT)
Message-ID: <200504212151.OAA07558@emf.net>
References: <1114069758.5886.9.camel@perun.redhat.usu>
Cc: gnu-arch-users@gnu.org, gnu-arch-dev@lists.seyza.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 23:48:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOjW6-0002YL-Av
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 23:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVDUVvv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 17:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVDUVvv
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 17:51:51 -0400
Received: from emf.emf.net ([205.149.0.19]:36356 "EHLO emf.net")
	by vger.kernel.org with ESMTP id S261182AbVDUVvt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 17:51:49 -0400
Received: (from lord@localhost) by emf.net (K/K) id OAA07558; Thu, 21 Apr 2005 14:51:45 -0700 (PDT)
To: t8m@centrum.cz
In-reply-to: <1114069758.5886.9.camel@perun.redhat.usu> (message from Tomas Mraz on Thu, 21 Apr 2005 09:49:18 +0200)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



   > Tom, please stop this ext* filesystem bashing ;-) 

For one thing... yes, i'm totally embarassed on this issue.
I made a late-night math error in a spec.  *hopefully* would
have noticed it on my own as I coded to that spec but y'all
have been wonderful at pointing out my mistake to me even 
though I initially defended it.

As for ext* bashing.... it's not bashing exactly.  I/O bandwidth
gets a little better, disks get a bunch cheaper --- then ext* 
doesn't look bad at all in this respect.  And we're awefully close
to that point.   

Meanwhile, for times measured in years, I've gotten complaints from
ext* users about software that is just fine on other filesystems
over issues like the allocation size of small files.

So ext*, from my perspective, was a little too far ahead of its time
and, yes, my complaints about it are just about reaching their
expiration date.

Anyway, thanks for all the sanity about directory layout.  Really,
it was just an "I'm too sleepy to be doing this right now" error.

-t

