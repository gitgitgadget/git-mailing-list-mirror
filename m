From: Alam Arias <Alam.GBC@gmail.com>
Subject: Re: Is git-imap-send able to use SSL?
Date: Sat, 21 Jun 2008 01:16:22 -0400
Message-ID: <20080621011622.39fd1625@gmail.com>
References: <D3F1364D-68DC-457D-AC54-AE4B70B1B5AB@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 21 07:21:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9vX5-0003pT-0h
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 07:21:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbYFUFUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 01:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbYFUFUF
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 01:20:05 -0400
Received: from main.gmane.org ([80.91.229.2]:42383 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824AbYFUFUE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 01:20:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1K9vW6-0006F3-W3
	for git@vger.kernel.org; Sat, 21 Jun 2008 05:20:02 +0000
Received: from c-24-128-54-225.hsd1.ma.comcast.net ([24.128.54.225])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Jun 2008 05:20:02 +0000
Received: from Alam.GBC by c-24-128-54-225.hsd1.ma.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Jun 2008 05:20:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-128-54-225.hsd1.ma.comcast.net
X-Newsreader: Claws Mail 3.4.0 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85693>

On Fri, 20 Jun 2008 18:08:42 +0200
Cristian Peraferrer <corellian.c@gmail.com> wrote:

> I am trying to use git-imap-send to send a Draft to my GMail account  
> which uses SSL to connect, I have put the correct port (993 in that  
> case) in the config file but it seems it doesn't work. I figure that  
> git-imap-send is not able to connect using SSL.
> 
 well, there a patch by for SSL support for git-imap-send by Rob
Shearman "robertshearman@gmail.com" over two weeks ago but it did not
apply cleanly on master at the time, well, maybe I can send
my version of this patch? or do I need to ask Rob Shearman?
