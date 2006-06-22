From: Jeff King <peff@peff.net>
Subject: Re: git pull w/o checkout?
Date: Thu, 22 Jun 2006 09:13:44 -0400
Message-ID: <20060622131344.GA7168@coredump.intra.peff.net>
References: <E65F8DB5-677B-4C7B-A4EC-5F6FB76D6E9A@kernel.crashing.org> <20060622130523.GA6893@coredump.intra.peff.net> <E333ADD9-1096-4137-9D72-D58A8E2A5582@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 15:15:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtP0c-00048g-AW
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 15:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161075AbWFVNNr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 09:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030635AbWFVNNr
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 09:13:47 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:11689 "HELO
	peff.net") by vger.kernel.org with SMTP id S1030634AbWFVNNq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 09:13:46 -0400
Received: (qmail 21850 invoked from network); 22 Jun 2006 09:13:26 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 22 Jun 2006 09:13:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Jun 2006 09:13:44 -0400
To: Kumar Gala <galak@kernel.crashing.org>
Mail-Followup-To: Kumar Gala <galak@kernel.crashing.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <E333ADD9-1096-4137-9D72-D58A8E2A5582@kernel.crashing.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22331>

On Thu, Jun 22, 2006 at 08:10:10AM -0500, Kumar Gala wrote:

> >git-fetch?
> Its the first half, still need to resolve FETCH_HEAD, HEAD, etc..

Can you elaborate on what you're trying to accomplish?

-Peff
