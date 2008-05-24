From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Which msysGit version corresponds to which official Git version?
Date: Sat, 24 May 2008 14:45:57 +0200
Message-ID: <48380E05.9020103@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 24 14:47:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzt9d-0000ZB-Tr
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 14:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959AbYEXMqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 08:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbYEXMqC
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 08:46:02 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:56504 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900AbYEXMqA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 08:46:00 -0400
Received: from [84.176.123.174] (helo=[192.168.2.100])
	by smtprelay02.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1Jzt8I-0003if-Tr
	for git@vger.kernel.org; Sat, 24 May 2008 14:45:59 +0200
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82811>

I'm using msysGit. Upon shell startup it says
"Welcome to Git (version 1.5.5-preview20080413)".
That's the latest msysGit version.

git --version says "git version 1.5.5.1015.g9d258"

I'd like to know which official Git version (as cloned
from git://git.kernel.org/pub/scm/git/git.git) corresponds
to my msysGit version.

git checkout 9d258 didn't work.

Any hints? Is there a Website or another mailing
list for msysGit?

    Dirk
