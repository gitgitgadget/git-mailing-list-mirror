From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: ref name troubles, was Re: [PATCH v2] Introduce %<branch> as  
 shortcut to the tracked branch
Date: Fri, 20 Mar 2009 16:01:44 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903201600500.6865@intel-tinevez-2-302>
References: <7vr60ubgul.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de> <20090320004029.GX23521@spearce.org>
 <20090320060545.GB27008@coredump.intra.peff.net> <7vprgc4r6h.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903201029290.10279@pacific.mpi-cbg.de> <20090320111238.GZ8940@machine.or.cz> <alpine.DEB.1.00.0903201245140.6865@intel-tinevez-2-302>
 <20090320115043.GB8940@machine.or.cz> <alpine.DEB.1.00.0903201255230.6865@intel-tinevez-2-302> <49C3A8D7.1040509@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 20 16:03:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkgFh-0002oa-33
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 16:03:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731AbZCTPBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 11:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754647AbZCTPBs
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 11:01:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:50883 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752325AbZCTPBs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 11:01:48 -0400
Received: (qmail invoked by alias); 20 Mar 2009 15:01:45 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp052) with SMTP; 20 Mar 2009 16:01:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1935MgrTNh34JtZRO467PlBMg7wkrud9YMyX786Hj
	5HVpHHMhF3LCTm
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <49C3A8D7.1040509@drmicha.warpmail.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113967>

Hi,

On Fri, 20 Mar 2009, Michael J Gruber wrote:

> Do we have ^ as a prefix yet?

Yes, it means "not".  IOW '^bla blub' is the same as 'bla..blub'.

> Also, I don't think people would use @@ much in branch names.

Whoa...

Ciao,
Dscho
