From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-fast-import
Date: Tue, 06 Feb 2007 10:53:20 +0100
Organization: At home
Message-ID: <eq9j3k$sn1$1@sea.gmane.org>
References: <20070206023111.GB9222@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 06 10:52:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEN02-0005eI-5G
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 10:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbXBFJwO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 04:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752029AbXBFJwN
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 04:52:13 -0500
Received: from main.gmane.org ([80.91.229.2]:35582 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752027AbXBFJwM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 04:52:12 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HEMzZ-00077r-5d
	for git@vger.kernel.org; Tue, 06 Feb 2007 10:52:01 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Feb 2007 10:52:01 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Feb 2007 10:52:01 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38828>

Shawn O. Pearce wrote:

> `filemodify`
> ^^^^^^^^^^
[...]
> `filedelete`
> ^^^^^^^^^^

Shouldn't it be:

`filemodify`
^^^^^^^^^^^^

and:

`filedelete`
^^^^^^^^^^^^

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
