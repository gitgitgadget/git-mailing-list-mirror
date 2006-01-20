From: Franck <vagabon.xyz@gmail.com>
Subject: Re: [QUESTION] about .git/info/grafts file
Date: Fri, 20 Jan 2006 14:43:10 +0100
Message-ID: <cda58cb80601200543s41b3f63ch@mail.gmail.com>
References: <cda58cb80601170928r252a6e34y@mail.gmail.com>
	 <cda58cb80601170932o6f955469y@mail.gmail.com>
	 <7v8xtdrqwg.fsf@assigned-by-dhcp.cox.net>
	 <cda58cb80601190251v5251c8bdh@mail.gmail.com>
	 <7v3bjkf54k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 20 14:43:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzwXs-0005mM-Ft
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 14:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWATNnM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jan 2006 08:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWATNnM
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jan 2006 08:43:12 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:10282 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750967AbWATNnL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2006 08:43:11 -0500
Received: by zproxy.gmail.com with SMTP id 14so459976nzn
        for <git@vger.kernel.org>; Fri, 20 Jan 2006 05:43:10 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gLn7RCPF+5dAqfp6rZEakYDAl6SI11q2w5u5FrYX0AqcLly/NXdrmONhb5HQgNW2m3VzLgHj+pD0joRXSbJ5JkGSW8enhRVSRLgsVPVQQpRGn8BvBze2gCQ084tvxNfeWIM7o/cn1C6ZPk7/9/AGTSIL6akpVvxvYm1elJYJPbI=
Received: by 10.37.14.13 with SMTP id r13mr1397032nzi;
        Fri, 20 Jan 2006 05:43:10 -0800 (PST)
Received: by 10.36.47.7 with HTTP; Fri, 20 Jan 2006 05:43:10 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bjkf54k.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14960>

2006/1/19, Junio C Hamano <junkio@cox.net>:
> Franck <vagabon.xyz@gmail.com> writes:
>
> > I don't see why it is so bad to create a "grafted" repository ? I want
> > it to be small but still want to merge by using git-resolve with XX
> > repository.
>
> Franck, and people on the list,
>
> I have a bad habit of responding to a "call for help" request by
> stating how things are currently done and why, sometimes with an

what ? Hey, I would say that you, Linus and other people on the list
have a GREAT habit to spend time to answer others how things work. And
there are usually accurate explanations, examples with a lot of
details with them.

Thanks !
--
               Franck
