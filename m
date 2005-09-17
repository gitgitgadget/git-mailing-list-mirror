From: Tony Luck <tony.luck@gmail.com>
Subject: Re: deprecating more
Date: Fri, 16 Sep 2005 23:13:09 -0700
Message-ID: <12c511ca05091623135ccbcae1@mail.gmail.com>
References: <7vd5n8fqso.fsf@assigned-by-dhcp.cox.net>
	 <7vzmqceayd.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0509161856260.26803@g5.osdl.org>
	 <7vr7boe8a8.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0509161938580.26803@g5.osdl.org>
	 <7vfys4e003.fsf@assigned-by-dhcp.cox.net>
Reply-To: tony.luck@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: tony.luck@intel.com, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Sep 17 08:14:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGVx2-00043l-Nk
	for gcvg-git@gmane.org; Sat, 17 Sep 2005 08:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbVIQGNQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Sep 2005 02:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbVIQGNQ
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Sep 2005 02:13:16 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:7839 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750956AbVIQGNP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2005 02:13:15 -0400
Received: by zproxy.gmail.com with SMTP id 13so619565nzn
        for <git@vger.kernel.org>; Fri, 16 Sep 2005 23:13:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=et5bWIpolwIqjR7YTIAyeBZLgfjN1I5pmMoUU5x7Ai2DkfhLHVZ78RPM0540hjx8h5pjTOXbqqNOWidt1rV1MeRNJt8yV4Px1Hf9S072QmwgYZtbQTKeJT5omaHMw7y4Mlk+Bg0Hkh62WgwZ2UCHSBwz4erMOdeYeV4Mm7ztROg=
Received: by 10.37.12.42 with SMTP id p42mr994305nzi;
        Fri, 16 Sep 2005 23:13:09 -0700 (PDT)
Received: by 10.36.58.18 with HTTP; Fri, 16 Sep 2005 23:13:09 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfys4e003.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8756>

> I found one in our source.  Tony, is the following change
> acceptable to you?
> 
> ------------
> [PATCH] Use git-rev-list not git-rev-tree where appropriate.

Sure ... I'll be glad to see git-rev-tree go.  For some reason it got wired
into my fingers early on, and I keep typing it when I mean to use
git-rev-list, then stare at the screen all confused when it complains
about the arguments I gave it.

-Tony
