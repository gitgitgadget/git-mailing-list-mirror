From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] push: Learn to set up branch tracking with '--track'
Date: Thu, 29 Jan 2009 15:05:20 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901291504080.3586@pacific.mpi-cbg.de>
References: <cover.1233236267u.git.johannes.schindelin@gmx.de>  <alpine.DEB.1.00.0901291438030.3586@pacific.mpi-cbg.de> <bd6139dc0901290551g42ac7cb6m40194f75b8863be0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 15:07:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSXXG-0004jv-HU
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 15:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757584AbZA2OFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 09:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752789AbZA2OFA
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 09:05:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:52507 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757435AbZA2OE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 09:04:58 -0500
Received: (qmail invoked by alias); 29 Jan 2009 14:04:57 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp070) with SMTP; 29 Jan 2009 15:04:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19oqNRxvIdoANJ5gmUCStLRPbXwiee4mEMleBtbWI
	l4NmpQ6Lsl5dis
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <bd6139dc0901290551g42ac7cb6m40194f75b8863be0@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107678>

Hi,

On Thu, 29 Jan 2009, Sverre Rabbelier wrote:

> On Thu, Jan 29, 2009 at 12:45, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> > Mhhh, so maybe we want a way to set up tracking branches when pushing,
> > yes? From what I've seen a patch to do that shouldn't be too hard, so
> > if there's interest in that I could look into that.
> 
> On Thu, Jan 29, 2009 at 14:38, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> >        $ git checkout xyz
> >        $ git push --track origin xyz:abc
> >        $ git pull
> 
> Am I reading this correctly in that you beat me to the patch I
> mentioned earlier in reply to Junio and Peff?

I have to admit that due to time constraints, I did not follow your 
discussion closely.

I just just remembered that 'jast' mentioned something like this on IRC, 
and it seemed that it was easy to do.  Now you go and point out all those 
mistakes in my code, okay?

Ciao,
Dscho
