From: Avo <avo@laborint.com>
Subject: Building statically linked binary
Date: Thu, 16 Apr 2009 10:46:53 +0000 (UTC)
Message-ID: <loom.20090416T104327-682@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 13:12:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuPVw-0001oZ-2L
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 13:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753689AbZDPLKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 07:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752902AbZDPLKH
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 07:10:07 -0400
Received: from main.gmane.org ([80.91.229.2]:57800 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752618AbZDPLKG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 07:10:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LuPTm-0002Vw-GV
	for git@vger.kernel.org; Thu, 16 Apr 2009 11:10:02 +0000
Received: from hydra.interspace.ee ([hydra.interspace.ee])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Apr 2009 11:10:02 +0000
Received: from avo by hydra.interspace.ee with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Apr 2009 11:10:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.235.100.10 (Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.0.8) Gecko/2009032609 Firefox/3.0.8 (.NET CLR 3.5.30729))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116694>

Has anybody been able to build stand-alone git binary (statically linked)?
I need it for a virtual hosting, not supporting git by default.


If yes, please give me some hints.
Or better, step by step instructions what to do.

Hope somebody can help,
Avo
