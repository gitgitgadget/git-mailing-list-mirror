From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: can we allow -t abbreviation for --track in 'git branch'
Date: Sat, 9 May 2009 08:50:07 +0000 (UTC)
Message-ID: <slrnh0agtv.4rv.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 09 10:50:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2iGP-0007ET-Ma
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 10:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604AbZEIIuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 04:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752495AbZEIIuW
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 04:50:22 -0400
Received: from main.gmane.org ([80.91.229.2]:45689 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752866AbZEIIuU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 04:50:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M2iGC-0001si-LU
	for git@vger.kernel.org; Sat, 09 May 2009 08:50:20 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 09 May 2009 08:50:20 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 09 May 2009 08:50:20 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118654>

Hello,

Would it make sense to teach "git branch" the short option
"-t" the same way that "git checkout" knows it, (ie., as an
abbreviation for "--track")?

I use both frequently, and often forget that in "git branch"
the short option does not work.

If people think it's OK I'll submit a patch (code and doc).

Regards,

Sitaram
