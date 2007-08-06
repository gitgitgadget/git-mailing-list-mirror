From: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
Subject: typo in http://www.kernel.org/pub/software/scm/git/docs/git-checkout.html
Date: Mon, 06 Aug 2007 16:05:02 +0200
Message-ID: <46B72A8E.3040602@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 06 16:06:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1II3DU-0006bD-R2
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 16:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933325AbXHFOFI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 10:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765238AbXHFOFH
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 10:05:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:50029 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1765832AbXHFOFF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 10:05:05 -0400
Received: (qmail invoked by alias); 06 Aug 2007 14:05:03 -0000
Received: from c199054.adsl.hansenet.de (EHLO [213.39.199.54]) [213.39.199.54]
  by mail.gmx.net (mp032) with SMTP; 06 Aug 2007 16:05:03 +0200
X-Authenticated: #5108953
X-Provags-ID: V01U2FsdGVkX1+ZUeRI+kKZcWTvUY/Tv2Hhbdi2do3KLS5HgKLopf
	m9gfyZbXNziuMH
User-Agent: Thunderbird 1.5.0.12 (Windows/20070509)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55149>

Hello,

shouldn't " at the tip of one of your branches" better written as " at 
the top of one of your branches".

BTW one question: I run a simple test unit (only build tests) against 
the latest git tree, which is updated with "git pull" once a day.

If I want to make some tests with a previous kernel version - say 
v2.6.20 and switch then back to HEAD to continue with my common test 
suite, would the following be ok : ?

$> git checkout v2.6.20
$> <do something useful with it>
$> git reset

Thanks for an answer

--
Toralf
