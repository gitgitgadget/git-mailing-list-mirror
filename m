From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] Make tig call the correct git config command
Date: Wed, 18 Feb 2009 12:29:14 +0100
Message-ID: <20090218112914.GA7672@diku.dk>
References: <237967ef0902072346x4537f70dua37ba897fac99361@mail.gmail.com> <237967ef0902072349t784e1519m3561ef02545a72de@mail.gmail.com> <2c6b72b30902080156u3b8ba41m736bffaa7b6f15e9@mail.gmail.com> <e51f4f550902180312y3e1999e8x5ff119516cd9bbae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mikael Magnusson <mikachu@gmail.com>, git@vger.kernel.org
To: Kris Shannon <kris@shannon.id.au>
X-From: git-owner@vger.kernel.org Wed Feb 18 12:30:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZkda-0002Rc-88
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 12:30:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbZBRL3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 06:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbZBRL3S
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 06:29:18 -0500
Received: from mgw2.diku.dk ([130.225.96.92]:48301 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751028AbZBRL3R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 06:29:17 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 193B419BB8A;
	Wed, 18 Feb 2009 12:29:16 +0100 (CET)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 31890-12; Wed, 18 Feb 2009 12:29:14 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id D4FE719BB65;
	Wed, 18 Feb 2009 12:29:14 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 18A726DF835; Wed, 18 Feb 2009 12:27:13 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id BB2D739AA06; Wed, 18 Feb 2009 12:29:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <e51f4f550902180312y3e1999e8x5ff119516cd9bbae@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110527>

Kris Shannon <kris@shannon.id.au> wrote Wed, Feb 18, 2009:
> 2009/2/8 Jonas Fonseca <fonseca@diku.dk>
> > I wonder if this check in configure should not be removed anyway,
> > since it is starting to be a long time since git-repo-config was
> > renamed.
> 
> Speaking from a packaging standpoint,  as this is the only reason
> git-core is a build dependency I would vote to get rid of it.
> 
> (I currently already patch the configure so I can build without git-core
> installed)

Where can I get your patch?

-- 
Jonas Fonseca
