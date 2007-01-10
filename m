From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Provide better feedback for the untracked only case in status output
Date: Wed, 10 Jan 2007 17:29:15 -0500
Message-ID: <20070110222914.GA22838@coredump.intra.peff.net>
References: <1168452977.19643.57.camel@ibook.zvpunry.de> <11684679032630-git-send-email-j.ruehle@bmiag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	=?iso-8859-1?Q?J=FCrgen_R=FChle?= <j-r@online.de>
X-From: git-owner@vger.kernel.org Wed Jan 10 23:29:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4lwo-0004Cu-LP
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 23:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbXAJW3U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 17:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbXAJW3U
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 17:29:20 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4883 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965133AbXAJW3T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 17:29:19 -0500
Received: (qmail 25124 invoked from network); 10 Jan 2007 17:29:30 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 10 Jan 2007 17:29:30 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jan 2007 17:29:15 -0500
To: Juergen Ruehle <j.ruehle@bmiag.de>
Content-Disposition: inline
In-Reply-To: <11684679032630-git-send-email-j.ruehle@bmiag.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36535>

On Wed, Jan 10, 2007 at 11:25:03PM +0100, Juergen Ruehle wrote:

>    - Patches to other files that contain these messages verbatim
>      (AFAICS this affects only the git-reset man page, tutorial-2 and the VIM
>       syntax highlighting)

I have been tracking these changes for the vim highlighting, but have
been waiting for things to settle before sending a patch (which should
hopefully go into v1.5.0, but I will wait until this is finalized).

-Peff
