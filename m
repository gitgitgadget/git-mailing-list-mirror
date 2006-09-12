From: Tom Prince <tom.prince@ualberta.net>
Subject: Re: [PATCH] contrib/vim: add syntax highlighting file for commits
Date: Mon, 11 Sep 2006 20:08:13 -0600
Message-ID: <20060912020813.GD26332@socrates.priv>
References: <20060911232249.GB29736@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Sep 12 04:06:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMxfb-0007sc-AH
	for gcvg-git@gmane.org; Tue, 12 Sep 2006 04:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965249AbWILCGP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 22:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965252AbWILCGP
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 22:06:15 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:55002 "EHLO
	pd5mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S965249AbWILCGO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Sep 2006 22:06:14 -0400
Received: from pd5mr5so.prod.shaw.ca
 (pd5mr5so-qfe3.prod.shaw.ca [10.0.141.181]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0J5G00GTEJ4AQ5C0@l-daemon> for git@vger.kernel.org; Mon,
 11 Sep 2006 20:04:58 -0600 (MDT)
Received: from pn2ml3so.prod.shaw.ca ([10.0.121.147])
 by pd5mr5so.prod.shaw.ca (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar
 15 2004)) with ESMTP id <0J5G00KA0J4AWQE0@pd5mr5so.prod.shaw.ca> for
 git@vger.kernel.org; Mon, 11 Sep 2006 20:04:58 -0600 (MDT)
Received: from socrates.priv ([68.148.44.80])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0J5G0077QJ4A04J0@l-daemon> for git@vger.kernel.org; Mon,
 11 Sep 2006 20:04:58 -0600 (MDT)
Received: from socrates.priv (localhost [127.0.0.1])
	by socrates.priv (8.13.4/8.13.4) with ESMTP id k8C28Dek030541	for
 <git@vger.kernel.org>; Mon, 11 Sep 2006 20:08:13 -0600
Received: (from cougar@localhost)	by socrates.priv (8.13.4/8.13.4/Submit)
 id k8C28DUL030540	for git@vger.kernel.org; Mon, 11 Sep 2006 20:08:13 -0600
In-reply-to: <20060911232249.GB29736@coredump.intra.peff.net>
To: git@vger.kernel.org
Mail-followup-to: git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.11-2006-05-17
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26876>

On Mon, Sep 11, 2006 at 07:22:49PM -0400, Jeff King wrote:
> +  1. Copy commit-syntax.vim to vim's syntax directory:
> +     $ cp commit-syntax.vim $HOME/.vim/syntax/gitcommit.vim
...
> diff --git a/contrib/vim/commit-syntax.vim b/contrib/vim/commit-syntax.vim

It would be more obvious if you could do cp gitcomit.vim $HOME/.vim/syntax/

  Tom
