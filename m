From: rajmv <rene.veerman.netherlands@gmail.com>
Subject: Noob asking for repo setup advice
Date: Wed, 2 May 2012 04:46:45 -0700 (PDT)
Message-ID: <1335959205015-7519875.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 13:46:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPY1C-0007pc-FB
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 13:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753898Ab2EBLqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 07:46:46 -0400
Received: from sam.nabble.com ([216.139.236.26]:60398 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752226Ab2EBLqp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 07:46:45 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <rene.veerman.netherlands@gmail.com>)
	id 1SPY17-0001cv-0o
	for git@vger.kernel.org; Wed, 02 May 2012 04:46:45 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196801>

Hi.

The last time I used version control was in the 90's with microsoft's visual
source control program.

So I can use some advice about how to use git best.

I still use windows (7) for my development, and I've managed to get msysgit
up and running on this system.

I've got a ".../htdocs" that I use for my web development, with underneath
that several "sites/somedomainname.com" that hold common and custom code.
The common code is always in ".../somedomainname.com/code", the custom is
everything else (excluding cache directories I suppose).

I'd like to be extra sure that my repo stays safe.
So I'd like to keep a triple copy of my repo, 2x on seperate harddisks that
are crypted with truecrypt.org, and once on a USB drive that's also
truecrypted. Truecrypt interfaces as an ordinary drive letter and
filesystem.

I'd really appreciate a short description of how to setup repositories for
the common code and the custom codes per domain, and how to properly use git
while developing on one domain's copy of my common code, then pushing those
changes to other domain folders to test them against that domain's custom
code.
Thanks in advance..


--
View this message in context: http://git.661346.n2.nabble.com/Noob-asking-for-repo-setup-advice-tp7519875.html
Sent from the git mailing list archive at Nabble.com.
