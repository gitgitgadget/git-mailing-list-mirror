From: "Tilo Schwarz" <tilo@tilo-schwarz.de>
Subject: Re: [PATCH 1/2] po/de.po: add German translation
Date: Mon, 06 Sep 2010 21:58:44 +0200
Message-ID: <op.vimm36yma8ed4e@dellschleppa.fritz.box>
References: <AANLkTi=6ctLp-8FeqOGMZuhwvM_7DbaEp7+LK4nXfCaE@mail.gmail.com>
 <4c8197ab.1707e30a.3f10.714a@mx.google.com>
 <201009061741.27840.trast@student.ethz.ch> <4C8515DA.9010109@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 21:58:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OshqA-00018b-6L
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 21:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754714Ab0IFT6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 15:58:48 -0400
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:42479 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943Ab0IFT6r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 15:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1283803125; l=1189;
	s=domk; d=tilo-schwarz.de;
	h=In-Reply-To:From:Content-Transfer-Encoding:MIME-Version:Date:
	References:Subject:To:Content-Type:X-RZG-CLASS-ID:X-RZG-AUTH;
	bh=2I1vPMkm99qkhIFJrN/PeASZHgo=;
	b=rx9J1RioSkPtzpNw/St0HBGmrl5JSTAtlklUfCNEOuTgo9QbtT1zd3oLWJxCabS9Re6
	r7l41ZaLeJbHSRYFK1m7C2WSJ4ekJqR0J9f4+yaS7Tx9sQVTmDnp/iGITabavkXC5oq79
	DubiNr3GcD63tgwsvqw0V8eanUbWeho265c=
X-RZG-AUTH: :IW0NeWC8cvPlgn0IPTehqi9r6o/0DSXjJ1Me0yWdPTUrUVR0TMXac2ZAlcBx1cxAzkk=
X-RZG-CLASS-ID: mo00
Received: from dellschleppa.fritz.box
	(p549CA1B8.dip.t-dialin.net [84.156.161.184])
	by post.strato.de (klopstock mo31) (RZmta 23.5)
	with ESMTP id e045f2m86I101n for <git@vger.kernel.org>;
	Mon, 6 Sep 2010 21:58:44 +0200 (MEST)
In-Reply-To: <4C8515DA.9010109@web.de>
User-Agent: Opera Mail/10.61 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155605>

On Mon, 06 Sep 2010 18:24:58 +0200, Jens Lehmann <Jens.Lehmann@web.de>  
wrote:

> Am 06.09.2010 17:41, schrieb Thomas Rast:
>> I already like the translation way better than the one that
>> gitk/git-gui have, because it doesn't try so hard to translate *every*
>> term.
>
> Full Ack, I can't find my way through git-gui or gitk when I forget
> to start them with "LC_ALL=C" (And when you use git mainly via these
> guis, you will have to learn /every/ git command again when you
> start using the command line). IMHO terms that have a special in git
> should not be translated, so I would even vote for leaving terms like
> "fetch", "fast-forward" and maybe even "tracking-branch" as they are.

Full Ack again! Many german IT people use many english special terms daily  
(like compiler, linker, terminal, interrupt). Normally the translation of  
the special terms generates confusion all over the place. That's why I  
also start git-gui or gitk only in english (and the manpages too, by the  
way).

Thus the git special terms should not be translated, even though I might  
be helpful to have a glossary which explains, what a "fast-forward" is.

--
Regards,


     Tilo
