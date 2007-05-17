From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 03/10] glossary: expand and clarify some definitions, prune cross-references
Date: Thu, 17 May 2007 00:30:40 -0400
Message-ID: <20070517043040.GA5032@fieldses.org>
References: <5520.48510076037$1179156136@news.gmane.org> <f2a4b4$ein$3@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 17 06:30:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoXdY-0002hL-2v
	for gcvg-git@gmane.org; Thu, 17 May 2007 06:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755103AbXEQEam convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 17 May 2007 00:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754870AbXEQEam
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 00:30:42 -0400
Received: from mail.fieldses.org ([66.93.2.214]:51071 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755103AbXEQEal (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 00:30:41 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HoXdQ-0006ne-FS; Thu, 17 May 2007 00:30:40 -0400
Content-Disposition: inline
In-Reply-To: <f2a4b4$ein$3@sea.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47496>

On Mon, May 14, 2007 at 07:00:48PM +0200, Jakub Narebski wrote:
> J. Bruce Fields wrote:
>=20
> > +[[def_detached_HEAD]]detached HEAD::
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Normally HEAD refers to =
the tip of a
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<<def_branch,branch>>.
>=20
> Normally HEAD refers to the branch _name_ (names current branch).
> From this sentence one can think that normally HEAD is pointer
> to commit which is tip of current branch.

OK, thanks; fixed in maint branch of
git://linux-nfs.org/~bfields/git.git.

--b.
