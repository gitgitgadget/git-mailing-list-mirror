From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GitTogether topics status
Date: Thu, 18 Sep 2008 13:48:26 -0700 (PDT)
Message-ID: <m363otmb8p.fsf@localhost.localdomain>
References: <200809182207.21448.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Sep 18 22:49:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgQRW-0004qu-9I
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 22:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892AbYIRUsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 16:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753658AbYIRUsa
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 16:48:30 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:34990 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753599AbYIRUs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 16:48:29 -0400
Received: by fg-out-1718.google.com with SMTP id 19so330695fgg.17
        for <git@vger.kernel.org>; Thu, 18 Sep 2008 13:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=p9V+DmEUaxoUpvl90aaM86RXEGU0mU0hfNSTH4rxm5g=;
        b=Wv8N1d9qHEczzTGaqOSxPYT5vV8nubrc3xWllS9RTjkowYa3BuZvuMmk71ncOrlcLm
         mViclW8XhsViovt+ufpKeAF1cqVrqA3OjNoz8KTciWBAgVtNkfqi5IZptz2R2xmNCDSj
         qIN6mCxSlp9Os7cOZf7XRJJIbqOnyjJH1HQ6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=kGS9Sc0eOHkwDFMfTFgm6Qyyzb5ATcwJhetI/18FLYmhaVPBztNCAxpYNeRj55iNwD
         KCr/pTXj9imwqz19MsQcQUdcIbJwJd5b79haS/sQTW55Ejr+orxGn+32g/OTODqd/kQa
         4FEcSRVf479wK2cBe6BnNJJ4fz3oLQ8X47ojg=
Received: by 10.86.57.9 with SMTP id f9mr1177143fga.66.1221770907810;
        Thu, 18 Sep 2008 13:48:27 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.202.248])
        by mx.google.com with ESMTPS id 12sm708418fgg.0.2008.09.18.13.48.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Sep 2008 13:48:26 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m8IKmOgD016525;
	Thu, 18 Sep 2008 22:48:25 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m8IKmN59016522;
	Thu, 18 Sep 2008 22:48:23 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <200809182207.21448.chriscool@tuxfamily.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96244>

Christian Couder <chriscool@tuxfamily.org> writes:

> The topics suggested on the wiki are:
[...]
> More topics/ideas are welcome.

Perhaps a good idea would be to take advantage of whiteboards and
meeting face to face, and talk for example about ideas for perfect GUI
for git, or for editor/IDE/RAD integration interface, designing
mockups of UI.  This could aldo help with improving git homepage (the
original one, I guess).

What also might be interesting to talk about scriptability, having
defined API, libification (I see that there is planned), interfaces to
other programming languages versus calling git plumbing versus
reimplementing git in other languages (e.g. JGit vs JavaGit, Grit vs
Ruby/Git, GitPython vs PyGit, Git.pm vs Git::Repo), but I guess this
discussion could be had on git mailing list.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
