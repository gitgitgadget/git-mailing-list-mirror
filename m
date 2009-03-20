From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Google Summer of Code 2009: GIT
Date: Fri, 20 Mar 2009 01:30:05 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903200128020.10279@pacific.mpi-cbg.de>
References: <49B74373.3090609@gmail.com>  <alpine.DEB.1.10.0903121052310.16753@asgard.lang.hm>  <ab9fa62a0903121119j6c2a1d43kd9cda99db47b5e7c@mail.gmail.com>  <alpine.DEB.1.10.0903121148540.16753@asgard.lang.hm>  <ab9fa62a0903121200v73ec3522gcdebcd34122efc72@mail.gmail.com>
  <alpine.DEB.1.10.0903121214390.16753@asgard.lang.hm>  <ab9fa62a0903121245m621643bfq3c58557ccc9b266f@mail.gmail.com>  <alpine.DEB.1.10.0903121255040.16753@asgard.lang.hm>  <ab9fa62a0903121303v5a6cbf0ax413cc440b9c32e77@mail.gmail.com> 
 <alpine.DEB.1.00.0903190003100.10279@pacific.mpi-cbg.de> <ab9fa62a0903191217t5d0e6d9cn4915a425ed8084ff@mail.gmail.com> <alpine.DEB.1.00.0903200034230.10279@pacific.mpi-cbg.de> <alpine.DEB.1.10.0903191652500.16753@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: saurabh gupta <saurabhgupta1403@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Fri Mar 20 01:29:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkScH-0007K5-TJ
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 01:29:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754432AbZCTA2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 20:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752312AbZCTA2N
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 20:28:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:39328 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750977AbZCTA2M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 20:28:12 -0400
Received: (qmail invoked by alias); 20 Mar 2009 00:28:07 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp007) with SMTP; 20 Mar 2009 01:28:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/O1l8/IpvOTpeKvC+9Hushr/6xExM+Mwqz4NxN6l
	gZC+qym0suUc0E
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.10.0903191652500.16753@asgard.lang.hm>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113874>

Hi,

On Thu, 19 Mar 2009, david@lang.hm wrote:

> I see good support for XML being a superset of what's needed to support 
> ODF or SVG, not a subset.

No, not at all.  If we can get away with the default 3-way merge of Git, 
the generic XML merge driver be damned.

I'd rather have more file types supported that are useful for the average 
user, than a generic XML merge driver that is useful to only a handful of 
people.

Ciao,
Dscho
