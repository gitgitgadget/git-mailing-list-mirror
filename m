From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Re: Teach mailinfo to ignore everything before -- >8 --
 mark
Date: Wed, 26 Aug 2009 11:00:52 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908261059530.4713@intel-tinevez-2-302>
References: <7v3a7g501e.fsf@alter.siamese.dyndns.org> <fc2ecb5cf28cabb7d183e2835ce46aa9afb2a322.1251215299.git.nicolas.s.dev@gmx.fr> <7vvdkbl4ul.fsf@alter.siamese.dyndns.org> <7veiqzjmy7.fsf@alter.siamese.dyndns.org> <20090826050224.GK3526@vidovic>
 <h72td7$cu6$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1488627427-1251277253=:4713"
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 11:01:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgENL-0002OQ-Cj
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 11:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754260AbZHZJAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 05:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755461AbZHZJAx
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 05:00:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:37714 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754179AbZHZJAw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 05:00:52 -0400
Received: (qmail invoked by alias); 26 Aug 2009 09:00:53 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp069) with SMTP; 26 Aug 2009 11:00:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/2hmcOKGz2PkSvLZBd+Z1aeFDNYOXVs+7U7JP9jY
	kMs5NA356RrDHO
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <h72td7$cu6$1@ger.gmane.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127072>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1488627427-1251277253=:4713
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 26 Aug 2009, Jakub Narebski wrote:

> Nicolas Sebrecht wrote:
> 
> > For people who _really_ want to obey to scissors by default I'll add 
> > an option to git-config. Whithout more comments, I'll add
> > 
> >   scissors.obey
> 
> mailsplit.scissors

Sorry, did not have time to read this thread properly, but has anybody put 
thought into the interaction between this patch and "git rebase" (which 
uses "git am", and therefore mailsplit, internally)?

Ciao,
Dscho

--8323329-1488627427-1251277253=:4713--
