From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Mailing lists, was Re: [RFC] Git User's Survey 2008
Date: Fri, 25 Jul 2008 16:57:07 -0500
Message-ID: <20080725215707.GC23202@spearce.org>
References: <200807230325.04184.jnareb@gmail.com> <20080725172313.GE21117@spearce.org> <7vr69hsss1.fsf@gitster.siamese.dyndns.org> <200807252352.09751.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 23:58:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMVIh-00041R-3J
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 23:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbYGYV5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 17:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbYGYV5I
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 17:57:08 -0400
Received: from george.spearce.org ([209.20.77.23]:57843 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbYGYV5I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 17:57:08 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2D567383A5; Fri, 25 Jul 2008 21:57:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200807252352.09751.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90126>

Jakub Narebski <jnareb@gmail.com> wrote:
> On Fri, 25 Jul 2008, Junio C Hamano wrote:
> > 
> > What I meant was that we might want to have a few more questions about
> > e/jgit as an independent entity in the survey, as it is a completely
> > different re-implementation of the same git theme.
> 
> There are two questions about egit/jgit planned for the survey:
> 
>    16. Which porcelains / interfaces / implementations do you use?
>        (zero or more: multiple choice)
>      - core-git, Cogito (deprecated), StGIT, Guilt, pg (deprecated),
>        Pyrite, Easy Git, IsiSetup, _jgit_, my own scripts, other(*)

pg should come out of this list in this version of the survey.
It never had a large user base and all of those users should have
moved away to something else by now.

Cogito has also been deprecated, and maybe should be removed from
the list, but it did have a larger user base so maybe we keep it
on this survey and we remove it from the next?

>    27. Which of the following features do you use?
>        (zero or more: multiple choice)
>      - Integration with IDE/editor (Eclipse, Emacs, TextMate,...)
>        ...
> 
> What question about egit/jgit would you like to have in the survey?

I'm not certain what else I would want to ask that is egit/jgit
specific.

-- 
Shawn.
