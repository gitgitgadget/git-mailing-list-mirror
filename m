From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] sequencer: add "reset_almost_hard()" and related
 functions
Date: Tue, 4 Aug 2009 14:45:30 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908041443310.8306@pacific.mpi-cbg.de>
References: <20090803024023.3794.90748.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Aug 04 14:45:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYJOi-00043d-Vt
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 14:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755457AbZHDMpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 08:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755446AbZHDMpJ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 08:45:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:48670 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755436AbZHDMpI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 08:45:08 -0400
Received: (qmail invoked by alias); 04 Aug 2009 12:45:07 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp049) with SMTP; 04 Aug 2009 14:45:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/MwMtCjifMMMfSUGmU8XEc5fE7GjxkfEOG5beuVT
	uPy5I9uCI7i4Ut
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090803024023.3794.90748.chriscool@tuxfamily.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124783>

Hi,

On Mon, 3 Aug 2009, Christian Couder wrote:

> diff --git a/builtin-sequencer--helper.c b/builtin-sequencer--helper.c
> index 1dda525..82a830d 100644
> --- a/builtin-sequencer--helper.c
> +++ b/builtin-sequencer--helper.c
> @@ -2,16 +2,95 @@

I do not have that file in my tree.  Yet your 1/3 already expects it to be 
there.

Well, I guess I will work on finishing my rebase-i-p branch next week, and 
then see what is there in Stephan's repository, and ask him why he went so 
silent (after all, his code should have been polished  enough to be 
included 11 months ago).

Ciao,
Dscho
