From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jul 2009, #01; Mon, 06)
Date: Tue, 7 Jul 2009 22:08:12 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907072206170.3155@pacific.mpi-cbg.de>
References: <7vk52l4q7k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 22:06:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOGvw-0001uJ-MP
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 22:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253AbZGGUG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 16:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754888AbZGGUG0
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 16:06:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:55313 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751418AbZGGUGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 16:06:25 -0400
Received: (qmail invoked by alias); 07 Jul 2009 20:06:23 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 07 Jul 2009 22:06:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/TCA8m6iTThBuUyxLrWnzYnrhHzQpHPHQ+8VKtH3
	huvtyqREb7hewx
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vk52l4q7k.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122866>

Hi,

On Mon, 6 Jul 2009, Junio C Hamano wrote:

> * jh/notes (Sat May 16 13:44:17 2009 +0200) 5 commits
>  - Teach "-m <msg>" and "-F <file>" to "git notes edit"
>  - Add an expensive test for git-notes
>  - Speed up git notes lookup
>  - Add a script to edit/inspect notes
>  - Introduce commit notes
> 
> Dscho asked about the performance implications of this; I do not think I 
> saw any progress on that yet...

Neither did I.

> * en/fast-export (Thu Jun 25 22:48:33 2009 -0600) 7 commits
>  - fast-export: Document the fact that git-rev-list arguments are
>    accepted
>  - Add new fast-export testcases
>  - fast-export: Add a --tag-of-filtered-object option for newly
>    dangling tags
>  - fast-export: Do parent rewriting to avoid dropping relevant
>    commits
>  - fast-export: Make sure we show actual ref names instead of
>    "(null)"
>  - fast-export: Omit tags that tag trees
>  - fast-export: Set revs.topo_order before calling setup_revisions
> 
> Shawn?  Dscho?

Sorry, today I was still jet-lagged, and I do not trust myself in such 
conditions at all.  Will take another look tomorrow (what I saw looked 
okay to me, but I did not have time to look closely).

Ciao,
Dscho
