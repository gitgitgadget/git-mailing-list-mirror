From: Mark Haney <markh@abemblem.com>
Subject: Help with repo management.
Date: Thu, 19 Apr 2012 10:35:00 -0400
Message-ID: <4F902294.10302@abemblem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 19 17:06:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKswR-0007IK-1z
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 17:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737Ab2DSPGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 11:06:33 -0400
Received: from mail.abemblem.com ([68.115.173.66]:64814 "EHLO marius.homelinux"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751839Ab2DSPGd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 11:06:33 -0400
X-Greylist: delayed 1891 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Apr 2012 11:06:33 EDT
Received: from marius.homelinux (localhost.localdomain [127.0.0.1])
	by marius.homelinux (8.14.5/8.14.5) with ESMTP id q3JEZ01B004603
	for <git@vger.kernel.org>; Thu, 19 Apr 2012 10:35:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195949>

I'm new to git and repo management and I have an issue that I can't 
quite figure out.  Here's my problem.

I have a server (SERVER) with a repo on it.  It has all my code and 
documentation.  I pulled that repo onto my workstation for a local copy 
so I could work at home or wherever with needing server access. My 
problem is I can /pull/ from the repo on SERVER, but I can't /push/ any 
local changes back to the server.  I get an error message about master 
being checked out.

I know a little about bare repos, but my understanding is that the bare 
repo doesn't actually have the actual files in it, just the changes, 
which is not what I want.  I would like to have the copy on SERVER to 
work from if I want, and also be able to pull/push changes from my local 
copy as well.  That way I have 2 copies of the data handy (not to 
mention the disc backups.

I'm fairly sure this can be setup, but I just don't know enough to 
figure it out.  Can someone point me in the right direction?

-- 

Mark Haney
Software Developer/Consultant
AB Emblem
markh@abemblem.com
Linux marius.homelinux 3.3.1-5.fc16.x86_64 GNU/Linux
