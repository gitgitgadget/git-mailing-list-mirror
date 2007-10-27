From: Sergei Organov <osv@javad.com>
Subject: Remove reference to cogito from core-tutorial.txt?
Date: Sat, 27 Oct 2007 19:10:35 +0400
Message-ID: <ffvkdb$5f0$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 27 17:11:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlnJX-0001b8-BJ
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 17:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbXJ0PKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 11:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbXJ0PKv
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 11:10:51 -0400
Received: from main.gmane.org ([80.91.229.2]:60162 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543AbXJ0PKu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 11:10:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IlnJB-000824-KN
	for git@vger.kernel.org; Sat, 27 Oct 2007 15:10:41 +0000
Received: from 87.236.81.130 ([87.236.81.130])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 27 Oct 2007 15:10:41 +0000
Received: from osv by 87.236.81.130 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 27 Oct 2007 15:10:41 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 87.236.81.130
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62495>

Hello,

In Documentation/core-tutorial.txt at line 554 there is a note that
begins with

  "Most likely, you are not directly using the core git Plumbing
   commands, but using Porcelain like Cogito..."

As stated on <http://git.or.cz/index.html>, "Cogito was a popular
version control system on top of Git, aiming at seamless user interface
and ease of use. It provided much better user interface in the past days
of Git but by now it is mostly obsolete and currently unmaintained."

I think it's not a good idea to have this in the tutorial. Should this
entire note be removed, or rewritten using git porcelain commands? If
the former, I can make a patch, if the latter, I'm afraid I'm not yet
comfortable enough with git to do it right.

-- 
Sergei.
