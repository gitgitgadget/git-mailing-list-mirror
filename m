From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC+PATCH 1/1] Move SCM interoperability tools into scm/
Date: Mon, 10 Jul 2006 00:21:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607100018380.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11524258261798-git-send-email-ryan@michonline.com>
 <46a038f90607091426u5a6ea328h2090a876e51725ce@mail.gmail.com>
 <20060709221326.GU29115@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 00:21:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fzhep-0004TI-Fs
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 00:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161193AbWGIWVk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 18:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161194AbWGIWVk
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 18:21:40 -0400
Received: from mail.gmx.de ([213.165.64.21]:31167 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161193AbWGIWVk (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 18:21:40 -0400
Received: (qmail invoked by alias); 09 Jul 2006 22:21:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 10 Jul 2006 00:21:38 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060709221326.GU29115@pasky.or.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23571>

Hi,

On Mon, 10 Jul 2006, Petr Baudis wrote:

> Dear diary, on Sun, Jul 09, 2006 at 11:26:59PM CEST, I got a letter
> where Martin Langhoff <martin.langhoff@gmail.com> said that...
> > So I have to ask... what are the expected benefits of the move?
> 
> I've been meaning to do something like this for some time already; my
> itch have been the builtins. The tree size _is_ getting out of hand and
> a little more categorization of the sources would certainly help.

Funny. I thought the builtin-* prefix, and the *.sh and *.perl extensions 
were there for the sake of categorization.

And I disagree on the "out of hand" thing.

Ciao,
Dscho
