From: Petr Baudis <pasky@suse.cz>
Subject: Re: git submodules and commit
Date: Wed, 16 Jul 2008 16:17:38 +0200
Message-ID: <20080716141738.GN32184@machine.or.cz>
References: <320075ff0807160331j30e8f832m4de3e3bbe9c26801@mail.gmail.com> <320075ff0807160332k5e49c256tb4191de628ecf41c@mail.gmail.com> <487DD1C7.3070701@viscovery.net> <320075ff0807160402s7429291ela288b42d99c1ec53@mail.gmail.com> <487DDCFC.9020007@viscovery.net> <320075ff0807160548qae5d702jafe3df63363c512c@mail.gmail.com> <487DF9BB.10107@viscovery.net> <320075ff0807160703v3f16ff5bue722b760ad66488e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 16:18:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ7q4-0001YB-L5
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 16:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756782AbYGPORk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 10:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756768AbYGPORk
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 10:17:40 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38870 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756713AbYGPORk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 10:17:40 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 5F822393A2E4; Wed, 16 Jul 2008 16:17:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <320075ff0807160703v3f16ff5bue722b760ad66488e@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88681>

On Wed, Jul 16, 2008 at 03:03:41PM +0100, Nigel Magnay wrote:
> - All the technical capability is there, it's just the porcelain
> that's causing the friction.
> then
>  would this not seem to be an area that could be improved? Even if it
> were an optional mode of working?

So, were there already any patches posted to add such a functionality
that were rejected? If not, apparently noone cared _enough_, yet. ;-)
You may be the first!

I don't know if there are any _present_ "free developers" willing to
pick up this task now.  For many (most?) Git developers, submodules
simply aren't a priority.  For me, they actually currently are, but I
probably won't want to use them in your way either (even though I can
agree that your sentiments are valid), so I will personally invest my
time in doing other things than figuring out the precise semantics
these operations should have etc.

-- 
				Petr "Pasky" Baudis
GNU, n. An animal of South Africa, which in its domesticated state
resembles a horse, a buffalo and a stag. In its wild condition it is
something like a thunderbolt, an earthquake and a cyclone. -- A. Pierce
