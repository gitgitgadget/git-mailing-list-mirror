From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: in support of git pushing only the active branch by default
Date: Sun, 18 Mar 2012 12:46:16 +0100
Message-ID: <20120318114608.GA6251@atjola.homenet>
References: <5B1A6856-E87D-4AB6-B7CC-71055FF2DF48@me.com>
 <20120318085347.GA612@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Essel <messel@me.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Sun Mar 18 12:46:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9EZc-0004OO-U9
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 12:46:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754997Ab2CRLqW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Mar 2012 07:46:22 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:46947 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754877Ab2CRLqW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 07:46:22 -0400
Received: (qmail invoked by alias); 18 Mar 2012 11:46:20 -0000
Received: from i59F57E2F.versanet.de (EHLO atjola.homenet) [89.245.126.47]
  by mail.gmx.net (mp038) with SMTP; 18 Mar 2012 12:46:20 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/1Z9kXW4f1r8axBTPnQ3EHr9GG0UUCE85+7nJC9d
	eSblA4Cs9kLZNm
Content-Disposition: inline
In-Reply-To: <20120318085347.GA612@hashpling.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193380>

On 2012.03.18 08:53:47 +0000, Charles Bailey wrote:
> On Sat, Mar 17, 2012 at 06:16:51AM -0400, Mark Essel wrote:
> > I would appreciate a brief option to push all branches, git push-al=
l or similar for personal git usage.
>=20
> You mean like this?
>=20
> git push origin :

That would be what "matching" does, i.e. push only those branch heads
that exist in both repos. To push all branch heads, use --all.

Bj=F6rn
