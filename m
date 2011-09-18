From: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
Subject: git subtree merging with a SVN remote?
Date: Sun, 18 Sep 2011 16:44:33 +0200
Message-ID: <j550cl$218$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 16:49:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5IgF-0004Ps-Sy
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 16:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753785Ab1IROtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 10:49:11 -0400
Received: from lo.gmane.org ([80.91.229.12]:48178 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753502Ab1IROtK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 10:49:10 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R5Ig9-0004Nj-0D
	for git@vger.kernel.org; Sun, 18 Sep 2011 16:49:09 +0200
Received: from p4fd19684.dip0.t-ipconnect.de ([79.209.150.132])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 16:49:08 +0200
Received: from Manuel.Spam by p4fd19684.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 16:49:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p4fd19684.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:6.0.2) Gecko/20110902 Firefox/6.0.2 SeaMonkey/2.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181612>

Hello,

I want to use "subtree merging" to get stuff from an external SVN repo into my 
project.

Is it possible to do this directly using the external SVN server or should I set 
up a GIT mirror of this SVN repo?

Is this "subtree merging" a pure local thing or do I push some information about 
this to the central GIT server?

Yours

Manuel
