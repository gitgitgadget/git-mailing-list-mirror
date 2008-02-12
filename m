From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: reflog-delete, was Re: What's cooking in git.git (topics)
Date: Tue, 12 Feb 2008 09:57:26 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802120956390.3870@racer.site>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org> <7vodavd9qw.fsf@gitster.siamese.dyndns.org> <7vbq6tset4.fsf@gitster.siamese.dyndns.org> <7vmyq9gk94.fsf@gitster.siamese.dyndns.org> <7vk5la4oxq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 10:58:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOru3-00053E-Ge
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 10:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759736AbYBLJ5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 04:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759781AbYBLJ5k
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 04:57:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:58872 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759168AbYBLJ5k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 04:57:40 -0500
Received: (qmail invoked by alias); 12 Feb 2008 09:57:38 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp054) with SMTP; 12 Feb 2008 10:57:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX183vKdtGdg3JB/ThSpa5EL692YBfwalIGIy69t61G
	+yf0p4jecK6Ote
X-X-Sender: gene099@racer.site
In-Reply-To: <7vk5la4oxq.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73648>

Hi,

On Mon, 11 Feb 2008, Junio C Hamano wrote:

> [On Hold]
> 
> * js/reflog-delete (Fri Jan 4 19:11:37 2008 -0600) 2 commits
>  + builtin-reflog.c: fix typo that accesses an unset variable
>  + Teach "git reflog" a subcommand to delete single entries
> 
> There was a patch that uses this to implement "git-stash drop",
> which I didn't queue, as the command name and the UI was
> undecided yet.  Dscho was in favor of "pop" without "drop".

Well, I was in favour of making "pop" the main user visible action.

Ciao,
Dscho
