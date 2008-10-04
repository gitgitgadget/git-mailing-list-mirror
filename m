From: Mark Burton <markb@ordern.com>
Subject: Re: How to list versioned files with modification status
Date: Sat, 4 Oct 2008 23:02:59 +0000 (UTC)
Message-ID: <loom.20081004T223639-341@post.gmane.org>
References: <20081004131256.586a5fbf@smartavionics.com>  <81b0412b0810041440w131647aeo9c14f55cd38da635@mail.gmail.com>  <loom.20081004T215458-15@post.gmane.org> <81b0412b0810041534o7b38507qe63db47cd07fdc16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 05 01:04:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmGAj-0008T1-Kt
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 01:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820AbYJDXDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2008 19:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754817AbYJDXDO
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Oct 2008 19:03:14 -0400
Received: from main.gmane.org ([80.91.229.2]:42972 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754954AbYJDXDN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2008 19:03:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KmG9U-0003AQ-2P
	for git@vger.kernel.org; Sat, 04 Oct 2008 23:03:08 +0000
Received: from host86-128-74-78.range86-128.btcentralplus.com ([86.128.74.78])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 04 Oct 2008 23:03:08 +0000
Received: from markb by host86-128-74-78.range86-128.btcentralplus.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 04 Oct 2008 23:03:08 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 86.128.74.78 (Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.0.3) Gecko/2008092510 Ubuntu/8.04 (hardy) Firefox/3.0.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97485>


> > 'git diff --name-status' looks useful but it only shows the files that have
> > changed - I would like to see the names of the files that haven't changed.
> 
> There is nothing to do something like that, but...
> 
> > Even svn could do that (svn status).
> 
> what exactly are trying to achieve? It is just strange that no one
> asked for something like this before...

What I am trying to achieve is to list the versioned files that have no
pending modifications (didn't I say that in the original posting?)

Strange, perhaps, but not completely useless in that it does tell you
something about the state of the current working set of files.

BTW - and sorry for posting the same question in two different emails, I
thought the first one had not made it onto the list - I shall be more
patient in the future.

Mark
