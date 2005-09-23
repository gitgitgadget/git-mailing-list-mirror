From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git 0.99.7b doesn't build on Cygwin
Date: Sat, 24 Sep 2005 10:08:28 +1200
Message-ID: <46a038f905092315081de776c3@mail.gmail.com>
References: <ud5mznc1x.fsf@peter-b.co.uk>
	 <Pine.LNX.4.63.0509231537390.11109@wgmdd8.biozentrum.uni-wuerzburg.de>
	 <14403.62.254.128.6.1127483455.squirrel@mail.twu.net>
Reply-To: Martin Langhoff <martin.langhoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 24 00:09:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIvic-0004FE-Qo
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 00:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbVIWWIc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 18:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbVIWWIc
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 18:08:32 -0400
Received: from qproxy.gmail.com ([72.14.204.201]:5171 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751320AbVIWWIb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 18:08:31 -0400
Received: by qproxy.gmail.com with SMTP id v40so216379qbe
        for <git@vger.kernel.org>; Fri, 23 Sep 2005 15:08:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IPcHDU6/dn5spSNRKDBEgQ9iJIJGaZUDykhkiNN1Bb3XVYFigXlZ8D9HmFluiET2UWL9Aug4nXn/cmh8RfzaQAQnzFpjoYtQzYHtHqL/IOOb9Qgpi5lUq/WX3lkSyOE52TzXGzXvdrImxCxNv9LnKWAKUB87ji5Hix3P3dvifz0=
Received: by 10.65.11.15 with SMTP id o15mr249271qbi;
        Fri, 23 Sep 2005 15:08:28 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Fri, 23 Sep 2005 15:08:28 -0700 (PDT)
To: Peter TB Brett <peter@peter-b.co.uk>
In-Reply-To: <14403.62.254.128.6.1127483455.squirrel@mail.twu.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9207>

On 9/24/05, Peter TB Brett <peter@peter-b.co.uk> wrote:
> Ah well, I'll just have to use something else -- I know Mercurial works on
> Windows.  To be honest, I'd prefer to use git though; I've used it on
> other projects and it's really nice.

Petr Baudis was working on a Mercurial-GIT gateway which could be
useful, or perhaps you can use tailor.py. OTOH, if you have a unix
machine in the network, you can probably make cretive use of samba...

cheers,


martin
