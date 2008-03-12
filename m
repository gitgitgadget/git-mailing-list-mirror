From: Wincent Colaiuta <win@wincent.com>
Subject: Reminder: broken "next" and "prev" links in gitweb
Date: Wed, 12 Mar 2008 12:56:45 +0100
Message-ID: <3872895A-64DA-4DED-B359-DC7FC9A968CF@wincent.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 12 13:00:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZPcX-0002xh-KW
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 12:59:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620AbYCLL5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 07:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753605AbYCLL5p
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 07:57:45 -0400
Received: from wincent.com ([72.3.236.74]:36231 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753580AbYCLL5o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 07:57:44 -0400
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m2CBvSnE016604;
	Wed, 12 Mar 2008 06:57:29 -0500
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76945>

Hi Junio,

Any chance of getting Jakub's fix for the broken "next" and "prev"  
links in gitweb into maint?

He actually posted a couple of fixes but the post containing the  
minimal fix and the appropriate commit message, which I've tested and  
confirmed, is this one:

   <200802152216.42533.jnareb@gmail.com>

I wasn't watching "maint" prior to 1.5.4.4 closely enough to realize  
that the fix wasn't in there.

Cheers,
Wincent
