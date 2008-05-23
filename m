From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: git-rerere: Usage question
Date: Fri, 23 May 2008 16:27:54 +0200
Message-ID: <4836D46A.7070807@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 23 16:29:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzYGr-00034F-Q9
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 16:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757779AbYEWO16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 10:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755730AbYEWO16
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 10:27:58 -0400
Received: from smtprelay10.ispgateway.de ([80.67.29.24]:57457 "EHLO
	smtprelay10.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755492AbYEWO15 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 10:27:57 -0400
Received: from [84.176.93.221] (helo=[192.168.2.100])
	by smtprelay10.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1JzYFP-0001D8-9C
	for git@vger.kernel.org; Fri, 23 May 2008 16:27:55 +0200
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82714>

I recently read the docs for 'git-rerere'. Seems a cool feature.
But I'm not quite sure whether I understood it right. I think
I understood what it does but I didn't understand when to call
it.

Is it true that it's not neccessary to issue that command manually
when I configured "rerere.enabled true"? The docs say that I *can*
call it but it also says that git-merge and git-rebase call it
automatically whenever needed.

Thus it seems to be one of the plumbing tools to me, which
I only call in case of emergency. Am I right?

    Dirk
