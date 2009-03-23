From: Jeff King <peff@peff.net>
Subject: Re: Git for Windows 1.6.2.1-preview20090322
Date: Sun, 22 Mar 2009 22:53:58 -0400
Message-ID: <20090323025358.GA19717@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0903080132470.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903222149330.10279@pacific.mpi-cbg.de> <20090322225315.GC22428@sigill.intra.peff.net> <alpine.DEB.1.00.0903230015020.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 23 03:55:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlaK6-00086k-19
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 03:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755472AbZCWCyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 22:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755398AbZCWCyF
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 22:54:05 -0400
Received: from peff.net ([208.65.91.99]:37950 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755350AbZCWCyE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 22:54:04 -0400
Received: (qmail 18366 invoked by uid 107); 23 Mar 2009 02:54:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 22 Mar 2009 22:54:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Mar 2009 22:53:58 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0903230015020.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114236>

On Mon, Mar 23, 2009 at 12:25:57AM +0100, Johannes Schindelin wrote:

> > A few people have asked about filter-branch on Windows recently;
> 
> I am not aware of any.  But then, I think nobody mentioned it on the 
> msysgit list (which would be the correct place), and I am likely to have 
> missed it if it was sent elsewhere.

They were less feature request and more mentioned in the middle of other
discussions. I am thinking specifically of:

  http://thread.gmane.org/gmane.comp.version-control.git/112253/focus=112439
  http://thread.gmane.org/gmane.comp.version-control.git/111722/focus=112103

> Actually, not only Hannes' version runs the test t7003 okay, but also 
> 4msysgit's version.
> 
> But let's reduce the differences between git.git and 4msysgit.git further 
> first.

OK. I just wanted to make you aware of the existing threads and Hannes'
message, since as you mentioned they _weren't_ on the msysgit list.

-Peff
