From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (amend)] cvsserver: Add asciidoc documentation for new database backend configuration
Date: Fri, 13 Apr 2007 02:13:45 +0200
Organization: At home
Message-ID: <evmhot$p0l$2@sea.gmane.org>
References: <7v64879rwd.fsf@assigned-by-dhcp.cox.net> <11763890161953-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 02:22:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc9YF-0007bB-Dp
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 02:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbXDMAWA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 20:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753933AbXDMAWA
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 20:22:00 -0400
Received: from main.gmane.org ([80.91.229.2]:57108 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750844AbXDMAWA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 20:22:00 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Hc9RO-0004mG-Ri
	for git@vger.kernel.org; Fri, 13 Apr 2007 02:15:02 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Apr 2007 02:15:02 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Apr 2007 02:15:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44372>

[Cc: Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org]

Frank Lichtenheld wrote:

> Documents the new configuration variables and the variable
> substitution mechanism.
> 
> Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
> ---
>  Documentation/git-cvsserver.txt |   93 +++++++++++++++++++++++++++++++++++++--
>  1 files changed, 89 insertions(+), 4 deletions(-)

Could you also update Documentation/config.txt? TIA.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
