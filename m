From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [StGit] How do I get colored diff output?
Date: Thu, 30 Aug 2007 18:57:04 +0200
Organization: At home
Message-ID: <fb6sst$6rt$2@sea.gmane.org>
References: <20070830123222.GG5050@xp.machine.xx> <tnx3ay1w40p.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 30 19:00:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQnNO-0005OT-T8
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 19:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758461AbXH3RAL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 13:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758432AbXH3RAL
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 13:00:11 -0400
Received: from main.gmane.org ([80.91.229.2]:34677 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757271AbXH3RAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 13:00:09 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IQnNC-00019p-7b
	for git@vger.kernel.org; Thu, 30 Aug 2007 19:00:02 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 19:00:02 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 19:00:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57053>

Catalin Marinas wrote:

> I now tried the example stgit.pager option and it looks bad indeed. In
> the meantime, there is a diffcol.sh script in the contrib directory, I
> use this instead and it looks much nicer.

That means it should be not removed even though git-diff learned --color...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
