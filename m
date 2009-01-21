From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mergetool merge/skip/abort
Date: Wed, 21 Jan 2009 17:33:33 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901211730530.3586@pacific.mpi-cbg.de>
References: <81bfc67a0901210637j52fa7a55q51b599e9ff16f6dc@mail.gmail.com> <81bfc67a0901210817r49971c09kea9dc8ee5ae21572@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 17:34:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPg2X-0008F1-Al
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 17:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbZAUQd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 11:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751715AbZAUQd2
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 11:33:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:45573 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751546AbZAUQd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 11:33:28 -0500
Received: (qmail invoked by alias); 21 Jan 2009 16:33:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp023) with SMTP; 21 Jan 2009 17:33:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19l0YpG+PVl9S2bn7f3szZsMhs1eJ931hDyYH+Mju
	tmtbva5ROtIpaK
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <81bfc67a0901210817r49971c09kea9dc8ee5ae21572@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106626>

Hi,

On Wed, 21 Jan 2009, Caleb Cushing wrote:

> just a typo fix in the patch
> 
> >From 29c2873861a3aec8304529735307385e9e5c248a Mon Sep 17 00:00:00 2001
> From: Caleb Cushing <xenoterracide@gmail.com>
> Date: Tue, 20 Jan 2009 11:33:30 -0500
> Subject: [PATCH] mergetool merge/skip/abort
>  add functionality to skip merging a file or abort from the merge
> 
> ---

If you look at other patch submissions, you will find that they all do it 
differently.  You will never see a "Date:" or "Subject:" line.  You will 
see a much shorter commit subject.  And a more verbose commit message.

Sometimes, you will see that a commit message is not quite informative, or 
does not explain the _motivation_ why it should be a good idea to do what 
the patch does, and me saying so very directly (but never meaning to 
offend).

Hth,
Dscho
