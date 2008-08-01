From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: StGit: kha/{stable,safe,experimental} updated
Date: Fri, 1 Aug 2008 12:22:08 +0200
Message-ID: <20080801102208.GA29413@diana.vm.bytemark.co.uk>
References: <20080725013936.GA20959@diana.vm.bytemark.co.uk> <b0943d9e0807270144n359e5bd3ye3e91c52b8fa7beb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Samuel Tardieu <sam@rfc1149.net>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 12:01:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOrRw-00047w-WD
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 12:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189AbYHAKA0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Aug 2008 06:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753104AbYHAKA0
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 06:00:26 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2057 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752913AbYHAKAX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 06:00:23 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KOrlw-0007hN-00; Fri, 01 Aug 2008 11:22:08 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0807270144n359e5bd3ye3e91c52b8fa7beb@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91050>

On 2008-07-27 09:44:31 +0100, Catalin Marinas wrote:

> 2008/7/25 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > The big update since last time is support (in kha/experimental) for
> > hidden patches in the new-infrastructure commands and stack log.
>=20
> I'll have a look at the new stack log format (my main worry) this
> week but the other patches look OK.

Heh. It's _always_ your main worry. But rightly so, since mistakes
could be costly. Thanks for spending time on this with me.

I made one change apart from adding the hidden patches: use the same
tree for both the full and simplified logs. It's no more costly to
write, and made the parsing substantially simpler.

> I merged the safe and stable branches.

Thanks.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
