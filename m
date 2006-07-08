From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] just an (stupid) idea when creating a new branch
Date: Sat, 08 Jul 2006 23:41:31 +0200
Organization: At home
Message-ID: <e8p8pj$jk3$2@sea.gmane.org>
References: <20060708155547.73054.qmail@web25814.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Jul 08 23:41:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzKYQ-0008JC-1X
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 23:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030406AbWGHVl1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 17:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030407AbWGHVl1
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 17:41:27 -0400
Received: from main.gmane.org ([80.91.229.2]:45215 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030406AbWGHVl0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jul 2006 17:41:26 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FzKYA-0008HQ-Ti
	for git@vger.kernel.org; Sat, 08 Jul 2006 23:41:18 +0200
Received: from host-81-190-22-25.torun.mm.pl ([81.190.22.25])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Jul 2006 23:41:18 +0200
Received: from jnareb by host-81-190-22-25.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Jul 2006 23:41:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-22-25.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23514>

moreau francis wrote:

> Hi GIT folks.
> 
> I'm a complete newbie on git development so excuse me if
> this idea is completely stupid.
> 
> Would it be possible to let the user stick a short explanation
> on  what a branch is supposed to implement during its creation.

It would be possible when/if branch and remotes config would migrate
to .git/config. Currently too many I think relies on refs/heads being
simple sha1 of "top" commit.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
