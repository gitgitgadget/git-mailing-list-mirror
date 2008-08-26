From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 14:38:11 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808261435470.3363@nehalem.linux-foundation.org>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org> <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net>
 <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org> <alpine.LFD.1.10.0808260959000.3363@nehalem.linux-foundation.org> <20080826180926.GA25711@isilmar.linta.de> <alpine.LFD.1.10.0808261114070.3363@nehalem.linux-foundation.org>
 <7vk5e38o0d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
	David Woodhouse <dwmw2@infradead.org>,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 23:41:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY6He-0003sf-O4
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 23:41:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbYHZVjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 17:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752423AbYHZVjn
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 17:39:43 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49637 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752269AbYHZVjn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Aug 2008 17:39:43 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7QLcCvW015403
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 26 Aug 2008 14:38:13 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7QLcBOk029006;
	Tue, 26 Aug 2008 14:38:11 -0700
In-Reply-To: <7vk5e38o0d.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.928 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93825>



On Tue, 26 Aug 2008, Junio C Hamano wrote:
> 
> I do not think "the plan got scuttled *already*" before you said so.  It
> was the purpose for this thread to discuss it.
>
> You effectively vetoed the plan with your statement just now, and that 
> settles it.

I wouldn't say I vetoed i, but wasn't it pretty obvious from the whole 
discussion that a fair number of people want to keep git-xyzzy?

So getting rid of git-xyzzy altogether would seem to be stupid, and not 
listening to users.

So I'm not "vetoing" it, but I don't think git maintainers (past _or_ 
current ;) have been stupid, or unable to listen to people, and as such I 
think the end result is pretty obvious.

			Linus
