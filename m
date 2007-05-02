From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: FAQ Q: another version control system?
Date: Wed, 02 May 2007 10:35:20 +0200
Organization: At home
Message-ID: <f19ig9$473$1@sea.gmane.org>
References: <9e7886190705020012n72070874nae5a74b6d1387e3@mail.gmail.com> <9e7886190705020013k5721480aj767c1c8643fc8d23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 10:35:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjAJH-0006K8-6C
	for gcvg-git@gmane.org; Wed, 02 May 2007 10:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757AbXEBIfg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 04:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754922AbXEBIfg
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 04:35:36 -0400
Received: from main.gmane.org ([80.91.229.2]:44251 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754757AbXEBIfe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 04:35:34 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HjAJ6-0000s1-Mh
	for git@vger.kernel.org; Wed, 02 May 2007 10:35:29 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 May 2007 10:35:28 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 May 2007 10:35:28 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46005>

[Cc: Peter <petervanbohning@gmail.com>, git@vger.kernel.org]

Peter wrote:

> Do we really need another version control system?  As I understand it,
> this is like a distributed, central-server-less, CVS, sorry, SVN
> server.

There is large difference between centralized and distributed SCMs.

Besides, thats like asking why we have so many Linux distributions, or why
we have KDE, GNOME, XFCE, etc.

> But why isn't such a feature set added into SVN?

There is SVK which is distributed SCM built on top of Subversion.
But there are some things that cannot be done because it uses SVN
as engine. Performance is one of them.

> Why do I have to 
> download another version control system just so that I can "git"
> libxcb and X11 so that I can compile gtk so that I can compile xchat
> so that I can go onto the IRC server for madwifi so that I can ask
> someone there why their wifi drivers don't create a /dev/wifi0 on my
> system so that I can get my wireless working????

You don't need to install git to download and install programs; there are
tarballs and packages. You don't even need git to work on program and send
corrections, although it is recommended.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
