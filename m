From: Bastian Flinspach <bastian.flinspach@gerina.com>
Subject: Problems with EGit
Date: Wed, 03 Dec 2008 12:08:11 +0100
Message-ID: <4936689B.1030903@gerina.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 03 12:14:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7pgs-00076N-PH
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 12:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbYLCLNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 06:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbYLCLNZ
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 06:13:25 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:64027 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbYLCLNY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 06:13:24 -0500
Received: from [192.168.0.18] (p54AE41B0.dip.t-dialin.net [84.174.65.176])
	by mrelayeu.kundenserver.de (node=mrelayeu2) with ESMTP (Nemesis)
	id 0MKwtQ-1L7pab1pq8-0004Dq; Wed, 03 Dec 2008 12:08:18 +0100
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
X-Provags-ID: V01U2FsdGVkX18AtFqmKwQ5suz4cL6gqvnttvu2AWksZ22WfAT
 TDIW5YQXH6BwEbdOvqpm3YsV4cmtbM0MBU8rXYGypvNBCR0epJ
 O9dVMK8Ni8VQluQUX9YwA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102240>

Hi everyone.

I am a newbie in regards to Linux and especially git. I worked with SVN 
for some time, but mainly as a client.
Never the less, i wanted to set up some form of code repository for my 
workplace and git seems to be a good fit.

So i installed git on our local development server here in our office. I 
am the only developer at the time, so i can do as i please. :-)
The Server is a debian machine, essentially only running a web server (I 
develop web apps), which webroot directory is also shared via samba with 
the otherwise all windows network. The first Version of git i got from 
the apt was an old one and after some struggling, i managed to update it 
to  1.6.0.3.g9f8f13. I also created my repository and installed EGit in 
my eclipse 3.4.
In Eclipse, i linked to the samba Folder containing the code.

When i try to commit changes via the command line, everything works fine 
(well, except for me not being able to use my keyboard right for 
entering the commit message, but thats probably not important because i 
want to use EGit anyways).
Eclipse recognizes the repository and also displays changes i make. When 
trying to commit, however, i get a permission denied error.

So, this is basically where i am stuck. What can be the problem and what 
would be a solution? I assume, that i might have something to do with 
Linux users and privileges, but i am not yet versed enough to identify 
the problem on my own.

Please keep in mind, that i am a complete beginner with these topics 
when answering.

I would appreciate your help.

best regards

Bastian Flinspach
