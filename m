From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-am and workflow question
Date: Thu, 08 Feb 2007 09:34:28 +0100
Organization: At home
Message-ID: <eqen7k$fb5$1@sea.gmane.org>
References: <FA0FC64E-75D2-4722-8BD9-F7E6C8C9AFA7@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 08 09:33:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HF4iS-0002kx-Hv
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 09:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423024AbXBHIdM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 03:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422981AbXBHIdM
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 03:33:12 -0500
Received: from main.gmane.org ([80.91.229.2]:58675 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423024AbXBHIdL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 03:33:11 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HF4iC-0001UM-Ek
	for git@vger.kernel.org; Thu, 08 Feb 2007 09:33:00 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 09:33:00 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 09:33:00 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39047>

[Cc: git@vger.kernel.org]

Kumar Gala wrote:

> I poked around the docs and mailing lists but didn't find an answer  
> to my question some simple searches so I figured it might be easier  
> to just post a query to the list.
> 
> So my problem is that I'm applying some patches from a mbox and want  
> to be able to do some slight modifications before actually committing  
> the change.  I was wondering how people solve this problem (if at all).

Both git-am and git-applymbox have interactive mode, although I'm not
sure how extensively interactive this mode is.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
