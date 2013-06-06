From: David Lang <david@lang.hm>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Thu, 6 Jun 2013 09:09:20 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1306060904100.13204@nftneq.ynat.uz>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <7va9n52zjc.fsf@alter.siamese.dyndns.org> <rmivc5rp9w2.fsf@fnord.ir.bbn.com> <CAMP44s07p0vpS_2cjAjB=QWoZjjPSuAm09xwk4BjAAD+hsJrSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Greg Troxel <gdt@ir.bbn.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c?= <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 19:13:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkdkX-0006qq-3J
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 19:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755Ab3FFRNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 13:13:17 -0400
Received: from mail.lang.hm ([64.81.33.126]:36420 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751264Ab3FFRNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 13:13:16 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id r56HADRt032617;
	Thu, 6 Jun 2013 10:10:13 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <CAMP44s07p0vpS_2cjAjB=QWoZjjPSuAm09xwk4BjAAD+hsJrSw@mail.gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226513>

On Thu, 6 Jun 2013, Felipe Contreras wrote:

> In the end my point remains unchanged; Perl is declining, so it would
> be wise for the future to use another scripting language instead.

Perl use may or may not be declining (depending on how you measure it), but are 
you really willing to take on the task of re-writing everything that's in Perl 
into another language and force all developers of scripts to learn that other 
language? what's the ROI of this?

Perl isn't going to disappear any time soon. What makes you think that whatever 
language you pick to replace Perl is going to be more stable than Perl is?

and, like the parent poster, by 'stable' I mean from the compatibility point of 
view.

What are the odds that the 'newer' language that you pick is going to pull a 
"python 3" on you?

There have been a very large number of scripting languages show up, make a lot 
of press, and then fade in favor of other languages while Perl has continued. 
It's not the sexy languange nowdays, but it's there, reliable, and used so 
heavily that there's really no chance of it dissapearing in the forseable 
future.

David Lang
