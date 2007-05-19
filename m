From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH 5/7] gitweb: Prototyp for selecting diffs in JavaScript
Date: Sat, 19 May 2007 09:57:01 +0200
Message-ID: <20070519075701.GA30933@auto.tuwien.ac.at>
References: <437446e84f3aea71f74fea7ea66db4c1c326fb6b.1176659094.git.mkoegler@auto.tuwien.ac.at> <481946c2e3cff09ed4a623b1b20b9889666aedb0.1176659095.git.mkoegler@auto.tuwien.ac.at> <20070518084935.GV4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat May 19 09:57:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpJoL-0007Za-9M
	for gcvg-git@gmane.org; Sat, 19 May 2007 09:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403AbXESH5G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 19 May 2007 03:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754078AbXESH5F
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 03:57:05 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:41864 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403AbXESH5E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 03:57:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id D9DF67ACC07D;
	Sat, 19 May 2007 09:57:01 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IVlmGfP-3jvM; Sat, 19 May 2007 09:57:01 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 7CDD07A876BD; Sat, 19 May 2007 09:57:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070518084935.GV4489@pasky.or.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47729>

On Fri, May 18, 2007 at 10:49:35AM +0200, Petr Baudis wrote:
> On Sun, Apr 15, 2007 at 10:46:08PM CEST, Martin Koegler wrote:
> > ---
> > This patch is only to test the other patches. I'm working on reimpl=
ementing it in perl.
>=20
>   I think this is something that I'd quite like to testdrive at
> repo.or.cz, but I'm admittelly somewhat lost in all the patches,
> resends, new versions, something got applied, etc. - if it's not too =
big
> a hassle for you, would you please care to resend the latest series?

Againgst what version/repository do you want the patch?

=46or the new version, I intend to move the JavaScript file into the
head tag of the html page. I could integrate your incremental blame
link rewrite as well. If I'm doing this, we could remove the blamelink
class hack as well as the fixBlameLinks JavaScript function.

mfg Martin K=F6gler
