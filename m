From: "Joel C. Salomon" <joelcsalomon@gmail.com>
Subject: Secondary --exec-path?
Date: Fri, 23 Jul 2010 08:56:22 -0400
Message-ID: <i2c3hn$odi$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 23 16:20:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcJ6k-0008Jj-IT
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 16:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755624Ab0GWOUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 10:20:07 -0400
Received: from lo.gmane.org ([80.91.229.12]:55821 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754304Ab0GWOUF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 10:20:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OcJ6a-0008Db-H9
	for git@vger.kernel.org; Fri, 23 Jul 2010 16:20:04 +0200
Received: from pool-173-52-250-12.nycmny.east.verizon.net ([173.52.250.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 16:20:04 +0200
Received: from joelcsalomon by pool-173-52-250-12.nycmny.east.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 16:20:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: pool-173-52-250-12.nycmny.east.verizon.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.10) Gecko/20100527 Lightning/1.0b1 Thunderbird/3.0.5
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151533>

I just downloaded git-subtree, and the installation instructions have me
copying the executable file to `git --exec-path`, i.e., to
/usr/lib/git-core.

I'm looking through the documentation for a possible second location for
these scripts, perhaps somewhere in /usr/local, or in /home/me -- is
there such a path?  I'd rather not step on my distro's toes if I can
help it.

--Joel Salomon
