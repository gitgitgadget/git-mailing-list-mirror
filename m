From: marcreddist@aim.com
Subject: Really remove a file ?
Date: Thu, 09 Oct 2008 14:12:28 -0400
Message-ID: <8CAF851B91FEF07-660-20E9@webmail-da15.sysops.aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 20:22:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko09M-0003NK-A6
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 20:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754251AbYJISUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 14:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754301AbYJISUx
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 14:20:53 -0400
Received: from imo-m23.mx.aol.com ([64.12.137.4]:42151 "EHLO
	imo-m23.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793AbYJISUx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 14:20:53 -0400
X-Greylist: delayed 482 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Oct 2008 14:20:53 EDT
Received: from marcreddist@aim.com
	by imo-m23.mx.aol.com  (mail_out_v39.1.) id x.d41.27c40f55 (34921)
	 for <git@vger.kernel.org>; Thu, 9 Oct 2008 14:12:42 -0400 (EDT)
Received: from smtprly-da03.mx.aol.com (smtprly-da03.mx.aol.com [205.188.249.146]) by cia-da03.mx.aol.com (v121_r3.13) with ESMTP id MAILCIADA036-886948ee499a7; Thu, 09 Oct 2008 14:12:42 -0400
Received: from webmail-da15 (webmail-da15.webmail.aol.com [205.188.212.210]) by smtprly-da03.mx.aol.com (v121_r3.13) with ESMTP id MAILSMTPRLYDA032-5bbb48ee498b117; Thu, 09 Oct 2008 14:12:27 -0400
X-MB-Message-Source: WebUI
X-AOL-IP: 62.23.145.195
X-MB-Message-Type: User
X-Mailer: AIM WebMail 39155-STANDARD
Received: from 62.23.145.195 by webmail-da15.sysops.aol.com (205.188.212.210) with HTTP (WebMailUI); Thu, 09 Oct 2008 14:12:28 -0400
X-Spam-Flag: NO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97872>

Hi,





I'm a new git user for some weeks or so and well i think git is 
awesome. I didn't read all the online docs and mans yet, but i'm 
already really impressed by it's power. Thanks everyone for this 
helpful tool.



Right now i think i need some help. I started to work for a project, 
and everything went fine. But I noticed someone placed a huge data file 
in the repository. This file shouldn't have been here at the first 
place. So I deleted it with git-rm. But that wasn't clever because now, 
"git log -p" or "git log -S'something'" are really really slow. Also 
diffs are huge and lots of command results are hard to read.



So is there a way to really remove a file in the git repository so that 
it never existed (I mean not having the diff in the logs and the data 
stored somewhere in the .git directory) ? Or if it's not the was git is 
supposed to be used, is there a way to hide the diff (even from 
git-log) or something ?





Thank you again,

--

Marc R.
