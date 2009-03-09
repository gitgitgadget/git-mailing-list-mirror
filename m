From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] Move push logic to transport.c
Date: Mon, 9 Mar 2009 10:14:58 -0400
Message-ID: <20090309141457.GA20708@coredump.intra.peff.net>
References: <alpine.LNX.1.00.0903082046280.19665@iabervon.org> <alpine.DEB.1.00.0903091033330.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 09 15:16:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LggHg-0003Th-Rx
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 15:16:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbZCIOPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 10:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbZCIOPR
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 10:15:17 -0400
Received: from peff.net ([208.65.91.99]:58577 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751376AbZCIOPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 10:15:16 -0400
Received: (qmail 1292 invoked by uid 107); 9 Mar 2009 14:15:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 09 Mar 2009 10:15:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Mar 2009 10:14:58 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0903091033330.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112696>

On Mon, Mar 09, 2009 at 10:35:45AM +0100, Johannes Schindelin wrote:

> BTW thanks for the patch, I guess it will help Peff to complete "push 
> --track" properly ;-)

If I wait long enough, maybe my original patch will Just Work. ;)

-Peff
