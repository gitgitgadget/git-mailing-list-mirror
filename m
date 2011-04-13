From: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] format-patch: document --quiet option
Date: Wed, 13 Apr 2011 11:29:20 +0200
Message-ID: <20110413092920.GB3649@bee.lab.cmartin.tk>
References: <1302622538-7535-1-git-send-email-cmn@elego.de>
 <4DA36D95.6060108@windriver.com>
 <7v8vvgv5dm.fsf@alter.siamese.dyndns.org>
 <1302623497-7658-1-git-send-email-cmn@elego.de>
 <7vfwpnp9uf.fsf@alter.siamese.dyndns.org>
 <7v8vvfp7rd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 11:29:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9wO7-0000kz-PG
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 11:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758089Ab1DMJ3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 05:29:22 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:51225 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758010Ab1DMJ3V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 05:29:21 -0400
Received: from bee.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 4E2ED4612C;
	Wed, 13 Apr 2011 11:29:07 +0200 (CEST)
Received: (nullmailer pid 10452 invoked by uid 1000);
	Wed, 13 Apr 2011 09:29:20 -0000
Content-Disposition: inline
In-Reply-To: <7v8vvfp7rd.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171437>

On Tue, Apr 12, 2011 at 12:52:22PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> @@ -192,6 +192,9 @@ will want to ensure that threading is disabled for `git send-email`.
> >>  	filenames, use specified suffix.  A common alternative is
> >>  	`--suffix=.txt`.  Leaving this empty will remove the `.patch`
> >>  	suffix.
> >> +
> >> +--quiet::
> >> +	Do not print the patch names to standard output.
> >
> > I see "filenames" in the context and that is "generated filenames".
> > ...
> 
> Also the existing "Note that ..." that followed your added lines actually
> belong to the description of the previous item.  Thusly....
> 

 Oops, sorry. I blindly took the indentation change to mean it was
 something unrelated. Thanks for fixing it.

   cmn
