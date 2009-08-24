From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Announcement: cvs2svn 2.3.0 released
Date: Mon, 24 Aug 2009 16:33:33 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908241632470.11375@intel-tinevez-2-302>
References: <4A9074C7.4080002@alum.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Aug 24 16:33:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfacD-0002qQ-Oj
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 16:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622AbZHXOdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 10:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752591AbZHXOdd
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 10:33:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:51290 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752481AbZHXOdd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 10:33:33 -0400
Received: (qmail invoked by alias); 24 Aug 2009 14:33:33 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp065) with SMTP; 24 Aug 2009 16:33:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/21fpcgG32AYsOzbsNmihI+AROyKZKMFU+4zAjRj
	8DNVuaBXX7n1KQ
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4A9074C7.4080002@alum.mit.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126931>

Hi,

On Sun, 23 Aug 2009, Michael Haggerty wrote:

> I am happy to announce release 2.3.0 of cvs2svn/cvs2git/cvs2bzr.
> 
> cvs2svn is a tool for migrating a CVS repository to Subversion, git,
> Bazaar, or Mercurial. The main design goals are robustness and 100% data
> preservation. cvs2svn can convert just about any CVS repository we've
> ever seen, including gcc, Mozilla, FreeBSD, KDE, and GNOME.
> 
> Release 2.3.0 primarily improves the support for converting to git and
> Bazaar (including explicit cvs2git and cvs2bzr scripts).  This release
> also adds a few other minor features and fixes a bug when converting to
> git with non-inline blobs.

Does it support incremental operation yet?  (I.e. do not bother to 
re-import what was imported already?)

Thanks,
Dscho
