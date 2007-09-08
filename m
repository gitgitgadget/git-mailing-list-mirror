From: Jeff King <peff@peff.net>
Subject: Re: how to export git repository?
Date: Sat, 8 Sep 2007 11:08:02 -0400
Message-ID: <20070908150802.GA22186@coredump.intra.peff.net>
References: <20070908145555.GA24132@pu100877.student.princeton.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tamas K Papp <tpapp@Princeton.EDU>
X-From: git-owner@vger.kernel.org Sat Sep 08 17:08:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IU1ut-0006Js-Rv
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 17:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753027AbXIHPIH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 11:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753020AbXIHPIF
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 11:08:05 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1974 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752896AbXIHPIF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 11:08:05 -0400
Received: (qmail 5099 invoked by uid 111); 8 Sep 2007 15:08:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 08 Sep 2007 11:08:04 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Sep 2007 11:08:02 -0400
Content-Disposition: inline
In-Reply-To: <20070908145555.GA24132@pu100877.student.princeton.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58128>

On Sat, Sep 08, 2007 at 04:55:55PM +0200, Tamas K Papp wrote:

> Sorry, but I didn't find this in the documentation.  How can I export
> the contents of a repository (just the files, not the version control
> information)?
> 
> I am looking for something similar to svn export.

Try "git-archive".

-Peff
