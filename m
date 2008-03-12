From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: git submodule status not describing modules
Date: Wed, 12 Mar 2008 15:21:30 +0000 (UTC)
Message-ID: <loom.20080312T151743-186@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 16:23:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZSn2-0006c4-IM
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 16:22:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbYCLPWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 11:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbYCLPWG
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 11:22:06 -0400
Received: from main.gmane.org ([80.91.229.2]:45462 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059AbYCLPWF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 11:22:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JZSlt-0004sQ-QH
	for git@vger.kernel.org; Wed, 12 Mar 2008 15:22:03 +0000
Received: from host233-62-dynamic.6-87-r.retail.telecomitalia.it ([87.6.62.233])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Mar 2008 15:21:37 +0000
Received: from sergio.callegari by host233-62-dynamic.6-87-r.retail.telecomitalia.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Mar 2008 15:21:37 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.6.62.233 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.12) Gecko/20080207 Ubuntu/7.10 (gutsy) Firefox/2.0.0.12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76955>

Hi,

in git 1.5.4.4, the git submodules manpage says that the status subcommand
should:


Show the status of the submodules. This will print the SHA-1 of the currently
checked out commit for each submodule, along with the submodule path and the
output of git-describe(1) for the SHA-1.

However, I cannot get the git-describe output.
If I remember properly, in previous versions of git, this was shown correctly.

Sergio
 
