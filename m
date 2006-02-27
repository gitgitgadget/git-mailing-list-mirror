From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Add a Documentation/git-tools.txt
Date: Mon, 27 Feb 2006 07:44:10 +0100
Message-ID: <e5bfff550602262244q592cb085scc7a93cc99e1cf8e@mail.gmail.com>
References: <e5bfff550602190200j1ef3858as6a1564064dc81fef@mail.gmail.com>
	 <tnxwtfq8gok.fsf@arm.com>
	 <e5bfff550602260022jde1fe2n4ec117c609a5d22d@mail.gmail.com>
	 <7vslq57mzn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Alexandre Julliard" <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Mon Feb 27 07:44:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDc7J-00039P-H8
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 07:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbWB0GoN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 01:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751593AbWB0GoN
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 01:44:13 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:45910 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751584AbWB0GoM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 01:44:12 -0500
Received: by zproxy.gmail.com with SMTP id 18so887874nzp
        for <git@vger.kernel.org>; Sun, 26 Feb 2006 22:44:11 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mc+PJof4B/xXKkMgo9iXFTZeLgAAt1GBIahNaVrheMmJMaR2kFF+T/yPIU2HPMpoNJx3Y+R4DqF6WdBhHenE1QFbpFZvq8d+PQWUXalsBqEJeQCNGp+wWeMjcFBmpQWaWR8jDhGxdtLoi3ofVnc/8nqc/hcZ0GH/kU6N2wXeHP8=
Received: by 10.64.179.19 with SMTP id b19mr3263999qbf;
        Sun, 26 Feb 2006 22:44:10 -0800 (PST)
Received: by 10.64.131.15 with HTTP; Sun, 26 Feb 2006 22:44:10 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vslq57mzn.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16828>

On 2/26/06, Junio C Hamano <junkio@cox.net> wrote:
> >
> > Please consider for apply.
>
> Thanks.  I've considered it, but it is seriously linewrapped.
>

Sorry for this. It is ok 80 columns max?

> > +        - *pcl-cvs* (contrib/)
> > +
> > +            This is an Emacs interface for git. The user interface is
> > modeled on
> > +            pcl-cvs.
>
> Also is the emacs one really pcl-cvs?  I thought it was modeled
> after pcl-cvs, but this is a different implementation to deal
> with git.  If Alexandre does not have a name for it, I'd say
> we'll list it as "git.el".
>

Ok, waiting for Alexandre's answer.

This week I foreseen to be quite busy, so perhaps the patch will be
delayed a little bit.

Marco
