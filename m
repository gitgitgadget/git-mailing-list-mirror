From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git User's Survey 2007 unfinished summary (long)
Date: Thu, 4 Oct 2007 17:16:34 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710041712120.4174@racer.site>
References: <8fe92b430710040212u332bb4e5yfa6c10b8236c6301@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 18:10:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdTHb-0007Yo-3w
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 18:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759529AbXJDQGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 12:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762189AbXJDQG3
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 12:06:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:56640 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762180AbXJDQG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 12:06:28 -0400
Received: (qmail invoked by alias); 04 Oct 2007 16:06:26 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp047) with SMTP; 04 Oct 2007 18:06:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX191H9IGyZZ1Jzn5en+hO3D+DV1jUwOf6z86+plNPJ
	sPafxlbBwNSc8f
X-X-Sender: gene099@racer.site
In-Reply-To: <8fe92b430710040212u332bb4e5yfa6c10b8236c6301@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59976>

Hi,

On Thu, 4 Oct 2007, Jakub Narebski wrote:

> This is partial summary of Git User's Survey 2007,
> ending at state from 28 September 2007.

Thanks.

> 26. Which porcelains do you use?
> 
> Multiple answers (one can use more than one porcelain).
> 
>   Answer (multiple choice)       | Count
>   ------------------------------------------
>   core-git                       | 558
>   cogito (deprecated)            | 56
> 
>   Patch management interface:    : 57
>   ...........................................
>   StGIT                          | 41
>   Guilt (formerly gq)            | 13
>   pg (deprecated)                | 3
> 
>   own scripts                    | 95
>   other                          | 14
>   ------------------------------------------
>   Base                           | 593 / 683
>   Total (sum)                    | 780
> 
> Those 14 "other" answers make me wish to have provided "if other,
> what it was?" (sub)question; actually not only for this question.

git-gui, of course.  I consider it porcelain, because it uses core-git as 
backend.

In the same vein, I should consider gitk porcelain now, since it has 
rebase capabilities.  I will not, and I am not very happy that this viewer 
got a non-view-only capability, instead of git-gui, where that feature 
should have belonged (as suggested by at least one answer to a later 
question in the survey -- not by me).

Ciao,
Dscho
