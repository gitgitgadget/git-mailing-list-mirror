From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [klibc] [PATCH] am: Allow passing exclude and include args to
	apply
Date: Sun, 19 Dec 2010 18:26:57 +0100
Message-ID: <20101219172657.GA9564@merkur.ravnborg.org>
References: <1292775461-26762-1-git-send-email-max@stro.at> <AANLkTik5-oJYsfEoeYjy8E9v4T4_7VBsoGnqg7oXwnbC@mail.gmail.com> <20101219171313.GI17034@vostochny.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thiago Farina <tfransosi@gmail.com>, klibc@zytor.com,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: maximilian attems <max@stro.at>
X-From: git-owner@vger.kernel.org Sun Dec 19 18:51:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUNQI-0001mV-02
	for gcvg-git-2@lo.gmane.org; Sun, 19 Dec 2010 18:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340Ab0LSRvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Dec 2010 12:51:48 -0500
Received: from pqueueb.post.tele.dk ([193.162.153.10]:45663 "EHLO
	pqueueb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932137Ab0LSRvs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Dec 2010 12:51:48 -0500
X-Greylist: delayed 1462 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Dec 2010 12:51:47 EST
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by pqueueb.post.tele.dk (Postfix) with ESMTP id BE32D812C
	for <git@vger.kernel.org>; Sun, 19 Dec 2010 18:27:24 +0100 (CET)
Received: from merkur.ravnborg.org (x1-6-00-1e-2a-84-ae-3e.k225.webspeed.dk [80.163.61.94])
	by pfepb.post.tele.dk (Postfix) with ESMTP id 13680F84038;
	Sun, 19 Dec 2010 18:26:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20101219171313.GI17034@vostochny.stro.at>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163962>

On Sun, Dec 19, 2010 at 05:13:13PM +0000, maximilian attems wrote:
> On Sun, Dec 19, 2010 at 02:56:58PM -0200, Thiago Farina wrote:
> > On Sun, Dec 19, 2010 at 2:17 PM, maximilian attems <max@stro.at> wrote:
> > > When porting patches from dash git to klibc git,
> > > where dash has a different directory structure those
> > > switches are handy:
> > > Exported with format-patch on dash side and used am
> > > as import for klibc side.
> > >
> > 
> > I don't know, but this commit message doesn't look good. Can you be
> > more specific about what the patch does, and what it's trying to fix.
> 
> hmm, it does what the subject says. (:
> have you ever used `git am'?
> 
...
> Please be more specific on what's missing? Your personal taste is
> unknown to me and not of importance.

I had to read it twice to get it..
Most likely because I read the changelog without reading the title first.

	Sam
