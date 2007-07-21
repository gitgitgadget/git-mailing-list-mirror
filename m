From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GSoC status report
Date: Sat, 21 Jul 2007 02:24:01 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707210223400.14781@racer.site>
References: <200707201024.35605.jnareb@gmail.com> <Pine.LNX.4.64.0707201118550.14781@racer.site>
 <200707210312.11745.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 03:24:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IC3ht-0000q6-D5
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 03:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938956AbXGUBYN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 21:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933780AbXGUBYM
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 21:24:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:44102 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S935962AbXGUBYK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 21:24:10 -0400
Received: (qmail invoked by alias); 21 Jul 2007 01:24:08 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp040) with SMTP; 21 Jul 2007 03:24:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18eeX0Vd08eFc4zJwX149VJYfsLbCwKJVAa4kOmcL
	csWIHqPU43+hIv
X-X-Sender: gene099@racer.site
In-Reply-To: <200707210312.11745.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53129>

Hi,

On Sat, 21 Jul 2007, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> 
> > FWIW this is the list of scripts that I would like to see converted by the 
> > end of the year (feel free to object), ordered by their size:
> > 
> > verify-tag, reset, repack, tag, checkout, rebase, bisect, 
> > rebase--interactive, am, commit.
> 
> I thought that verify-tag would be put into git-tag, with git-verify-tag
> being alias to "git tag --verify" or something like that.
> 
> What about git-revert and git-cherry-pick (it is one script)? Or are you
> simply concentrating on the tools you need most in common workflow?

They are builtins since v1.5.1~170^2~2.

Hth,
Dscho
