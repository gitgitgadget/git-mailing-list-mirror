From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH v2] mergetool: support setting path to tool as config
	var mergetool.<tool>.path
Date: Sun, 14 Oct 2007 09:02:40 -0400
Message-ID: <20071014130240.GD17368@thunk.org>
References: <11919632613176-git-send-email-prohaska@zib.de> <06B63221-7F8E-42FF-959F-D83FBABA6790@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Oct 14 15:02:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih37O-0006eN-DG
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 15:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756127AbXJNNCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 09:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755044AbXJNNCo
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 09:02:44 -0400
Received: from thunk.org ([69.25.196.29]:37194 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754190AbXJNNCo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 09:02:44 -0400
Received: from root (helo=tinytim.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1Ih3H0-0002o2-Lp; Sun, 14 Oct 2007 09:12:50 -0400
Received: from tytso by tinytim.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1Ih37A-00066Z-TX; Sun, 14 Oct 2007 09:02:40 -0400
Content-Disposition: inline
In-Reply-To: <06B63221-7F8E-42FF-959F-D83FBABA6790@zib.de>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60847>

On Sun, Oct 14, 2007 at 02:52:25PM +0200, Steffen Prohaska wrote:
>
>> This commit adds a mechanism to provide absolute paths to the
>> external programs called by 'git mergetool'. A path can be
>> specified in the configuation variable mergetool.<tool>.path.
>
> Any news on this patch?
> Will you apply it (or recommend that Junio does)?

Hmm, for some reason I never received the v2 version of the patch.  I
see Johannes' comments to it, but not the original e-mail for some
reason.  It doesn't seem to be in the spam filter, so I'm not sure
what happened.

Can you resend, please?   Thanks!!

							- Ted
