From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: Subproject status
Date: Sun, 25 Mar 2007 23:11:39 -0300
Message-ID: <46072BDB.1010001@xs4all.nl>
References: <Pine.LNX.4.64.0703251304280.6485@iabervon.org> <eu70tc$38c$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 26 04:12:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVeh4-00024a-B7
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 04:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933187AbXCZCMA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 22:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933291AbXCZCMA
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 22:12:00 -0400
Received: from main.gmane.org ([80.91.229.2]:60408 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933187AbXCZCL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 22:11:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HVegb-0000Fe-6e
	for git@vger.kernel.org; Mon, 26 Mar 2007 04:11:53 +0200
Received: from bhe200139179018.res-com.wayinternet.com.br ([200.139.179.18])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Mar 2007 04:11:53 +0200
Received: from hanwen by bhe200139179018.res-com.wayinternet.com.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Mar 2007 04:11:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: bhe200139179018.res-com.wayinternet.com.br
User-Agent: Thunderbird 1.5.0.10 (X11/20070306)
In-Reply-To: <eu70tc$38c$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43106>

Jakub Narebski wrote:
> [Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org]
> 
> Daniel Barkalow wrote:
> 
>> I remember that last time I checked, there were a number of designs for 
>> subprojects and at least a couple of implementations, but none that was 
>> complete to the point of being mergeable. Are there any subproject 
>> implementations available that haven't run into unsolveable problems? I'm 
>> presently only looking at stuff that totals to a reasonable single project 
>> size and rate of growth, so I'm not worried about the large-scale storage 
>> requirement issue.
> 
> Check out http://git.or.cz/gitwiki/SubprojectSupport

this points to

  http://www.kernel.org/git/?p=git/git.git;a=blob;hb=todo;f=Subpro.txt

which is a broken. It results in



1Reading blob failed.


Han-Wen
