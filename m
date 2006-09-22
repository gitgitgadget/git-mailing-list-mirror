From: Santi <sbejar@gmail.com>
Subject: Re: Git user survey and `git pull`
Date: Sat, 23 Sep 2006 01:24:20 +0200
Message-ID: <8aa486160609221624h41685024k29b63baa0a0bcf99@mail.gmail.com>
References: <20060921162401.GD3934@spearce.org>
	 <20060921164048.GY8259@pasky.or.cz>
	 <Pine.LNX.4.64.0609211027440.4388@g5.osdl.org>
	 <7vu0305wh8.fsf@assigned-by-dhcp.cox.net>
	 <8aa486160609220334w39a7d455s66f815f00ef6b6f6@mail.gmail.com>
	 <7v4puz4t3z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 01:24:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQuNc-0004OL-IN
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 01:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbWIVXYW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 19:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbWIVXYW
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 19:24:22 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:37258 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964915AbWIVXYV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Sep 2006 19:24:21 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1174398wxc
        for <git@vger.kernel.org>; Fri, 22 Sep 2006 16:24:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S0tM6VO2Twavh+KJKe7j/lwUhjoi9QjfcfF1DKWR4HvKDv1f98Sbd08kThDQ2GIDEXYrquIK/dpYYxputWRavk5LyKcLB7m9Lx/IZFcgslWSZdZOrCBQ/3pgM/GaJFuy5QtusNyN8PZdrlJUbahP9pwZhXVvJVewvcuvCUqjwg0=
Received: by 10.70.108.18 with SMTP id g18mr1997334wxc;
        Fri, 22 Sep 2006 16:24:20 -0700 (PDT)
Received: by 10.70.19.6 with HTTP; Fri, 22 Sep 2006 16:24:20 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v4puz4t3z.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27544>

2006/9/22, Junio C Hamano <junkio@cox.net>:
> Santi <sbejar@gmail.com> writes:
>
> > Something like
> > http://marc.theaimsgroup.com/?l=git&m=115398815111209&w=2
> > ?
>
> I do not have access to marc at the moment but I have saved a
> patch from you back from July in one of my freezer mbox.  IIRC
> your message was not for inclusion but more as a firestarter for
> discussions, and the discussion never came to conclusion with
> appliable set of patches.
>

Yes, it was. But I think now will be different :)

In a moment I'll send two little patches for your two first points
(pull w/o arg + pull with just the remote).

Santi
