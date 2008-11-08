From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: absurdly slow git-diff
Date: Sat, 8 Nov 2008 08:27:34 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0811080825080.10880@alien.or.mcafeemobile.com>
References: <20081107200126.GA20284@toroid.org>
 <alpine.LFD.2.00.0811071335010.3468@nehalem.linux-foundation.org>
 <alpine.DEB.1.10.0811071503120.8736@alien.or.mcafeemobile.com>
 <alpine.DEB.1.10.0811071517280.8736@alien.or.mcafeemobile.com>
 <alpine.LFD.2.00.0811071540340.3468@nehalem.linux-foundation.org>
 <alpine.DEB.1.10.0811071547080.8736@alien.or.mcafeemobile.com>
 <7v7i7eeqcz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Abhijit Menon-Sen <ams@toroid.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 08 17:29:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kyqgl-0007HI-Jn
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 17:29:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534AbYKHQ1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 11:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753370AbYKHQ1l
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 11:27:41 -0500
Received: from x35.xmailserver.org ([64.71.152.41]:59779 "EHLO
	x35.xmailserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112AbYKHQ1l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 11:27:41 -0500
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.xmailserver.org with [XMail 1.26 ESMTP Server]
	id <S2B7EF6> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Sat, 8 Nov 2008 11:27:39 -0500
X-X-Sender: davide@alien.or.mcafeemobile.com
In-Reply-To: <7v7i7eeqcz.fsf@gitster.siamese.dyndns.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100410>

On Fri, 7 Nov 2008, Junio C Hamano wrote:

> Davide Libenzi <davidel@xmailserver.org> writes:
> 
> > Yeah, similar. Mine is below. There's one less branch in the for loops.
> 
> Thanks, will apply like this, but I am not sure if you meant windowN or
> just window...

Whoops, just WINDOW.


- Davide
