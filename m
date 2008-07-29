From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bizarre missing changes (git bug?)
Date: Mon, 28 Jul 2008 20:33:51 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807282031240.3334@nehalem.linux-foundation.org>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com> <alpine.LFD.1.10.0807211331390.31863@woody.linux-foundation.org> <200807260512.40088.zippel@linux-m68k.org> <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain> <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain> <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain> <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain> <alpine.LFD.1.10.0807282023290.3334@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Roman Zippel <zippel@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 05:38:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNg2I-0000bX-7g
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 05:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051AbYG2DhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 23:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753155AbYG2DhE
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 23:37:04 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59228 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752827AbYG2DhC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jul 2008 23:37:02 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6T3apRn007585
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Jul 2008 20:36:52 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6T3aoV7012145;
	Mon, 28 Jul 2008 20:36:50 -0700
In-Reply-To: <alpine.LFD.1.10.0807282023290.3334@nehalem.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.411 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90559>



On Mon, 28 Jul 2008, Linus Torvalds wrote:
> 
> And quite frankly, I've seen that behaviour from you before, when it comes 
> to other things. So go away. Write the code. Come back with patches. In 
> the meantime, we've told you what to do: use --full-history if you really 
> want it.

Btw, if you really do end up wanting to actually do something about it, I 
can already tell you that trying to do so in "git log" isn't going to be 
useful. Do it in "gitk" instead, and make gitk simplify the --full-history 
output.

I tried to explain to you the why part earlier (go back and look for 
"incremental" and "topo-sort"), but it all seemed to fly right by you, and 
you started repeating your ranting instead.

IOW, put up or shut up.

			Linus
