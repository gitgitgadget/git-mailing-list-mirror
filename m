From: Petr Baudis <pasky@suse.cz>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 2 Nov 2007 03:23:35 +0100
Message-ID: <20071102022335.GU18279@machine.or.cz>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org> <7vmytycykt.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.999.0711011129460.3342@woody.linux-foundation.org> <fgdphj$6ga$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 03:23:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InmCN-0005Cg-Hv
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 03:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753707AbXKBCXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 22:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753530AbXKBCXg
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 22:23:36 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41268 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752771AbXKBCXg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 22:23:36 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 4178A5A4A9; Fri,  2 Nov 2007 03:23:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <fgdphj$6ga$1@ger.gmane.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63050>

On Fri, Nov 02, 2007 at 01:04:03AM +0100, Jakub Narebski wrote:
> Is 'getopts' bash-ism, or is it in POSIX?

	http://www.opengroup.org/onlinepubs/009695399/utilities/getopts.html

(Also, most modern distributions have manpage section 1p (3p, ...) with
the same contents, so you can check for this stuff pretty easily.)

-- 
				Petr "Pasky" Baudis
We don't know who it was that discovered water, but we're pretty sure
that it wasn't a fish.		-- Marshall McLuhan
