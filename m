From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: ~/.git/config ?
Date: Fri, 26 May 2006 20:05:26 +0300
Message-ID: <20060526200526.d8a2f776.tihirvon@gmail.com>
References: <20060526152837.GQ23852@progsoc.uts.edu.au>
	<20060526193325.d2a530a4.tihirvon@gmail.com>
	<20060526163829.GB10488@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: wildfire@progsoc.uts.edu.au, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 26 19:07:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjfmV-00045J-Fi
	for gcvg-git@gmane.org; Fri, 26 May 2006 19:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWEZRHS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 13:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWEZRHS
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 13:07:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:44670 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751163AbWEZRHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 May 2006 13:07:16 -0400
Received: by nf-out-0910.google.com with SMTP id n29so96381nfc
        for <git@vger.kernel.org>; Fri, 26 May 2006 10:07:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=AxEO/gzXNSrPCwBU3zPCw1gufcYtjUbKrSajFySIWTDXx7Z0TQB06ECE1V5VC/uLNOSjydj9OyXmhwcNhtBwSsRi8kOh+np312zAgaWG/IG/O+NwwcRLHfOm/UyTRhlz9FnXlt3t6mMmoqR4S44hQS5lsp9aNe4QQ/iysEuqq8A=
Received: by 10.49.6.9 with SMTP id j9mr2651nfi;
        Fri, 26 May 2006 10:03:30 -0700 (PDT)
Received: from garlic.home.net ( [82.128.200.31])
        by mx.gmail.com with ESMTP id d2sm690128nfe.2006.05.26.10.03.27;
        Fri, 26 May 2006 10:03:28 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060526163829.GB10488@pasky.or.cz>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20821>

Petr Baudis <pasky@suse.cz> wrote:

> Dear diary, on Fri, May 26, 2006 at 06:33:25PM CEST, I got a letter
> where Timo Hirvonen <tihirvon@gmail.com> said that...
> > I backup my $HOME using git, so there's a .git directory in ~.
> 
> Then it should be called ~/.gitconfig. :-)

I just wanted to point the fact that ~/.git/ could not be used :)

> > I don't think a global config file is really needed but it would be
> > nice if .git/config would override the environment variables, not the
> > other way around.
> 
> Then you have no other way to override .git/config e.g. when committing
> patches submitted by other people.

git commit --author "name <email>"

-- 
http://onion.dynserv.net/~timo/
