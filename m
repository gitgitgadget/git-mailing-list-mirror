From: Peter Pientka <p.pientka@gmail.com>
Subject: Reverting/cheout files with old modification date
Date: Thu, 9 Jun 2011 07:09:47 +0000 (UTC)
Message-ID: <loom.20110609T090306-164@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 09:15:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUZST-0000Fy-AM
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 09:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756007Ab1FIHPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 03:15:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:38483 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754765Ab1FIHPH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 03:15:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QUZSL-0000Dl-Lm
	for git@vger.kernel.org; Thu, 09 Jun 2011 09:15:05 +0200
Received: from ip-217-153-83-201.bezprzewodowy.net ([217.153.83.201])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 09:15:05 +0200
Received: from p.pientka by ip-217-153-83-201.bezprzewodowy.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 09:15:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 217.153.83.201 (Mozilla/5.0 (Windows NT 6.1; rv:2.0.1) Gecko/20100101 Firefox/4.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175498>

Hi,
Is any way to revert/checkout some files from reposotory with old modification
date(file parameter). Now, while I revert/checkout some file, modification date
of file is set to current date and time.

Currently I`m using git version 1.7.4.msysgit.0 

Thanks for reply
