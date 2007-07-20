From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Thu, 19 Jul 2007 17:01:36 -0700
Message-ID: <7vk5sw2ba7.fsf@assigned-by-dhcp.cox.net>
References: <858x9ez1li.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org>
	<vpq4pk1vf7q.fsf@bauges.imag.fr>
	<alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org>
	<85644hxujp.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
	<alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
	<85abttwa7m.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org>
	<7vbqe93qtv.fsf@assigned-by-dhcp.cox.net>
	<20070719053858.GE32566@spearce.org>
	<9436820E-53D1-425D-922E-D4C76578E40A@silverinsanity.com>
	<863azk78yp.fsf@lola.quinscape.zz>
	<FA38709A-7C68-4D66-BA26-B5ED49DFA85A@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>,
	"Shawn O.Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 02:01:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBfwE-0000Nu-7Y
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 02:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761077AbXGTABi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 20:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761069AbXGTABi
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 20:01:38 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:58707 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759106AbXGTABh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 20:01:37 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070720000136.YKDF1428.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 19 Jul 2007 20:01:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Rc1b1X00Z1kojtg0000000; Thu, 19 Jul 2007 20:01:36 -0400
In-Reply-To: <FA38709A-7C68-4D66-BA26-B5ED49DFA85A@silverinsanity.com> (Brian
	Gernhardt's message of "Thu, 19 Jul 2007 11:08:11 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53037>

Brian Gernhardt <benji@silverinsanity.com> writes:

> My apologies for the wasted bandwidth arguing for things that had
> already been decided.

Sorry, who decided what?
