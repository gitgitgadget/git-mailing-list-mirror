From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: German translation of git man pages
Date: Wed, 30 Jul 2008 14:25:10 +0200
Message-ID: <20080730122510.GD8767@leksak.fem-net>
References: <1217408012.9486.13.camel@hydra.esse.ch> <1217418938.6924.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fabio Scotoni <fabio@esse.ch>, git@vger.kernel.org
To: Matthias Kestenholz <mk@spinlock.ch>
X-From: git-owner@vger.kernel.org Wed Jul 30 14:26:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOAkx-0002j7-Nd
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 14:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755204AbYG3MZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 08:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752852AbYG3MZO
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 08:25:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:58962 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755204AbYG3MZN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 08:25:13 -0400
Received: (qmail invoked by alias); 30 Jul 2008 12:25:11 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp056) with SMTP; 30 Jul 2008 14:25:11 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19oWKQC8gJoNNpUUor/qCQ3ZQLvMHDao3LLFJhjOq
	05CDaXKGFINj20
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KOAju-0002n7-RA; Wed, 30 Jul 2008 14:25:10 +0200
Content-Disposition: inline
In-Reply-To: <1217418938.6924.2.camel@localhost>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90774>

Hi,

Matthias Kestenholz wrote:
> On Wed, 2008-07-30 at 10:53 +0200, Fabio Scotoni wrote:
> > Hello,
> > 
> > I'm currently trying to translate the git man pages into german, as some
> > of my co-developers want to stick with svn. Of course, I could use
> > git-svn, but it's not what i want. Our svn server crashed two times and
> > we lost the history two times.
> > 
> > Our native language is german and they don't like to read english
> > documentation. I already started translating but have some problems:
> > Should i translate "branch" with the appropriate german word or keep it
> > english? This is a Problem for "pull" "push" and the other actions as
> > well. Basically it's possible to copy words, but that isn't very
> > esthetical.
> 
> There was a long discussion some months ago on this list concering the
> localization of git-gui into german.

The link is:
http://thread.gmane.org/gmane.comp.version-control.git/80936/focus=81031

The selected mail also has two further pointers with some discussion.

> Maybe you'll find some inspiration here:
> http://git.kernel.org/?p=git/git.git;a=blob;f=git-gui/po/de.po;hb=HEAD
> 
> It would probably be very worthwile to follow the translations there
> because users of git-gui will feel at home at once instead of having to
> re-learn things.

The glossary may also be a good help:
http://git.kernel.org/?p=git/git.git;a=blob;f=git-gui/po/glossary/de.po

Regards.

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
