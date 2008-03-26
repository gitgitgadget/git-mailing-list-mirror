From: Joe Fiorini <joe@faithfulgeek.org>
Subject: Undo git-rm without commit?
Date: Wed, 26 Mar 2008 02:17:18 -0400
Message-ID: <D6386C1A-92D3-4E11-8DE6-CC7553211A33@faithfulgeek.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 26 07:19:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeOzM-0000Kw-OO
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 07:19:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757180AbYCZGTH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 02:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757132AbYCZGTH
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 02:19:07 -0400
Received: from mail-out1.fuse.net ([216.68.8.175]:48255 "EHLO
	mail-out1.fuse.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756977AbYCZGTF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 02:19:05 -0400
X-CNFS-Analysis: v=1.0 c=1 a=CksHDyAnirWNPizMe1gA:9 a=41QTjXUPldh1hSUPNE4RRzYtLg0A:4 a=gi0PWCVxevcA:10
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
Authentication-Results: gwout1 smtp.user=jfiorini@zoomtown.com; auth=pass (LOGIN)
Received: from [66.93.11.195] ([66.93.11.195:65186] helo=[192.168.1.33])
	by mail-out1.fuse.net (ecelerity 2.1.1.22 r(17669)) with ESMTPA
	id 17/16-08390-F6AE9E74 for <git@vger.kernel.org>; Wed, 26 Mar 2008 02:17:19 -0400
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78260>

I hadn't done a git-commit yet, but I used git-rm thinking it would  
remove files that I had just added.  Instead, it deleted everything I  
had added from the disk.  Is there a way to undo this?  I'm doubtful,  
but would love to not have to rewrite what I was working on.

Thanks!
Joe
