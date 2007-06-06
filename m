From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] This patch was inspired by ClearCase command 'ct man', which
Date: Wed, 06 Jun 2007 13:39:37 +0200
Organization: At home
Message-ID: <f4663l$tlq$1@sea.gmane.org>
References: <20070605182818.GA8420@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 13:44:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvtwf-0000HG-1S
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 13:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758569AbXFFLor (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 07:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761048AbXFFLor
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 07:44:47 -0400
Received: from main.gmane.org ([80.91.229.2]:45746 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758569AbXFFLoq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 07:44:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hvts9-0008Jf-A8
	for git@vger.kernel.org; Wed, 06 Jun 2007 13:40:17 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Jun 2007 13:40:17 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Jun 2007 13:40:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49286>

Nguyen Thai Ngoc Duy wrote:

> opens an html help file on Windows. I at first attempted to
> implement it for MinGW port only but found it so useful that I
> wanted to have it even in Linux.

Could you _please_ follow git commit message convention, which is first line
providing summary of a change, separated by empty line from the rest of
commit description.

For example:

-- >8 --
Subject: [PATCH 1/2] Add '--html' option to git, which gives help in HTML

This patch was inspired by ClearCase command 'ct man', which
opens an html help file on Windows. I at first attempted to
implement it for MinGW port only but found it so useful that I
wanted to have it even in Linux.

[...]

Signed-off-by: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
