From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [ANNOUNCE] git/gitweb.git repository
Date: Fri, 7 Sep 2007 16:39:46 +1000
Message-ID: <ee77f5c20709062339l54bbafc7ufaafdacc9da74ced@mail.gmail.com>
References: <20070831000149.GK1219@pasky.or.cz>
	 <ee77f5c20708301756k60b4d295j907da463af477982@mail.gmail.com>
	 <ee77f5c20708312246u37f9c1bahe2211117abd05790@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jnareb@gmail.com, ltuikov@yahoo.com
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Sep 07 08:39:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITXVR-0004F5-0o
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 08:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbXIGGjs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 02:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbXIGGjs
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 02:39:48 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:21923 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932523AbXIGGjr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 02:39:47 -0400
Received: by rv-out-0910.google.com with SMTP id k20so353296rvb
        for <git@vger.kernel.org>; Thu, 06 Sep 2007 23:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=9+CaLOIGAa4N+d4noD+o8tXecNOkH6mTGKx7UzHREyQ=;
        b=RRT6ao+cWIdkSs0/dCv0SL6+z0HmdFrWDWI8xICrHNDbeUQJi/BxUa7QYvhu1tExJ1CNO1PDA22Iq+LPT2xnf94wez9VYQNkyfUs+X9ny1jriGqXCRl/1tTQ8+rujmtfdSQgAUN6YKnKG4jtO26+x85ggdQl6FMxDIcfj46tnH4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pBqEo5chMwv+LCn+2nb1uG+G1CwbaD4katHPjbhvPHRkGqdTOfwqIRly0e66+ya5rWpNq4JhwIwa+AAW1WdysS/8CEvWRaHa8KDAEYuy829xuqLA2pD8o3THk23e8MkF5S6u2hfNaNU/nxv2gqtuK3cnQWmY0x9R2BDKII9IZLg=
Received: by 10.140.126.14 with SMTP id y14mr597723rvc.1189147187063;
        Thu, 06 Sep 2007 23:39:47 -0700 (PDT)
Received: by 10.141.115.4 with HTTP; Thu, 6 Sep 2007 23:39:46 -0700 (PDT)
In-Reply-To: <ee77f5c20708312246u37f9c1bahe2211117abd05790@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57988>

On 01/09/2007, David Symonds <dsymonds@gmail.com> wrote:
> On 31/08/07, David Symonds <dsymonds@gmail.com> wrote:
> > On 31/08/2007, Petr Baudis <pasky@suse.cz> wrote:
> > >   Please feel encouraged to make random forks for your development
> > > efforts, or push your random patches (preferrably just bugfixes,
> > > something possibly controversial should be kept in safe containment like
> > > a fork or separate branch) to the mob branch.
> >
> > Sorry, I'm still relatively new to git, and couldn't work out how to
> > push to the mob branch, so it's inline below. It's fairly minor, just
> > adding <span title="foo">..</span> around author names when they get
> > abbreviated.
>
> Okay, I worked out how to push to the mob branch: it's commit 37c8546.
> I can refactor this somewhat if that's an issue.

Has anyone taken a look at this? If it's bad/unwanted, just tell me
and I'll drop it.


Dave.
