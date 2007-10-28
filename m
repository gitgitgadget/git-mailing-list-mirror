From: James <jtp@nc.rr.com>
Subject: tags disappear
Date: Sun, 28 Oct 2007 00:01:36 -0400
Message-ID: <C7372F7E-F29E-4E40-AE96-7AC8CB0EE0CE@nc.rr.com>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 05:25:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlziB-0005CF-Kn
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 05:25:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbXJ1EZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 00:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbXJ1EZG
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 00:25:06 -0400
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:42497 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbXJ1EZF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 00:25:05 -0400
X-Greylist: delayed 1405 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Oct 2007 00:25:05 EDT
Received: from [192.168.1.252] (really [75.182.108.180])
          by cdptpa-omta03.mail.rr.com with ESMTP
          id <20071028040137.DMAG3242.cdptpa-omta03.mail.rr.com@[192.168.1.252]>
          for <git@vger.kernel.org>; Sun, 28 Oct 2007 04:01:37 +0000
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62520>

Hi all,

Sorry for the dumb question.  Hoping someone can lead me in the right  
direction.

I use git in a pretty basic setup.  One branch, I'm the only user,  
etc.  When I set up a tag (with a command like "git tag v1.1.6"), and  
then push the changes to the server, the tag doesn't remain when I  
clone the tree somewhere else.

Can anyone explain why, and possibly how to keep tags on a push/clone?

Thanks!
.james
