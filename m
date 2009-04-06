From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Broken umlaut in my name, again
Date: Mon, 6 Apr 2009 13:46:18 +0200
Message-ID: <20090406114618.GF20356@atjola.homenet>
References: <20090331153039.GA1520@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 13:48:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqnJ2-0006pp-B0
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 13:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755449AbZDFLq2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2009 07:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755205AbZDFLq2
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 07:46:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:47995 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752924AbZDFLq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 07:46:28 -0400
Received: (qmail invoked by alias); 06 Apr 2009 11:46:19 -0000
Received: from i59F56377.versanet.de (EHLO atjola.local) [89.245.99.119]
  by mail.gmx.net (mp011) with SMTP; 06 Apr 2009 13:46:19 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/wlfcAJsXwaT+rXYUGP+410VW0Eux9JzurAVnwFD
	wgd07pgPpESDF9
Content-Disposition: inline
In-Reply-To: <20090331153039.GA1520@atjola.homenet>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: -0.07000000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115808>

On 2009.03.31 17:30:39 +0200, Bj=F6rn Steinbrink wrote:
> While it makes no sense to map some email address to an empty one, do=
ing
> things the other way around can be useful. For example when using
> filter-branch with an env-filter that employs a mailmap to fix up an
> import that created such broken commits with empty email addresses.
>=20
> Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>

The umlaut (=F6) in my name is broken in the commit that made it into
git.git --> 5288dd58356e53d61e2b3804fc7d8d23c3a46ab3

Last time this happened when I used format-patch -s instead of commit -=
s
IIRC. But since then, I pay attention to do the sign-off via commit -s,
yet my name is broken again. What did I do wrong this time?

Bj=F6rn
