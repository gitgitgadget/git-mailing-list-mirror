From: Artem Khodush <greenkaa@gmail.com>
Subject: Re: announce: git browser
Date: Tue, 6 Dec 2005 11:13:29 +0300
Message-ID: <40b2b7d90512060013j23345bf3o2021080edcfbd9c0@mail.gmail.com>
References: <40b2b7d90512041623g1e22fecai9470ffcb94f40a58@mail.gmail.com>
	 <20051205004238.GE22159@pasky.or.cz>
	 <40b2b7d90512041720i65f63ee1pcfe32d2c0c3c357b@mail.gmail.com>
	 <20051205232626.GH22159@pasky.or.cz>
	 <40b2b7d90512052240t778f1c8kf182ff065687068c@mail.gmail.com>
	 <7voe3u67ik.fsf@assigned-by-dhcp.cox.net>
	 <40b2b7d90512052331s22adb055y9f99b8cafe20c0c3@mail.gmail.com>
	 <7vd5ka653t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 09:15:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjXxD-0000El-I8
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 09:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbVLFINc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 03:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbVLFINc
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 03:13:32 -0500
Received: from nproxy.gmail.com ([64.233.182.205]:29359 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750747AbVLFINa convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 6 Dec 2005 03:13:30 -0500
Received: by nproxy.gmail.com with SMTP id x29so99340nfb
        for <git@vger.kernel.org>; Tue, 06 Dec 2005 00:13:29 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bftBZpi1o4GTBTMaTz5BrXsRqvuv6AS6FZR2cTaXMv144LGAVm/8H2vPc319CDxOrsjdNWURDOtLP21Mb2x7HOoXc0edwBxrbrhI3g7p/NLplK9YXKt3ecNEE9P7VYTPIHDMHXascC6CGgt5j8uN+0e+Fdc2UUkUm6kJxyuPXYQ=
Received: by 10.48.210.2 with SMTP id i2mr38486nfg;
        Tue, 06 Dec 2005 00:13:29 -0800 (PST)
Received: by 10.48.216.3 with HTTP; Tue, 6 Dec 2005 00:13:29 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5ka653t.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13268>

>
> In case it was not obvious, I was talking about an NNTP server,
> not a client.
>
> You would probably have to keep a mapping between sequence
> number and commit object name in each "newsgroup", which is the
> only nontrivial part.

And the reason why special NNTP server is needed is, I guess,
that plain NNTP server will not be able to cope with all the diffs
stored in message database? Well, but then, the newsgroups
will not be distributable..

Or is there any other reason?
