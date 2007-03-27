From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Help: git-quiltimport error
Date: Wed, 28 Mar 2007 00:49:12 +0200
Organization: At home
Message-ID: <euc6ra$qqu$1@sea.gmane.org>
References: <1175014867.15767.13.camel@roc-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 28 01:22:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWL09-0005WO-2E
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 01:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbXC0XWm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 19:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933364AbXC0XW2
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 19:22:28 -0400
Received: from main.gmane.org ([80.91.229.2]:47447 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932561AbXC0XW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 19:22:27 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HWKpA-0003Mq-FT
	for git@vger.kernel.org; Wed, 28 Mar 2007 01:11:33 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Mar 2007 01:11:32 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Mar 2007 01:11:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43319>

Bryan Wu wrote:

> When I am using latest git-quiltimport, I met following errors. 
> 
> $git-quiltimport --dry-run --author "Bryan Wu <bryan.wu@analog.com>" \
>                  --patches "/home/roc/mm-tree/patches"  
> /usr/local/bin/git-quiltimport: 114: Syntax error: Missing '))'
> 
> Could you please help me on this?

While at it, would it be hard to add --fast option which would make
git-quiltimport to use git-fast-import mechanism?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
