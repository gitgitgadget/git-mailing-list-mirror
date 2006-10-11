From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Removes the <?xml?> declaration from gitweb.pl
Date: Wed, 11 Oct 2006 23:27:35 +0200
Organization: At home
Message-ID: <egjnk5$bpn$2@sea.gmane.org>
References: <20061011172553.GA1147@linux-mips.org> <egjang$nmh$1@sea.gmane.org> <egjllu$6k8$1@sea.gmane.org> <egjmri$atp$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Oct 11 23:40:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXllS-0005qn-M4
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 23:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161391AbWJKVdi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 17:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422640AbWJKVdh
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 17:33:37 -0400
Received: from main.gmane.org ([80.91.229.2]:7040 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1422641AbWJKVdG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 17:33:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GXle4-0003o2-6a
	for git@vger.kernel.org; Wed, 11 Oct 2006 23:29:44 +0200
Received: from host-81-190-20-194.torun.mm.pl ([81.190.20.194])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Oct 2006 23:29:44 +0200
Received: from jnareb by host-81-190-20-194.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Oct 2006 23:29:44 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-194.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28751>

Pazu wrote:

> The XML declaration forces IE6 into quirks mode, breaking our
> nice standards compliant stylesheet.

But isn't it _required_ by XML/XHTML?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
