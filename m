From: Petr Baudis <pasky@suse.cz>
Subject: Re: blame vs annotate?
Date: Wed, 3 Sep 2008 19:54:22 +0200
Message-ID: <20080903175422.GV10544@machine.or.cz>
References: <57518fd10809030943i35af222fw82cf591c737b8c04@mail.gmail.com> <20080903174939.GH16514@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan del Strother <maillist@steelskies.com>,
	Git Mailing List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Sep 03 19:57:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KawaX-0004N1-0W
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 19:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758412AbYICRya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 13:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759527AbYICRy3
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 13:54:29 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59223 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759524AbYICRy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 13:54:27 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id C81693939B56; Wed,  3 Sep 2008 19:54:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080903174939.GH16514@genesis.frugalware.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94827>

On Wed, Sep 03, 2008 at 07:49:39PM +0200, Miklos Vajna wrote:
> On Wed, Sep 03, 2008 at 05:43:03PM +0100, Jonathan del Strother <maillist@steelskies.com> wrote:
> > What's the difference between 'git blame' & 'git annotate'?  The
> > output is practically identical - it's not obvious when you would use
> > one over the other
> 
> 'git annoate' is the same as 'git blame -c'.

But 'git blame -c' is defined as "the same as 'git annotate'". So this
answer does not really help. :-)

(And yes, I'd love to hear some as well. When pruning the completion
list, I've been on the verge of setting 'git annotate' as deprecated,
but decided to do that in a separate patch later and properly. Please
someone beat me to it. ;-)

				Petr "Pasky" Baudis
