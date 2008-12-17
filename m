From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] doc/git-reset: add reference to git-stash
Date: Wed, 17 Dec 2008 09:49:42 +0100
Message-ID: <200812170949.42753.markus.heidelberg@web.de>
References: <200812170359.36253.markus.heidelberg@web.de> <20081217041159.GY5691@genesis.frugalware.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Dec 17 09:50:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCs7J-00041Y-Mx
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 09:50:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759635AbYLQItb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 03:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759643AbYLQItb
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 03:49:31 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:56176 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759633AbYLQIt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 03:49:29 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 66E20F57C3F3;
	Wed, 17 Dec 2008 09:49:26 +0100 (CET)
Received: from [91.19.64.135] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.109 #226)
	id 1LCs5u-00078e-00; Wed, 17 Dec 2008 09:49:26 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <20081217041159.GY5691@genesis.frugalware.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX191zy7PUyx0ClZV1LLBBvCdAjCVNaWzVd64qNJz
	oDlTjLvhV3gI8VqX/CKtlwjktr2LXUzUIfvtL/5eV4wAoNfp2y
	2pu4AplKuWkivGZrh4Rg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103322>

Miklos Vajna, 17.12.2008:
> On Wed, Dec 17, 2008 at 03:59:36AM +0100, Markus Heidelberg <markus.heidelberg@web.de> wrote:
> > ++
> > +See also linkgit:git-stash[1].
> 
> Manpages have a dedicated "SEE-ALSO" section. What about this?

That's only appropriate if the commands are generally related to each
other, which isn't true for git-reset and git-stash.

> (See Documentation/git-commit.txt for an example.)

man git-commit
/See
-> I get 4 search matches outside of the "SEE ALSO" section and it makes
sense in these cases.

Markus
