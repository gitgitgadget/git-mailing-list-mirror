From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: Stacked GIT 0.3 (now more Quilt-like)
Date: Sun, 03 Jul 2005 21:10:44 -0400
Message-ID: <200507040110.j641AiYl004190@laptop11.inf.utfsm.cl>
References: <catalin.marinas@gmail.com>
Cc: Peter Osterlund <petero2@telia.com>, GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 04 04:34:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpGnD-0007hr-M6
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 04:34:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVGDCeT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jul 2005 22:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVGDCeT
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jul 2005 22:34:19 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:4261 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261323AbVGDCeM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jul 2005 22:34:12 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j641AiYl004190;
	Sun, 3 Jul 2005 21:10:44 -0400
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: Message from Catalin Marinas <catalin.marinas@gmail.com> 
   of "Sun, 03 Jul 2005 22:14:29 +0100." <1120425269.6845.28.camel@localhost.localdomain> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Catalin Marinas <catalin.marinas@gmail.com> wrote:
> On Sun, 2005-07-03 at 14:38 +0200, Peter Osterlund wrote:
> > Catalin Marinas <catalin.marinas@gmail.com> writes:
> > > I know that using -A gives a more detailed output in case of a conflict.
> > > The problem is that you will get a conflict even if the changes are
> > > identical, making it impossible to detect when a patch was merged
> > > upstream.

> > OK, I see. How about using wiggle instead?
> > 
> >         http://cgi.cse.unsw.edu.au/~neilb/source/wiggle/

[...]

> I haven't used wiggle before but I will give it a try (though I prefer
> such a tool not to be too smart since it might make mistakes).

Last version is 0.6, released 2 years back... I'm not sure it is wise to
rely on abandonware.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
