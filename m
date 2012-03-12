From: Willy Tarreau <w@1wt.eu>
Subject: Re: stripping [PATCH] without losing later tags from mailed patches (Re: [ 02/12] Remove COMPAT_IA32 support)
Date: Mon, 12 Mar 2012 17:48:12 +0100
Message-ID: <20120312164812.GC12405@1wt.eu>
References: <20120312002046.041448832@1wt.eu> <1331514446.3022.140.camel@deadeye> <20120312024948.GB4650@kroah.com> <20120312063027.GB8971@1wt.eu> <20120312064855.GB16820@burratino> <20120312085820.GA11569@1wt.eu> <20120312152004.GB9380@kroah.com> <7vfwddu60f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg KH <greg@kroah.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Mon Mar 12 17:48:52 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1S78QV-0001NI-6I
	for glk-linux-kernel-3@plane.gmane.org; Mon, 12 Mar 2012 17:48:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140Ab2CLQsk (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 12 Mar 2012 12:48:40 -0400
Received: from 1wt.eu ([62.212.114.60]:63184 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752343Ab2CLQsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Mar 2012 12:48:37 -0400
Received: (from willy@localhost)
	by mail.home.local (8.14.4/8.14.4/Submit) id q2CGmCJM014004;
	Mon, 12 Mar 2012 17:48:12 +0100
Content-Disposition: inline
In-Reply-To: <7vfwddu60f.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192906>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192906>

Hi Junio,

On Mon, Mar 12, 2012 at 09:40:48AM -0700, Junio C Hamano wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > I don't see a -b option to 'git am' in the manpage, am I missing
> > something here?
> 
> As this is a recent enhancement, it is very much appreciated if you
> try out 1.7.10-rc0 (or 'master').

I've just backported it to 1.7.9.3 (I'm not keen on living on the bleeding
edge with my everyday tools), and it works nicely as expected.

Thanks!
Willy
