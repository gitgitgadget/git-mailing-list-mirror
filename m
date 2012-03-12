From: Willy Tarreau <w@1wt.eu>
Subject: Re: stripping [PATCH] without losing later tags from mailed patches (Re: [ 02/12] Remove COMPAT_IA32 support)
Date: Mon, 12 Mar 2012 21:19:15 +0100
Message-ID: <20120312201915.GK12405@1wt.eu>
References: <1331514446.3022.140.camel@deadeye> <20120312024948.GB4650@kroah.com> <20120312063027.GB8971@1wt.eu> <20120312064855.GB16820@burratino> <20120312085820.GA11569@1wt.eu> <20120312152004.GB9380@kroah.com> <7vfwddu60f.fsf@alter.siamese.dyndns.org> <20120312171257.GA25347@kroah.com> <7vzkblsnos.fsf@alter.siamese.dyndns.org> <20120312192627.GA24873@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Greg KH <greg@kroah.com>
X-From: linux-kernel-owner@vger.kernel.org Mon Mar 12 21:19:45 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1S7BiX-0004DP-Ij
	for glk-linux-kernel-3@plane.gmane.org; Mon, 12 Mar 2012 21:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757195Ab2CLUTc (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 12 Mar 2012 16:19:32 -0400
Received: from 1wt.eu ([62.212.114.60]:63222 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756962Ab2CLUTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Mar 2012 16:19:30 -0400
Received: (from willy@localhost)
	by mail.home.local (8.14.4/8.14.4/Submit) id q2CKJFFw015268;
	Mon, 12 Mar 2012 21:19:15 +0100
Content-Disposition: inline
In-Reply-To: <20120312192627.GA24873@kroah.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192939>

On Mon, Mar 12, 2012 at 12:26:27PM -0700, Greg KH wrote:
> On Mon, Mar 12, 2012 at 11:01:55AM -0700, Junio C Hamano wrote:
> > Greg KH <greg@kroah.com> writes:
> > 
> > > Does the flag propagate from 'git quiltimport'?
> > 
> > I didn't even know the script was shipped as part of the main
> > Porcelain until I looked.  I do not think anybody is maintaining it;
> > the last update was from the 1.6.2 era.
> 
> Ah, so my feeling that I'm the only one using it is true :)

Well, we're two precisely :-)

> > A tested patch from quilt stakeholders is very much welcomed.
> 
> I'll be glad to maintain this if you need me to.  I'll poke around with
> it tomorrow to see what needs to be done here.

That would be great, this tool is really handy.

Cheers,
Willy
