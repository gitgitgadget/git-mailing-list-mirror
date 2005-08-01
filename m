From: Wayne Scott <wsc9tt@gmail.com>
Subject: Re: [RFC] extending git-ls-files --exclude.
Date: Mon, 1 Aug 2005 11:14:37 -0500
Message-ID: <59a6e5830508010914714a1fd6@mail.gmail.com>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
	 <tnx1x5ryvn2.fsf@arm.com> <20050722192424.GB8556@mars.ravnborg.org>
	 <7vy87yr2xh.fsf@assigned-by-dhcp.cox.net>
	 <20050722205948.GE11916@pasky.ji.cz>
	 <7vd5p73jlu.fsf@assigned-by-dhcp.cox.net>
	 <20050728155210.GA17952@pasky.ji.cz>
	 <7vack6mcd7.fsf@assigned-by-dhcp.cox.net>
	 <20050729073644.GE24895@pasky.ji.cz>
	 <7vd5p2hve1.fsf@assigned-by-dhcp.cox.net>
Reply-To: Wayne Scott <wsc9tt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 01 18:26:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dzd5k-000098-Mq
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 18:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbVHAQTT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Aug 2005 12:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbVHAQPI
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Aug 2005 12:15:08 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:33195 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262219AbVHAQOs convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 1 Aug 2005 12:14:48 -0400
Received: by wproxy.gmail.com with SMTP id i34so23606wra
        for <git@vger.kernel.org>; Mon, 01 Aug 2005 09:14:39 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Cz/j3UkJpCmjEzhFR0BtpopVoXTmyc/Ox0fx+2BhDMQ3fU2/Crz5iXb2vrS47jVNu9B8EUI+mJ8D+9Ma2GkLfspLivtXWB9ThEiuNUy06Kugs7CFGZi6E9ZsmYqgtjEaipWlMR/4dR3DC1YeZ/NJcJbGJSKGwOydNejQDNm4kZY=
Received: by 10.54.30.50 with SMTP id d50mr2963745wrd;
        Mon, 01 Aug 2005 09:14:37 -0700 (PDT)
Received: by 10.54.36.41 with HTTP; Mon, 1 Aug 2005 09:14:37 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5p2hve1.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 7/29/05, Junio C Hamano <junkio@cox.net> wrote:
> While I would in principle prefer to offer more freedom to shoot
> yourselves in the foot ;-), the pragmatic side of me says too
> much flexibility is just asking for trouble with not much
> additional gain.  

For an example of just how far you can go down the road to mind
numbing complexity try reading the rsync manpage about how to exclude
files.

-Wayne
