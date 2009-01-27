From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Anyone have access to 64-bit Vista?
Date: Tue, 27 Jan 2009 23:51:13 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901272350360.3586@pacific.mpi-cbg.de>
References: <83d7aaa40901270130g3bebb3d6we4839b567f310e46@mail.gmail.com>  <20090127122456.0df531c3.stephen@exigencecorp.com> <83d7aaa40901271441h47c98edepc16f5026de636134@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Geoffrey Lee <geoffreyj.lee@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 23:52:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRwn4-00009Z-Vf
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 23:52:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbZA0Wuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 17:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752663AbZA0Wuz
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 17:50:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:48756 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752305AbZA0Wuy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 17:50:54 -0500
Received: (qmail invoked by alias); 27 Jan 2009 22:50:52 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp025) with SMTP; 27 Jan 2009 23:50:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19qGoNOG6NqgtKpM6KUGMeRI5f9RcfLe32nbO1Nj5
	qiuQGg0DdWN4WF
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <83d7aaa40901271441h47c98edepc16f5026de636134@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107412>

Hi,

On Tue, 27 Jan 2009, Geoffrey Lee wrote:

> On Tue, Jan 27, 2009 at 10:24 AM, Stephen Haberman
> <stephen@exigencecorp.com> wrote:
> > It kind of works on my Vista 64-bit system--I do not see the shell
> > extensions in the native Windows Explorer (which is 64 bit), but I do
> > see the shell extensions in an Explorer replacement I use (Xplorer2)
> > that is 32-bit.
> >
> > I've seen other oddities in 32-bit vs. 64-bit programs--e.g. my alt tab
> > replacement (Joe), which is 32-bit, works great with 32-bit programs
> > but cannot remove focus from 64-bit programs (IE, Windows Explorer,
> > etc.). Ironically, very few of the programs I use are 64-bit, so I get
> > by with the alt tab replacement.
> >
> > - Stephen
> >
> 
> Thanks! It seems that 64-bit explorer.exe will not load 32-bit shell
> extensions. At least now I know I'm not going crazy. :)

How could it?  You cannot have 32-bit code and 64-bit code running in the 
same process.  At least not with x86_64 (AFAIK).

Ciao,
Dscho
