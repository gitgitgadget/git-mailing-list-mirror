From: Roger Garvin <yoyodyn@gmail.com>
Subject: Adding History
Date: Thu, 19 Mar 2009 17:38:33 +0000 (UTC)
Message-ID: <loom.20090319T173541-173@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 19 18:40:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkME5-0000tE-GN
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 18:40:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239AbZCSRis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 13:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754067AbZCSRis
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 13:38:48 -0400
Received: from main.gmane.org ([80.91.229.2]:46097 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753029AbZCSRir (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 13:38:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LkMCb-0004Vx-Et
	for git@vger.kernel.org; Thu, 19 Mar 2009 17:38:46 +0000
Received: from smtp.qmsionline.com ([65.163.36.91])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 17:38:45 +0000
Received: from yoyodyn by smtp.qmsionline.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 17:38:45 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 65.163.36.90 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.7) Gecko/2009021910 Firefox/3.0.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113798>

Is there a way to add history to a repository?
We have just started using git, where before we had nothing but backup
directories all over the place.  We created the git repository using our
existing source directory.  Is there a way to now go and add some of the backup
source directories to the history?  Or would this break all the SHA1 of the
current objects?  I am not sure it would be worth it at this point.  But we are
still pretty early in our use of git so now would be the easiest time.  

Roger
