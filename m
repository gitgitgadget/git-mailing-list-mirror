From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH] remote-hg: skip ill-formed references
Date: Sat, 31 Aug 2013 13:58:33 +0000 (UTC)
Message-ID: <loom.20130831T155657-714@post.gmane.org>
References: <20130831011542.GA10486@wheezy.local> <CAMP44s2f7S4STbCOuh35sgdrgAdw-2Tw1LDkjhO37hXLxX3mRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 31 16:05:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFlnw-00019r-Ms
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 16:05:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392Ab3HaOFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 10:05:08 -0400
Received: from plane.gmane.org ([80.91.229.3]:39320 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753103Ab3HaOFH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 10:05:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VFlnT-0000vM-IA
	for git@vger.kernel.org; Sat, 31 Aug 2013 16:05:03 +0200
Received: from z42-07.opera-mini.net ([82.145.211.118])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 31 Aug 2013 16:05:03 +0200
Received: from max by z42-07.opera-mini.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 31 Aug 2013 16:05:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 82.145.211.118 (Opera/9.80 (Series 60; Opera Mini/7.1.32444/30.3793; U; en) Presto/2.8.119 Version/11.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233517>

Felipe Contreras <felipe.contreras <at> 
gmail.com> writes:
> Which repository triggered this?

Tha was some of the vim repositories, upstream 
https://code.google.com/p/vim/ or debian 
anonscm.debian.org/hg/pkg-vim/vim, or both. 
They contain tags with ~ symbol.

I don't have any experience with bazaar yet, so 
cannot say much about it.

Br,
-- 
Max
