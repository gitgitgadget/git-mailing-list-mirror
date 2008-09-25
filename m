From: Petr Baudis <pasky@suse.cz>
Subject: Re: On Sponsor Notices
Date: Thu, 25 Sep 2008 16:32:52 +0200
Message-ID: <20080925143252.GN10360@machine.or.cz>
References: <20080924204358.144077183@suse.cz> <20080924225120.GL10544@machine.or.cz> <alpine.LFD.1.10.0809242233360.14631@xanadu.home> <20080925101558.GF10360@machine.or.cz> <alpine.LFD.2.00.0809251016420.3635@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Sep 25 16:34:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kirut-0006yO-T0
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 16:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381AbYIYOcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 10:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752431AbYIYOcy
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 10:32:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38312 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752339AbYIYOcy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 10:32:54 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id DDBA23939B43; Thu, 25 Sep 2008 16:32:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0809251016420.3635@xanadu.home>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96768>

On Thu, Sep 25, 2008 at 10:20:23AM -0400, Nicolas Pitre wrote:
> On Thu, 25 Sep 2008, Petr Baudis wrote:
> 
> > On Wed, Sep 24, 2008 at 10:36:41PM -0400, Nicolas Pitre wrote:
> > > I'd suggest you do like some people working on the Linux kernel, i.e. 
> > > use your employer's email address for the Signed-off-by line but use 
> > > whatever address you prefer for the from/author line.
> > 
> > Even if the employer's email address is basically bogus? Can you point
> > to some examples of Linux kernel patches doing that, please?
> 
> See commit 6c3a158316.  If you send a mail to npitre@mvista.com at this 
> point, it most likely won't reach me.

Hmm, perhaps that makes the most sense then. I'm not sure if Shawn
already applied my patches or which part of them - they don't see to be
pushed out yet. Shawn, if it's convenient for you, could you please

	s/This patch has been sponsored by Novartis.

Signed-off-by: Petr Baudis <pasky@suse.cz>/Signed-off-by: Petr Baudis
<petr.baudis@novartis.com>/ them?

-- 
				Petr "Pasky" Baudis
People who take cold baths never have rheumatism, but they have
cold baths.
