From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Closing the merge window for 1.6.0
Date: Tue, 15 Jul 2008 16:27:02 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807151623120.8950@racer>
References: <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org> <7vabgqsc37.fsf@gitster.siamese.dyndns.org> <7vtzetjbif.fsf@gitster.siamese.dyndns.org> <7vzlokhpk7.fsf@gitster.siamese.dyndns.org> <20080714085555.GJ32184@machine.or.cz> <alpine.DEB.1.00.0807141256310.8950@racer>
 <20080714124109.25414.qmail@06d015ec9c6744.315fe32.mid.smarden.org> <alpine.LFD.1.10.0807141351540.12484@xanadu.home> <7v3amcgujd.fsf@gitster.siamese.dyndns.org> <20080715092023.GO10151@machine.or.cz> <20080715150626.GA2925@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>, Gerrit Pape <pape@smarden.org>,
	git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 17:29:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KImSp-0003Hk-Kw
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 17:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760571AbYGOP1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 11:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760595AbYGOP1G
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 11:27:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:39906 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758326AbYGOP1E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 11:27:04 -0400
Received: (qmail invoked by alias); 15 Jul 2008 15:27:02 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp056) with SMTP; 15 Jul 2008 17:27:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX180k9tU3ZA0I76/72VfP2ukYgKa4XbZU/8pBlVhea
	m1vvwSPnyyj9Tc
X-X-Sender: gene099@racer
In-Reply-To: <20080715150626.GA2925@dpotapov.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88568>

Hi,

On Tue, 15 Jul 2008, Dmitry Potapov wrote:

> Those repos that think that access for Git 1.4 users is important for 
> them can set indexformat=1.

Unfortunately, you place quite a high maintenance burden on the repository 
maintainers here.

>From the time balance sheet, it does not look good at all: a few minutes 
for Junio to change and commit, up to a few hours (because they missed it 
in the release notes) for probably more than hundred repository 
maintainers that are not subscribed to the Git mailing list.

And I absolutely agree with Pasky that this does _nothing_ in the vague 
direction of wielding a reputation of being easy to use.

Sure, we can make it easy on ourselves.  And it is just as easy to make it 
hard on others.  If you're okay with that, I am not.

Ciao,
Dscho
