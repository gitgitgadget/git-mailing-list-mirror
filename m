From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Mailing lists, was Re: [RFC] Git User's Survey 2008
Date: Sat, 26 Jul 2008 21:06:42 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807262103410.26810@eeepc-johanness>
References: <200807230325.04184.jnareb@gmail.com> <m38wvovbh2.fsf@localhost.localdomain> <20080726175121.GA15015@spearce.org> <200807262017.04413.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jing Xue <jingxue@digizenstudio.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 21:09:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMp8r-0002sd-OP
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 21:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbYGZTFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 15:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752051AbYGZTFk
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 15:05:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:41154 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750928AbYGZTFk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 15:05:40 -0400
Received: (qmail invoked by alias); 26 Jul 2008 19:05:38 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp049) with SMTP; 26 Jul 2008 21:05:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19jDKhbybRjvLwYmbWUiNgLcRRIzElXaIFM5uBHXM
	Hk96x8aHZr7hX6
X-X-Sender: user@eeepc-johanness
In-Reply-To: <200807262017.04413.jnareb@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90274>

Hi,

On Sat, 26 Jul 2008, Jakub Narebski wrote:

> It looks like alternate Git implementation are cropping left and right:
> jgit in Java, widgit/Git-R-Done and git# GSoC Mono project in C#,...
> but not all of them maturing.

Seems as if git# is actively worked on, by a user called "igfgt1".  See

	http://code.google.com/p/mono-soc-2008/source/browse/

However, it appears that the same problem as last year is happening: no 
communication with those that could help -- us.  For example, the latest 
change in git# adds a method to "Blob" that returns the content.  Which is 
obviously read once, never to be freed.

I know that it is unfair to rant here, but on the other hand: it is not my 
itch, and I have tons of other stuff to do.

Ciao,
Dscho
