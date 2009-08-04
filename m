From: "lists@mgreg.com" <lists@mgreg.com>
Subject: Merging to and from non-current branches.
Date: Tue, 4 Aug 2009 19:21:46 -0400
Message-ID: <D5200130-C7D7-4010-BF62-3A3374F2E3B0@mgreg.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 01:28:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYTQr-0006Cx-6V
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 01:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933591AbZHDX23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 19:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933581AbZHDX23
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 19:28:29 -0400
Received: from smtpauth22.prod.mesa1.secureserver.net ([64.202.165.44]:59335
	"HELO smtpauth22.prod.mesa1.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933575AbZHDX22 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2009 19:28:28 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Aug 2009 19:28:28 EDT
Received: (qmail 24121 invoked from network); 4 Aug 2009 23:21:47 -0000
Received: from unknown (76.177.133.127)
  by smtpauth22.prod.mesa1.secureserver.net (64.202.165.44) with ESMTP; 04 Aug 2009 23:21:47 -0000
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124833>

Hi All,

I've been reading up on some of the GIT commands and I'm not sure if  
what I want/need exists.  Basically I want to merge all changes from  
one branch to another, regardless of whether I'm in either of those  
branches.  At the very least I would like to merge an existing  
"development" branch with the "master" branch without needing to first  
check out master.  I've seen rebase, but I'm not absolutely sure what  
that's doing.  Thoughts?

Best,
Michael
