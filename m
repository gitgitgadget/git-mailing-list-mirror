From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Subproject status
Date: Mon, 26 Mar 2007 10:47:00 +0200
Organization: At home
Message-ID: <eu814c$im6$1@sea.gmane.org>
References: <Pine.LNX.4.64.0703251304280.6485@iabervon.org> <eu70tc$38c$1@sea.gmane.org> <46074D6D.1050301@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 26 10:56:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVl0E-0002Dp-L4
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 10:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933679AbXCZI4b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 04:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933751AbXCZI4b
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 04:56:31 -0400
Received: from main.gmane.org ([80.91.229.2]:53297 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933679AbXCZI43 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 04:56:29 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HVkvt-00026w-4T
	for git@vger.kernel.org; Mon, 26 Mar 2007 10:52:05 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Mar 2007 10:52:05 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Mar 2007 10:52:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43135>

Han-Wen Nienhuys wrote:

> Jakub Narebski wrote:

>> Check out http://git.or.cz/gitwiki/SubprojectSupport
> 
> this points to
> 
>   http://www.kernel.org/git/?p=git/git.git;a=blob;hb=todo;f=Subpro.txt
> 
> which is a broken. It results in
> 
> 
> 
> 1Reading blob failed.

Thanks. Subpro.txt was removed from todo, as it described old, abandoned
idea about subproject support (the "mountpoint" in commit object one).

Fixed (the link, not gitweb: I don't know where this '1' comes from).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
