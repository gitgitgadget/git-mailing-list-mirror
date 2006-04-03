From: Jeff King <peff@peff.net>
Subject: Re: parsecvs tool now creates git repositories
Date: Mon, 3 Apr 2006 11:32:33 -0400
Message-ID: <20060403153233.GA6631@sigio.intra.peff.net>
References: <1143956188.2303.39.camel@neko.keithp.com> <20060403140348.GE16823@harddisk-recovery.com> <1144075047.2303.97.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Apr 03 17:32:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQR2q-0003Lb-Gy
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 17:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbWDCPcm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 11:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbWDCPcm
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 11:32:42 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:17364 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S1751726AbWDCPcl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 11:32:41 -0400
Received: (qmail 51727 invoked from network); 3 Apr 2006 15:32:34 -0000
Received: from unknown (HELO sigio.intra.peff.net) (10.0.0.10)
  by 0 with SMTP; 3 Apr 2006 15:32:34 -0000
Received: by sigio.intra.peff.net (sSMTP sendmail emulation); Mon,  3 Apr 2006 11:32:34 -0400
To: Git Mailing List <git@vger.kernel.org>
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1144075047.2303.97.camel@neko.keithp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18338>

On Mon, Apr 03, 2006 at 07:37:27AM -0700, Keith Packard wrote:

> You can't. You need to create a local copy of the repository. There is a
> tool which can do that using the cvs protocol, but I don't recall the
> name.

I believe you're thinking of CVSSuck:
  http://cvs.m17n.org/~akr/cvssuck/

-Peff
