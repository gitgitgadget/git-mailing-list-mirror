From: Christian Couder <chriscool@tuxfamily.org>
Subject: Input welcome for "Git Bisect and Testing" presentation at GTAC 2010
Date: Sun, 12 Sep 2010 22:25:52 +0200
Message-ID: <201009122225.52520.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Ingo Molnar <mingo@elte.hu>, Andreas Ericsson <ae@op5.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 12 22:26:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Out7p-0002sn-5t
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 22:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676Ab0ILU0D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Sep 2010 16:26:03 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:41834 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752802Ab0ILU0B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Sep 2010 16:26:01 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 240688180BA;
	Sun, 12 Sep 2010 22:25:53 +0200 (CEST)
User-Agent: KMail/1.13.2 (Linux/2.6.32-24-generic; KDE/4.4.2; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156056>

Hi,

The Google Test Automation Conference (http://www.gtac.biz) committee accepted 
my proposal for a "Git Bisect and Testing" presentation at the GTAC 2010 in 
India on October 28 and 29. So I am working on it.

It will be roughly based on my previous "Fighting regressions with git bisect" 
article (http://www.kernel.org/pub/software/scm/git/docs/git-bisect-lk2009.html)
and presentation (http://www.linux-kongress.org/2009/slides/fighting_regressions_with_git_bisect_christian_couder.pdf). 
But I would be happy to add more concrete examples of how "git bisect" is used 
in the real world. And more generally I am very open to any kind of feedback 
about "git bisect".

For example it can be how "git bisect run" is used automatically in build 
systems, or how "git bisect" is used manually on GUI applications in your 
company, or how you use Avery Pennarun's "git-builder" (http://github.com/apenwarr/gitbuilder, it uses "git bisect" 
underneath), or what features you would want to see added, or what have been 
your experience with it, and so on.

Thanks in advance,
Christian.

PS: Because of this presentation I won't come to the GitTogether this year.
Anyway I wish people going there an happy GitTogether'10!   
