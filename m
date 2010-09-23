From: Thomas Hochstein <thh@inter.net>
Subject: Re: Newbie question
Date: Thu, 23 Sep 2010 08:29:31 +0200
Message-ID: <gcvg.1009230829.2937@thorondor.akallabeth.de>
References: <20100923045930.16223.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 23 23:10:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oyt3g-0008EK-Tx
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 23:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756117Ab0IWVKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 17:10:18 -0400
Received: from lo.gmane.org ([80.91.229.12]:56947 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755635Ab0IWVKR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 17:10:17 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Oyt3U-00088N-DL
	for git@vger.kernel.org; Thu, 23 Sep 2010 23:10:12 +0200
Received: from p5b2e9fcf.dip.t-dialin.net ([91.46.159.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 23:10:12 +0200
Received: from thh by p5b2e9fcf.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 23:10:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p5b2e9fcf.dip.t-dialin.net
User-Agent: ForteAgent/2.0-32.652  Hamster/2.1.0.11
X-Uptime: 6 day(s), 12 hour(s), 0 minute(s), 5 second(s) [thorondor | 61401]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156912>

George Spelvin wrote:

> git config core.bare true
[...]
> - unset the core.bare flag, which disables certain commands that
>   make no sense on a bare repository, and

Shouldn't that be
| git config core.bare false
then?

Regards,
-thh
