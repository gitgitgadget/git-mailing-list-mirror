From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [PATCH] MSVC: link dynamically to the CRT
Date: Sat, 3 May 2014 10:30:02 +0400
Message-ID: <20140503063001.GA8433@seldon>
References: <20140429102509.GA16706@camelia.ucw.cz>
 <xmqqa9b2fyve.fsf@gitster.dls.corp.google.com>
 <536150E8.20809@gmail.com>
 <xmqqha5aegpk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Stepan Kasal <kasal@ucw.cz>,
	GIT Mailing-list <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 03 08:30:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgTSm-0001xK-T5
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 08:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbaECGaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 02:30:11 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:36264 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbaECGaK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 02:30:10 -0400
Received: from marat by slonopotamus.org with local (Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WgTSU-0002Ca-8o; Sat, 03 May 2014 10:30:02 +0400
Content-Disposition: inline
In-Reply-To: <xmqqha5aegpk.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248020>

On Wed, Apr 30, 2014 at 12:54:15PM -0700, Junio C Hamano wrote:
> Sebastian Schuberth <sschuberth@gmail.com> writes:
> 
> > On 30.04.2014 20:36, Junio C Hamano wrote:
> >
> >> I am not intimate with the msysgit developer community, and I do not
> >> know if it is appropriate for me to respond with a
> >>
> >> 	Does this look OK with msysgit folks?
> >
> > This patch has been carried in the msysgit tree since more than 3
> > years, although strictly speaking it does not affect the msysgit build
> > but only the MSVC build. Stefan is just bringing Karsten's patch
> > upstream with this patch.
> >
> > So yes, this is fine.
> >
> >> cc'ed to the usual suspects (Erik Faye-Lund, Dscho and J6t).  Just
> >> like I do not have to ask "does this look ok?" question when seeing
> >> a patch from Erik or J6t, is it unnecessary for me to do so for a
> >> patch from you?
> >
> > I'm putting Marat in CC who has been recently active in building Git
> > with MSVC.
> 
> Thanks, very much appreciated.

Ack from me, sorry for delay.
