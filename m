From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [ANNOUNCE] Gerrit Code Review 2.0.3
Date: Tue, 17 Feb 2009 17:44:23 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902171743280.6185@intel-tinevez-2-302>
References: <20090217011256.GA23314@spearce.org>  <1976ea660902162311q12e11ec5g7a43ab637186985e@mail.gmail.com>  <20090217151838.GI18525@spearce.org> <8c9a060902170813ie8f5bc1gfed53e4f31f64c23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Frank Li <lznuaa@gmail.com>, git@vger.kernel.org
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 17:46:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZT57-0003hw-Nt
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 17:46:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236AbZBQQod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 11:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753053AbZBQQoc
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 11:44:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:48564 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752815AbZBQQob (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 11:44:31 -0500
Received: (qmail invoked by alias); 17 Feb 2009 16:44:28 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp049) with SMTP; 17 Feb 2009 17:44:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+yosx5O4GybgzDJAlkrz9L214HghRE9IRi6WBLmj
	KypDVnYBwmMT3Y
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <8c9a060902170813ie8f5bc1gfed53e4f31f64c23@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110410>

Hi,

On Tue, 17 Feb 2009, Jacob Helwig wrote:

> On Tue, Feb 17, 2009 at 07:18, Shawn O. Pearce <spearce@spearce.org> wrote:
> > Gerrit is known to not work in Internet Explorer.  As an open source
> > developer, my primary desktop system runs Linux.  My portable laptops
> > all run Mac OS X, because its shiny.  I have no system capable of
> > running Internet Explorer, nor do I desire to send dollars towards
> > Redmond in order to obtain an OS license in order to do so.
> >
> > Something is busted in the IE AJAX code used by Gerrit Code Review.
> > I'm guessing that instead of making the data available to the AJAX
> > callback, IE wants to save it as a file on disk.  No clue why.
> > And due to the lack of IE, I am unable to debug the problem myself.
> > I am waiting for someone who really cares about using IE to debug
> > it and contribute the patch back.
> >
> 
> I've found IEs4Linux helpful for debugging IE-only issues under Linux.
> 
> http://www.tatanka.com.br/ies4linux/page/Main_Page
> 
> I don't recall, off hand, if it'll provide IE 7 (and the site isn't
> working for me right now, so I can't confirm this).  It does provide
> IE 5.0, 5.5, and 6.0, however.

If I understand Shawn (and the motto "scratch your own itch") correctly, 
Shawn was not so much interested in being pointed to a way of running IE 
himself, but more in people who absolutely want to run IE themselves to go 
and fix the issues.

Ciao,
Dscho
