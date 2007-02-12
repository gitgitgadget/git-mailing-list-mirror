From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: add negative -p to git-am, Re: Merge git-gui into 1.5.0 ?
Date: Mon, 12 Feb 2007 14:26:07 +0200
Message-ID: <20070212122607.GC15526@mellanox.co.il>
References: <Pine.LNX.4.63.0702121304450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 12 13:25:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGaFi-0003YE-3B
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 13:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbXBLMZr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 07:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbXBLMZr
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 07:25:47 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:33508 "EHLO
	dev.mellanox.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964893AbXBLMZq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 07:25:46 -0500
Received: from mellanox.co.il ([194.90.237.34])
	by dev.mellanox.co.il (8.13.1/8.13.1) with SMTP id l1CCPVkj008093;
	Mon, 12 Feb 2007 14:25:31 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Mon, 12 Feb 2007 14:26:07 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702121304450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39400>

> > > > Make git-am support "negative strip-level" patches by running it in a 
> > > > subdirectory.
> > > 
> > > I'd rather hide this behind a command line switch to git-am, since it _is_ 
> > > a feature that you do not have to cd to the repo root when git-am'ing 
> > > correct patches.
> > 
> > Maybe it *could* be a nice feature, but it does *not* currently work,
> 
> yes, I read your email. My point was more to allow both use cases, and 
> hide the more obscure one behind an option.

I guess one person's obscure case is the other's common one.

-- 
MST
