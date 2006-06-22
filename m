From: Jeff King <peff@peff.net>
Subject: Re: git pull w/o checkout?
Date: Thu, 22 Jun 2006 09:05:24 -0400
Message-ID: <20060622130523.GA6893@coredump.intra.peff.net>
References: <E65F8DB5-677B-4C7B-A4EC-5F6FB76D6E9A@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 15:05:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtOsG-0002jM-2m
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 15:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbWFVNF0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 09:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbWFVNF0
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 09:05:26 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:32152 "HELO
	peff.net") by vger.kernel.org with SMTP id S1030210AbWFVNFZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 09:05:25 -0400
Received: (qmail 21442 invoked from network); 22 Jun 2006 09:05:05 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 22 Jun 2006 09:05:05 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Jun 2006 09:05:24 -0400
To: Kumar Gala <galak@kernel.crashing.org>
Mail-Followup-To: Kumar Gala <galak@kernel.crashing.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <E65F8DB5-677B-4C7B-A4EC-5F6FB76D6E9A@kernel.crashing.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22327>

On Thu, Jun 22, 2006 at 07:51:56AM -0500, Kumar Gala wrote:

> I trying to see if there is a way to get the effect of a git-pull w/o  
> getting the checked out files.

git-fetch?

-Peff
