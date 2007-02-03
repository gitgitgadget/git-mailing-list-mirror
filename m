From: Mike Coleman <tutufan@gmail.com>
Subject: Re: [PATCH] fix use of sometimes uninitialized variable 'msg'
Date: Sat, 3 Feb 2007 17:05:30 +0000 (UTC)
Message-ID: <loom.20070203T180123-680@post.gmane.org>
References: <11705213633209-git-send-email-tutufan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 03 18:10:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDOP2-0006LJ-8M
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 18:10:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992435AbXBCRKK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 12:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992439AbXBCRKK
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 12:10:10 -0500
Received: from main.gmane.org ([80.91.229.2]:47084 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992435AbXBCRKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 12:10:09 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HDOOo-0004DA-Ce
	for git@vger.kernel.org; Sat, 03 Feb 2007 18:10:04 +0100
Received: from adsl-69-154-213-42.dsl.ksc2mo.swbell.net ([69.154.213.42])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Feb 2007 18:10:02 +0100
Received: from tutufan by adsl-69-154-213-42.dsl.ksc2mo.swbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Feb 2007 18:10:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 69.154.213.42 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.9) Gecko/20070102 Ubuntu/dapper-security Firefox/1.5.0.9)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38578>

Michael Coleman <tutufan <at> gmail.com> writes:
> 
> 
> 

Oops--I didn't realize a header email was going to be sent out, too.  Not quite
sure what happened there.  When I tested it before, I thought only one email got
sent.

Mike
