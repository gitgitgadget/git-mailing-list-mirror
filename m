From: walt <wa1ter@myrealbox.com>
Subject: Re: Start deprecating "git-command" in favor of "git command"
Date: Sat, 30 Jun 2007 13:34:20 -0700
Organization: none
Message-ID: <f66eog$qe$1@sea.gmane.org>
References: <alpine.LFD.0.98.0706301135300.1172@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 30 22:34:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4jeR-0000WX-BX
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 22:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395AbXF3Ueh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 16:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752417AbXF3Ueh
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 16:34:37 -0400
Received: from main.gmane.org ([80.91.229.2]:35857 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386AbXF3Ueg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 16:34:36 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I4jeI-0007RH-2Q
	for git@vger.kernel.org; Sat, 30 Jun 2007 22:34:30 +0200
Received: from adsl-69-234-198-180.dsl.irvnca.pacbell.net ([69.234.198.180])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jun 2007 22:34:30 +0200
Received: from wa1ter by adsl-69-234-198-180.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jun 2007 22:34:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-198-180.dsl.irvnca.pacbell.net
User-Agent: Thunderbird 3.0a1pre (X11/20070630)
In-Reply-To: <alpine.LFD.0.98.0706301135300.1172@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51256>

Linus Torvalds wrote:
> I realize that a lot of people use the "git-xyzzy" format, and we have 
> various historical reasons for it...

One of the historical reasons was to allow users of gnu interactive
tools to delete the git wrapper script, as outlined in 'INSTALL'.

Seems unlikely that 'git' could still be deleted if your proposed
changes are implemented.  I recall that a few people cared a lot
about this, and not too long ago.
