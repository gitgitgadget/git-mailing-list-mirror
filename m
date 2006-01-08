From: Luben Tuikov <ltuikov@yahoo.com>
Subject: How do I apply a single "change"
Date: Sat, 7 Jan 2006 16:31:14 -0800 (PST)
Message-ID: <20060108003114.4679.qmail@web31812.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sun Jan 08 01:31:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvOSr-00066c-S1
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 01:31:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030618AbWAHAbP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 19:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030501AbWAHAbP
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 19:31:15 -0500
Received: from web31812.mail.mud.yahoo.com ([68.142.207.75]:28284 "HELO
	web31812.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030618AbWAHAbO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2006 19:31:14 -0500
Received: (qmail 4681 invoked by uid 60001); 8 Jan 2006 00:31:14 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=KoBDV/YkHkoTugJJ25QqOGHDOlzwX8mzM3uRdgANsCZPZwDf7MpeVXAKeIwAsI2A0TwWYlijD/aQ8avurIkpGqZXjdqPIFQ1IBXG0RDwzLLoYh5Wkud4Br9DQjVxf0aveg4U+LMfMoiWPykSpcinTPR30Y7wFfe8O/uJREgKpJM=  ;
Received: from [68.221.7.47] by web31812.mail.mud.yahoo.com via HTTP; Sat, 07 Jan 2006 16:31:14 PST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14288>

Forgive me for the _incredibly stupid questions_,
but how do I apply a single "change", identified
by its SHA?  Either from one branch to the other or
remote?

I.e. I want to "integrate" only that change?

Alternatively, how do I apply the absolute output of
"git-format-patch".  I tried but whatever I tried with
complained that it couldn't find any email addressess.
(roll eyes here)

Thanks for the help,
   Luben
