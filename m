From: Mike <fromlists@talkingspider.com>
Subject: What's a "work tree"?
Date: Thu, 24 Jan 2008 14:09:33 -0500
Message-ID: <4798E26D.3040707@talkingspider.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 20:10:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI7Sg-0002f3-Kr
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 20:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312AbYAXTJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 14:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752267AbYAXTJg
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 14:09:36 -0500
Received: from relay02.pair.com ([209.68.5.16]:3621 "HELO relay02.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752055AbYAXTJf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 14:09:35 -0500
Received: (qmail 95532 invoked from network); 24 Jan 2008 19:09:34 -0000
Received: from unknown (HELO ?192.168.1.100?) (unknown)
  by unknown with SMTP; 24 Jan 2008 19:09:34 -0000
X-pair-Authenticated: 72.225.213.70
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71650>


I'm trying to figure out what a "work tree" is.  as in --work-tree. 
This is a new command right, the tutorials I've read don't have it. The 
man page has the syntax but I don't know what it's for.

$ cd /www/mysitedocroot
$ git --git-dir /gitdir/mysitegit/ add .
fatal: add must be run in a work tree

thanks
