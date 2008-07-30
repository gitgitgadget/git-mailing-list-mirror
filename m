From: Junio C Hamano <gitster@pobox.com>
Subject: Re: markdown 2 man, was Re: Git Community Book
Date: Wed, 30 Jul 2008 12:32:02 -0700
Message-ID: <7vy73j418t.fsf@gitster.siamese.dyndns.org>
References: <d411cc4a0807290920p62f5d7e1r727a62ef2b4611fc@mail.gmail.com>
 <20080729170955.GK32184@machine.or.cz>
 <d411cc4a0807291130p228f77d5r1f390090ec29aef4@mail.gmail.com>
 <7vwsj4edm1.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0807291957410.1779@reaper.quantumfyre.co.uk>
 <alpine.LSU.1.00.0807301514280.3486@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Scott Chacon <schacon@gmail.com>, Petr Baudis <pasky@suse.cz>,
	git list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 30 21:33:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOHQC-0001It-D0
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 21:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145AbYG3TcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 15:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754010AbYG3TcN
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 15:32:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44453 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233AbYG3TcM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 15:32:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EBCA140D37;
	Wed, 30 Jul 2008 15:32:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 170A240D32; Wed, 30 Jul 2008 15:32:03 -0400 (EDT)
In-Reply-To: <alpine.LSU.1.00.0807301514280.3486@wbgn129.biozentrum.uni-wuerzburg.de>
 (Johannes Schindelin's message of "Wed, 30 Jul 2008 15:27:38 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 33CDD76C-5E6E-11DD-8655-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90840>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Note also that Markdown cannot create TOCs automatically, AFAICT.  So 
> probably it would be not all that easy to convert the User Manual to that 
> format.

The use of markdown may mean updates to the User Manual won't be merged
back to his book without effort and manual porting on his side, and the
side porting in the other direction has the same issue as well, but the
contents and the way materials are presented will be vastly different in
future versions anyway; not being able to side-port new material verbatim
may not be an issue.  Discussion with Scott seems to suggest that the
overall philosophy of his book is "this is a different book targetted for
different audiences; its initial text happens to heavily borrow from the
existing documents but expected to become vastly improved", in other
words, fork-and-never-return.

That's one valid approach.  I or you might have taken a different avenue,
but after all, it's his book, not mine, not yours, nor git list's book.

As I am not in "graphics and screencast" camp, I may probably not be able
to offer much help improving his book, and I suspect some people on this
list might feel the same way.  But that's is Ok --- we are not dumping the
User Manual.

We originally hoped (well, at least I did) that Scott's effort on his book
might help us in improving the User Manual as well, but the approach seems
to make it unlikely.  But that is nothing to hold against him --- he is
doing his own thing in a way he feels is the best, and that's perfectly
fine.  We lost nothing, perhaps except for a chance to cooperate a bit
better and to widen the community.

> If at all, I would have preferred a format switch to Wiki syntax so that 
> we can use the same source on the Git wiki as in our Documentation/ 
> directory.

Yeah, that's also true.  I seem to recall markdown was used in ikiwiki?
