From: John Goerzen <jgoerzen@complete.org>
Subject: Re: [PATCH] Fix dcommit, rebase when rewriteRoot is in use
Date: Sat, 8 Mar 2008 16:04:18 -0600
Message-ID: <200803081604.18675.jgoerzen@complete.org>
References: <1205006470-18882-1-git-send-email-jgoerzen@complete.org> <alpine.LSU.1.00.0803082231540.3975@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, normalperson@yhbt.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 08 23:05:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY7Au-0007ch-C2
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 23:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbYCHWEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 17:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbYCHWEl
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 17:04:41 -0500
Received: from b01s02mr.corenetworks.net ([64.85.160.192]:34913 "EHLO
	glockenspiel.complete.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbYCHWEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 17:04:25 -0500
Received: from 63-245-179-205.kitusa.com ([63.245.179.205] helo=erwin.lan.complete.org)
	by glockenspiel.complete.org with esmtps
	(with TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(TLS peer CN erwin.complete.org, certificate verified)
	(Exim 4.63)
	id 1JY79S-0007ef-JS; Sat, 08 Mar 2008 16:04:24 -0600
Received: from katherina.lan.complete.org ([10.200.0.4])
	by erwin.lan.complete.org with esmtps
	(with TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(No TLS peer certificate)
	(Exim 4.67)
	id 1JY79O-0008Py-UN; Sat, 08 Mar 2008 16:04:19 -0600
Received: from jgoerzen by katherina.lan.complete.org with local (Exim 4.69)
	(envelope-from <jgoerzen@complete.org>)
	id 1JY79O-0005oP-MM; Sat, 08 Mar 2008 16:04:18 -0600
User-Agent: KMail/1.9.7
In-Reply-To: <alpine.LSU.1.00.0803082231540.3975@racer.site>
Content-Disposition: inline
X-Spam-Status: No (score 0.1): AWL=0.053
X-Virus-Scanned: by Exiscan on glockenspiel.complete.org at Sat, 08 Mar 2008 16:04:24 -0600
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76591>

On Saturday 08 March 2008 3:32:20 pm Johannes Schindelin wrote:
> Hi,
>
> On Sat, 8 Mar 2008, John Goerzen wrote:
> > Problem described here:
> >
> > http://thread.gmane.org/gmane.comp.version-control.git/76561
> >
> > Signed-off-by: John Goerzen <jgoerzen@complete.org>
>
> That is not a good commit message.
>
> Hth,
> Dscho

Thanks, folks.  I have sent a new patch with a longer explanation.
