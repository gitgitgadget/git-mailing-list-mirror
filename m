From: Andreas Krey <a.krey@gmx.de>
Subject: Re: Command-line git Vs IDE+plugin?
Date: Mon, 18 Nov 2013 18:47:39 +0100
Message-ID: <20131118174739.GA27105@inner.h.apk.li>
References: <vpqiovpfxd1.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Nov 18 18:47:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViSvN-0003h1-7j
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 18:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557Ab3KRRrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 12:47:46 -0500
Received: from continuum.iocl.org ([217.140.74.2]:55885 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab3KRRrp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 12:47:45 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id rAIHlda27644;
	Mon, 18 Nov 2013 18:47:39 +0100
Content-Disposition: inline
In-Reply-To: <vpqiovpfxd1.fsf@anie.imag.fr>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237994>

On Mon, 18 Nov 2013 18:11:54 +0000, Matthieu Moy wrote:
...
> I was wondering whether others had similar (or not) experience.

Similar. When I used eclipse I didn't even try to use the plugins
and just stayed on the command line. (Well, almost, but back then
jgit couldn't deal with submodules which I needed.)

I have the same experience with the few git GUIs I tried - none
stuck to me. Even 'git gut' hardly made the cut, I stay with
the command line except for gitk which is very useful to see
what you've done.

For people that live in the IDE anyway the mileage will vary,
but for me there is always some extra mismatch to overcode -
I know what the CLI is doing and think in terms of these
operations, and I'd need to understand what the GUI is thinkig
to be good for me (i.e. how operations are implemented there);
for me it always fells like a mist over the repo.

And I know that I'm missing on some features - the integration of history
examination into codebrowsing schoould be a good thing.

Still, if you show them eclipse, I'd also show them the git integration
in there. I dread the moment I have to show someone how to merge a pull
(or any merge) in eclipse though. :-(

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
