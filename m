From: Petr Baudis <pasky@suse.cz>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Fri, 29 Aug 2008 01:30:22 +0200
Message-ID: <20080828233022.GB10360@machine.or.cz>
References: <alpine.LFD.1.10.0808280934160.3300@nehalem.linux-foundation.org> <7BC51BEC-E230-48C5-BD3E-2CECE3C7FC98@cs.indiana.edu> <20080828195211.GA3545@mithlond.arda.local> <4B9831F7-3CB8-49CB-A1DB-111481A271FE@cs.indiana.edu> <20080828212346.GA27867@coredump.intra.peff.net> <1C144B19-DA21-4CB4-B872-C1F154B031CF@cs.indiana.edu> <20080828215907.GE27867@coredump.intra.peff.net> <3DE083DB-ADFF-45E7-B3EB-A76985941271@cs.indiana.edu> <20080828230401.GC29609@coredump.intra.peff.net> <7vmyiwd8ot.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Perry Wagle <wagle@cs.indiana.edu>,
	Teemu Likonen <tlikonen@iki.fi>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ulrich Windl <ulrich.windl@rz.uni-regensburg.DE>,
	Andi Kleen <andi@firstfloor.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 01:31:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYqxe-0003lW-Hu
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 01:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755035AbYH1XaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 19:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754906AbYH1XaZ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 19:30:25 -0400
Received: from w241.dkm.cz ([62.24.88.241]:46865 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754892AbYH1XaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 19:30:25 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 5019F3939B57; Fri, 29 Aug 2008 01:30:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vmyiwd8ot.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94208>

On Thu, Aug 28, 2008 at 04:24:50PM -0700, Junio C Hamano wrote:
> Before anybody greps in Documentation/ to make pointless noises about some
> dashed-form git-foo in there when we do not talk about what the user types
> but about a command as a concept in manual pages, they are left in dashed
> form deliberately, partly to help manpage browsers crosslink across pages.

What is the other part? And is it really worth the confusion? Are the
gazillions cases of dashed-form git-foo in there where we DO talk about
what the user types "pointless noises" too?

(I have argued further in the other mail but somehow we seem to have
gone off the list with that subthread, hmm.)

				Petr "Pasky" Baudis
