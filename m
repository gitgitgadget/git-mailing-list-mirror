From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Revision walking documentation: document most
	important functions
Date: Fri, 30 May 2008 02:20:06 +0200
Message-ID: <20080530002006.GC18781@machine.or.cz>
References: <1212098185-8437-1-git-send-email-vmiklos@frugalware.org> <7vmym8oezm.fsf@gitster.siamese.dyndns.org> <20080529234625.GU27724@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 30 02:21:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1sMj-0006PT-P2
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 02:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbYE3AUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 20:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753804AbYE3AUN
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 20:20:13 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37081 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751138AbYE3AUM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 20:20:12 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id E73F7204C03F; Fri, 30 May 2008 02:20:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080529234625.GU27724@genesis.frugalware.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83257>

On Fri, May 30, 2008 at 01:46:25AM +0200, Miklos Vajna wrote:
> On Thu, May 29, 2008 at 04:41:17PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> > > Hm, I sent the patch using git-send-email,...
> > 
> > I do not think so.  You used 
> > 
> >     User-Agent: Mutt/1.5.17 (2007-11-01)
> 
> Oh, I misunderstood you. I was talking about the patch itself. Though
> the other mail seem to be pretty usual as well, so it's still a mystery
> for me. ;-)

You probably have git@vger.kernel.org configured as a list in your
~/.muttrc and followup_to set to yes (the default) - so Mutt generates a
Mail-Followup-To header omitting you so that you won't receive the
replies twice.

Incidentally, I have an opposite problem; when someone sends a reply
both to me and to git@, I never get the mailing list copy.

-- 
				Petr "Pasky" Baudis
Whatever you can do, or dream you can, begin it.
Boldness has genius, power, and magic in it.	-- J. W. von Goethe
