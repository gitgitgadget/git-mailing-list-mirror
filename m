From: Jakub Narebski <jnareb@gmail.com>
Subject: git-rebase strange message
Date: Wed, 16 Aug 2006 12:26:09 +0200
Organization: At home
Message-ID: <eburqb$jhi$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Aug 16 12:26:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDIbB-0004Tj-WA
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 12:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWHPK0D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 06:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWHPK0D
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 06:26:03 -0400
Received: from main.gmane.org ([80.91.229.2]:36762 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750824AbWHPK0B (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Aug 2006 06:26:01 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GDIak-0004NJ-DY
	for git@vger.kernel.org; Wed, 16 Aug 2006 12:25:42 +0200
Received: from host-81-190-28-152.torun.mm.pl ([81.190.28.152])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Aug 2006 12:25:42 +0200
Received: from jnareb by host-81-190-28-152.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Aug 2006 12:25:42 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-28-152.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25511>

Why git-am says
  No changes - did you forget update-index?
when I changed file to <upstream> version? Shouldn't it suggest that either
patch is applied, or to 'git am --skip' the patch?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
