From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Recent documentation patches, and an RFC on terminology
Date: Sat, 24 Apr 2010 00:14:33 +0200
Message-ID: <20100423221433.GB29661@atjola.homenet>
References: <20100423215448.1EF5B479E92@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Raymond <esr@snark.thyrsus.com>
X-From: git-owner@vger.kernel.org Sat Apr 24 00:14:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5R92-00035m-G9
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 00:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758415Ab0DWWOi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Apr 2010 18:14:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:48028 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755976Ab0DWWOh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 18:14:37 -0400
Received: (qmail invoked by alias); 23 Apr 2010 22:14:35 -0000
Received: from i59F55439.versanet.de (EHLO atjola.homenet) [89.245.84.57]
  by mail.gmx.net (mp061) with SMTP; 24 Apr 2010 00:14:35 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18Z3fhuZuIZoXOPxgBvwdiTY1Ws1MHy311ajqLZjp
	8iOQq1XQhKC6Nw
Content-Disposition: inline
In-Reply-To: <20100423215448.1EF5B479E92@snark.thyrsus.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64000000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145643>

On 2010.04.23 17:54:48 -0400, Eric Raymond wrote:
> We may have an opportunity to improve on the term "staging area".  As
> I reflect on it, I think replacing that with the term "depot" might
> not be a bad idea.

IIRC Perforce already uses the term "depot" for something that's not
quite git's index (your other mail didn't make it to me yet, so I
couldn't quickly look up how you differentiate between the "staging
area" and the index). There have been people in #git that used the term
"depot", and till now I simply guessed that they meant "repository", an=
d
that seemed to fit. Introducing git's own definition of "depot" will
probably cause confusion when talking to (former) perforce users, so I'=
d
rather avoid that term.

Bj=F6rn
