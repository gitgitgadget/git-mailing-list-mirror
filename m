From: Junio C Hamano <junkio@cox.net>
Subject: Re: A look at some alternative PACK file encodings
Date: Wed, 06 Sep 2006 22:27:52 -0700
Message-ID: <7vslj4455z.fsf@assigned-by-dhcp.cox.net>
References: <44FF41F4.1090906@gmail.com>
	<9e4733910609061623k73086dbey4a600ecf2852c024@mail.gmail.com>
	<Pine.LNX.4.64.0609062037560.18635@xanadu.home>
	<20060907043300.GA31376@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 07:27:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLCQU-0004YW-Cj
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 07:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbWIGF1n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 01:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbWIGF1n
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 01:27:43 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:56808 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751857AbWIGF1m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 01:27:42 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060907052742.CDWY21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Thu, 7 Sep 2006 01:27:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KHTa1V00A1kojtg0000000
	Thu, 07 Sep 2006 01:27:35 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060907043300.GA31376@spearce.org> (Shawn Pearce's message of
	"Thu, 7 Sep 2006 00:33:00 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26593>

Shawn Pearce <spearce@spearce.org> writes:

> And I'm half-way done with the 64 bit mmap sliding window.  You,
> Junio and I are all hacking on the same tiny bit of core code for
> different reasons.  :-)

Which makes me quite nervous, actually.
