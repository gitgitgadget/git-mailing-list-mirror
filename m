From: Petr Baudis <pasky@suse.cz>
Subject: Re: RFC: Website redesign
Date: Tue, 15 Apr 2008 16:33:45 +0200
Message-ID: <20080415143345.GC26302@machine.or.cz>
References: <3175605f-ff32-4fd6-bed3-7ae596ecbcde@q1g2000prf.googlegroups.com> <2c6b72b30804140656g14c24d8cwae016d62fe12f4a7@mail.gmail.com> <56e37551-4b8f-4164-a71d-79dba8635b7d@l28g2000prd.googlegroups.com> <96F7571C-1D9D-4F0A-99F1-A2307DAB0374@wincent.com> <bd6139dc0804141129h25c829e2i320f227594763d71@mail.gmail.com> <pan.2008.04.14.20.39.10@progsoc.org> <20080414213339.GB10300@dpotapov.dyndns.org> <pan.2008.04.15.03.25.00@progsoc.org> <m3r6d7sgf9.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 17:02:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlmEz-0003xX-7X
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 16:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757021AbYDOOds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 10:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757322AbYDOOds
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 10:33:48 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49670 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756943AbYDOOdr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 10:33:47 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id E616D3939B12; Tue, 15 Apr 2008 16:33:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <m3r6d7sgf9.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79603>

On Tue, Apr 15, 2008 at 12:53:10AM -0700, Jakub Narebski wrote:
> Anand Kumria <wildfire@progsoc.org> writes:
> 
> > On Tue, 15 Apr 2008 01:33:39 +0400, Dmitry Potapov wrote:
> > 
> >> On Mon, Apr 14, 2008 at 08:39:00PM +0000, Anand Kumria wrote:
> >>> 
> >>> That is basically the current "Web 2.0 style".
> >>> 
> >>> <http://www.webdesignfromscratch.com/current-style.cfm>

Thanks for this link, I find it quite insightful - and at the same time
I believe that the changes to the current homepage could be much less
radical to significantly improve the design and flow of the page
according to the principles described there.

> > But let's continue your, rather pointless, exercise:
> > 
> > http://git.or.cz/ - invalid, 9 errors
> 
> And when _examining_ this error one would realize that _all_ those
> errors are in _single_, old style (using unencoded ampersands) URL.

Ha! Good catch, and all the parameters are actually useless - fixed,
thanks. :-)

-- 
				Petr "Pasky" Baudis
Whatever you can do, or dream you can, begin it.
Boldness has genius, power, and magic in it.	-- J. W. von Goethe
