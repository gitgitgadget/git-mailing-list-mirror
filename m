From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Another Perforce importer for git
Date: Mon, 14 Aug 2006 17:11:24 +0200
Message-ID: <81b0412b0608140811k4db611a4m630b6f909d736a90@mail.gmail.com>
References: <81b0412b0608140604u75c6522brbc1bc83fc7c9c5c8@mail.gmail.com>
	 <ebq016$fd3$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 14 17:12:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCe6E-0006kQ-Ji
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 17:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbWHNPL0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 11:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbWHNPL0
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 11:11:26 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:10925 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751995AbWHNPLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 11:11:25 -0400
Received: by wr-out-0506.google.com with SMTP id i21so177264wra
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 08:11:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jsj5vF9PYTHBY+TnXFtschDVr9vclymkj4QuMzIztsfus1AyLvQL6G57ETZ81bW2vjl2LH3gVbqyKZRkHJV1GpN8gZfPcb/WaKCmh07KxIesJu7xUTabXwg6hWMAUSp2B+LLX7POACiE5QetrZoiG0eUW9xJQpUvkT80O/QiwhY=
Received: by 10.78.120.6 with SMTP id s6mr3293545huc;
        Mon, 14 Aug 2006 08:11:24 -0700 (PDT)
Received: by 10.78.160.12 with HTTP; Mon, 14 Aug 2006 08:11:24 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <ebq016$fd3$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25358>

On 8/14/06, Jakub Narebski <jnareb@gmail.com> wrote:
> > Just in case someone might ever need this: it imports
> > a _synced_ state into git repo. IOW, you sync down
> > the files as you were commanded (it's corporal, umm...
> > corporate, remember?) and run the script to create
> > a commit for you. You still have to run git-commit manually,
> > but don't have to pass "-a" to it (which can be dangerous,
> > and does not pick up the files recently added to p4 repo).
>
> Could you please add appropriate entry in GitWiki page
>  http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
> Thanks in advance...

It a bit not enough, I'm afraid. Besides, I'd have to reference the
scriptlet by gmane - there wont ever be a webpage, I think:
http://permalink.gmane.org/gmane.comp.version-control.git/25352
