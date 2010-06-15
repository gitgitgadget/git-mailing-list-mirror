From: Petr Baudis <pasky@suse.cz>
Subject: Re: [GSoC update] Splitting gitweb & developing write
 functionalities
Date: Tue, 15 Jun 2010 22:57:55 +0200
Message-ID: <20100615205755.GJ3109@machine.or.cz>
References: <AANLkTikapZa0N7xroxhdlmm7LUvlNp-7GZy7XeG-zprC@mail.gmail.com>
 <20100615201720.GI3109@machine.or.cz>
 <AANLkTinfJOOT8NJ942bB_Sil4sGNthpk9hxvA60Y_iGB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 15 22:58:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOdCw-0008Lj-F3
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 22:58:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451Ab0FOU6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 16:58:00 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37574 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758443Ab0FOU57 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 16:57:59 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id CD58686208F; Tue, 15 Jun 2010 22:57:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTinfJOOT8NJ942bB_Sil4sGNthpk9hxvA60Y_iGB@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149224>

  Hi!

On Wed, Jun 16, 2010 at 02:03:50AM +0530, Pavan Kumar Sunkara wrote:
> >> gitweb: Create Gitweb::View module [Work in Progress]
> >
> > (Is this the Gitweb::HTML module? Why have you renamed it?)
> Yeah I thought it would be better if I have this named as View rather
> than HTML :)

  I'm just a bit surprised since I have thought we have agreed that
Gitweb::View is much more misleading name for what Gitweb::HTML actually
is, hinting at a MVC structure that simply is not there at any level.
You are welcome to differ in opinion but then I would expect you to
continue that discussion. :-)

-- 
				Petr "Pasky" Baudis
The true meaning of life is to plant a tree under whose shade
you will never sit.
