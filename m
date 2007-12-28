From: Wincent Colaiuta <win@wincent.com>
Subject: Hunk splitting in "git gui"
Date: Fri, 28 Dec 2007 13:26:26 +0100
Message-ID: <3F129AD6-EA27-4584-B5C8-2866964AB93E@wincent.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 28 13:27:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8EIl-0006Wx-MU
	for gcvg-git-2@gmane.org; Fri, 28 Dec 2007 13:27:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574AbXL1M0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2007 07:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752242AbXL1M0a
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Dec 2007 07:26:30 -0500
Received: from wincent.com ([72.3.236.74]:34851 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752170AbXL1M03 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2007 07:26:29 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBSCQROc007117
	for <git@vger.kernel.org>; Fri, 28 Dec 2007 06:26:28 -0600
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69281>

I'd use "git gui" a lot more if I could split hunks in it (like you  
can in "git add --interactive").

Problem is, I have zero knowledge of Tcl/Tk. Can someone who has  
knowledge of this offer an opinion on whether this would be a feasible  
project for a beginner? I'm willing to have a shot at it, but before I  
embark on this I'd like to know if others consider it useful and doable!

Cheers,
Wincent
