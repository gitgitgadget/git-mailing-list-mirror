From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: setting up tracking on push
Date: Fri, 6 Mar 2009 11:45:56 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903061144480.10279@pacific.mpi-cbg.de>
References: <buofxhr2vta.fsf@dhlpc061.dev.necel.com> <76718490903052049k217e9c12gb7881f8904fdd9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-312304581-1236336357=:10279"
Cc: Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 11:46:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfXYy-0006Nl-AR
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 11:45:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753760AbZCFKo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 05:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752960AbZCFKo2
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 05:44:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:35905 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750896AbZCFKo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 05:44:28 -0500
Received: (qmail invoked by alias); 06 Mar 2009 10:44:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp024) with SMTP; 06 Mar 2009 11:44:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/5EA1OvLr5hAJYYmuXY1iyNproSw9MJQIITJJO/T
	TJMV6Rn7vt/+V1
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <76718490903052049k217e9c12gb7881f8904fdd9d@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112419>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-312304581-1236336357=:10279
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 5 Mar 2009, Jay Soffian wrote:

> On Thu, Mar 5, 2009 at 10:07 PM, Miles Bader <miles@gnu.org> wrote:
> > I vaguely feel like I should be able to do:
> >
> >  git push --track origin grognul
> 
> Hmm, I vaguely remember seeing a patch come across the list to do this.

Indeed.

http://search.gmane.org/?query=push+track&group=gmane.comp.version-control.git

Summary for the lazy: it needs a lot of work to be implemented properly.

Hth,
Dscho

--8323328-312304581-1236336357=:10279--
