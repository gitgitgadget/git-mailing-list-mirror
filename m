From: Greg KH <greg@kroah.com>
Subject: Re: how to track multiple upstreams in one repository
Date: Wed, 21 Jan 2009 08:11:31 -0800
Message-ID: <20090121161131.GA22615@kroah.com>
References: <alpine.DEB.1.10.0901181855400.20741@asgard.lang.hm> <20090119021426.GA21999@shion.is.fushizen.net> <alpine.DEB.1.10.0901181957070.20741@asgard.lang.hm> <8e04b5820901182352n29b3885cj850e6ddae6ca237f@mail.gmail.com> <20090120033402.GC8754@kroah.com> <8e04b5820901192329pf44431coce4423e6a8d43198@mail.gmail.com> <20090120120319.GR30710@genesis.frugalware.org> <8e04b5820901210802y1102cfd0q4a3f8812f357c398@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, david@lang.hm,
	Bryan Donlan <bdonlan@fushizen.net>, git@vger.kernel.org
To: "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 17:14:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPfia-0000pv-HY
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 17:14:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752436AbZAUQMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 11:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbZAUQMw
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 11:12:52 -0500
Received: from kroah.org ([198.145.64.141]:60876 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751006AbZAUQMv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 11:12:51 -0500
Received: from localhost (c-76-105-230-205.hsd1.or.comcast.net [76.105.230.205])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by coco.kroah.org (Postfix) with ESMTPSA id 13B5047C58;
	Wed, 21 Jan 2009 08:12:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <8e04b5820901210802y1102cfd0q4a3f8812f357c398@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106623>

On Wed, Jan 21, 2009 at 06:02:51PM +0200, Ciprian Dorin, Craciun wrote:
> On Tue, Jan 20, 2009 at 2:03 PM, Miklos Vajna <vmiklos@frugalware.org> wrote:
> > On Tue, Jan 20, 2009 at 09:29:13AM +0200, "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com> wrote:
> >>     :) This is something that escaped me... Could you give me the
> >> exact git url for this repository? (on kernel.org I'm not able to find
> >> it, just the current one...)
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6-stable.git
> >
> > Have you tried this one?
> 
>     Ok... I'm ashamed... :) :) This is exactly what (we all) were
> looking for... Sorry.
> 
>     Just one curiosity: is this older (I mean if it was created) than
> when 2.6.18 or 19 was released? Because at that time I've searched for
> such a repository, didn't found it and hacked the config as I've said
> previously...

Probably not, but I really don't remember when it was created, sorry.

thanks,

greg k-h
