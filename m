From: Michael <barra_cuda@katamail.com>
Subject: Re: [PATCH] Initial Italian translation of git-gui.pot
Date: Mon, 23 Jul 2007 11:09:14 +0200
Message-ID: <200707231109.14075.barra_cuda@katamail.com>
References: <20070722124236.47baacb1@paolo-desktop> <Pine.LNX.4.64.0707222315360.14781@racer.site> <e5bfff550707221525w3234c5edte3c3d58b97d4d970@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 11:09:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICtv1-0004Sk-Nx
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 11:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755943AbXGWJJ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 05:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755471AbXGWJJ3
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 05:09:29 -0400
Received: from slim-3c.inet.it ([213.92.5.125]:37244 "EHLO slim-3c.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755216AbXGWJJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 05:09:28 -0400
Received: from host197-56-static.104-80-b.business.telecomitalia.it ([::ffff:80.104.56.197]) by slim-3c.inet.it via I-SMTP-5.4.4-547
	id ::ffff:80.104.56.197+4hHxGUAMaqO; Mon, 23 Jul 2007 11:09:11 +0200
User-Agent: KMail/1.9.4
In-Reply-To: <e5bfff550707221525w3234c5edte3c3d58b97d4d970@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53417>

On Monday 23 July 2007 00:25, Marco Costalba wrote:
> There are some words that in my opinion it would be better do not
> translate but to leave in english, expecially on computer stuff
> italian people it's already used to the original english word.

Those who want to use the English version can always do
	LANG=en_US git gui
...but since there are going to be very few non-IT people that use
git, I guess most SCM's vocabulary can be left untranslated. The
most difficult words to translate (and so probably they should be
left unchanged) in this context are "merge" and "commit".

Thinking about it, shouldn't we add an help page in git gui with
a "mini glossary" (a short version of the git glossary) in it? 

Maybe something like this:
	http://it.wikipedia.org/wiki/Controllo_versione#Glossario
(but more centered on git, of course).

I wonder what other SCM (or SCM gui) projects do (if they are into
i18n at all).

> In our example "resettare" it's not italian, it's a italianized (very
> ugly) form of "to reset" and it would be really better to use "reset".

Yes. I even think that "reset" is kind of common in Italy (at
least for most people that use some electronic device). But maybe
I'm wrong.
