From: Jeremy English <jhe@jeremyenglish.org>
Subject: git ident
Date: Sun, 09 Apr 2006 13:48:49 -0500
Message-ID: <44395711.7000902@jeremyenglish.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Apr 09 20:48:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSexy-0005tA-EY
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 20:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWDISsw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 14:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWDISsw
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 14:48:52 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:1183 "EHLO
	ms-smtp-02.texas.rr.com") by vger.kernel.org with ESMTP
	id S1750818AbWDISsv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Apr 2006 14:48:51 -0400
Received: from [192.168.15.100] (cpe-24-174-239-6.gt.res.rr.com [24.174.239.6])
	by ms-smtp-02.texas.rr.com (8.13.4/8.13.4) with ESMTP id k39ImluP021601
	for <git@vger.kernel.org>; Sun, 9 Apr 2006 13:48:48 -0500 (CDT)
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18558>

I keep a local project in a git archive.  After the last upgrade I get a 
ident error when trying to commit.  It works after I set the environment 
variables.  What I don't like is that the error comes up after I have 
typed in my comment, then my comment is lost, that's frustrating.  The 
other thing is I don't care if the commit is coming from a valid person, 
why require this?
