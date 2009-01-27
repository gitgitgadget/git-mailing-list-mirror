From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: friendlier names
Date: Tue, 27 Jan 2009 19:10:34 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901271910070.3586@pacific.mpi-cbg.de>
References: <87mydc6a2r.fsf@mcbain.luannocracy.com> <20090127153837.GB1321@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Abrahams <dave@boostpro.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 27 19:13:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRsPZ-0001OB-3E
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 19:11:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755909AbZA0SKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 13:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755887AbZA0SKU
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 13:10:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:34020 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755725AbZA0SKT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 13:10:19 -0500
Received: (qmail invoked by alias); 27 Jan 2009 18:10:15 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp068) with SMTP; 27 Jan 2009 19:10:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1++xEFW0na+tPTY0K2v6gYvf7CfEHKnBzpc52YU5x
	o6YMGEwld0rVl6
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090127153837.GB1321@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107376>

Hi,

On Tue, 27 Jan 2009, Shawn O. Pearce wrote:

> David Abrahams <dave@boostpro.com> wrote:
> > 
> > For example, why couldn't the "index" be called the "stage" instead?
> > That, along with knowing that "git add" was a synonym for "git stage"
> > would have flattened the learning curve considerably for me.
> 
> Historical reasons...
> 
> Waaay back the "index" was an index of the files git knows about in
> your working directory.  It made sense to call it an index, as like
> a book index it was a full listing of what's here, sorted by name.
> 
> That's pre-1.0 days.  Like the very first version Linus ever
> released.  Aka commit e83c5163316f89bfbde7d9ab23ca2e25604af290.

Actually, it was known by the name "dircache" back then :-)

Ciao,
Dscho
