From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git integration with monodevelop
Date: Fri, 14 Nov 2008 14:30:49 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811141429040.30769@pacific.mpi-cbg.de>
References: <491AAE6D.8030304@op5.se> <491AF20D.4070600@kde.ru> <491AF768.3010607@op5.se> <491B02FF.2060204@kde.ru> <491BD532.9090200@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Evgeniy Ivanov <powerfox@kde.ru>,
	Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Nov 14 14:24:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0yey-000899-RN
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 14:24:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbYKNNXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 08:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbYKNNXK
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 08:23:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:39669 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751233AbYKNNXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 08:23:09 -0500
Received: (qmail invoked by alias); 14 Nov 2008 13:23:08 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp059) with SMTP; 14 Nov 2008 14:23:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+GaplKy7OGartgZfGuZ6slkCiaCXIljbFlC+JK0y
	PS0rvQe3tOys0t
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <491BD532.9090200@op5.se>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100972>

Hi,

On Thu, 13 Nov 2008, Andreas Ericsson wrote:

> Evgeniy Ivanov wrote:
>
> > But this is the same things Shawn has suggested to my mentor and me at 
> > the beginning of SoC...
> 
> Oh? I didn't know libgit2 started as a SoC project.

It did not.  It started as a request from GitHub, and following 
discussion, at the GitTogether '08.

There _was_ a SoC project last year, libgit-thin, but the problem as far 
as GitHub is concerned was that it was a tear-down approach: it took 
git.git and tried to make a small library of it, and by this approach was 
bound to the GPL.

Ciao,
Dscho
