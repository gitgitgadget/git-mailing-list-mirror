From: Marco <netuse@lavabit.com>
Subject: Re: Why doesn't git commit -a track new files
Date: Thu, 24 Feb 2011 17:47:40 +0100
Message-ID: <20110224174740.5b1aec4f@glyph>
References: <20110224112246.3f811ac2@glyph>
	<4D6672F7.4020101@drmicha.warpmail.net>
	<vpqk4gp4dxf.fsf@bauges.imag.fr>
	<4D668181.404@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 24 17:48:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PseMb-0004Gs-Mj
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 17:48:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756457Ab1BXQsD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Feb 2011 11:48:03 -0500
Received: from lo.gmane.org ([80.91.229.12]:44535 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756435Ab1BXQsB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Feb 2011 11:48:01 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PseM9-0003yh-0n
	for git@vger.kernel.org; Thu, 24 Feb 2011 17:47:57 +0100
Received: from miun108-177.dynamic.miun.se ([193.10.108.177])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 17:47:57 +0100
Received: from netuse by miun108-177.dynamic.miun.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 17:47:57 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: miun108-177.dynamic.miun.se
X-Newsreader: Claws Mail 3.7.6 (GTK+ 2.22.0; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167837>

On 2011-02-24 Michael J Gruber <git@drmicha.warpmail.net> wrote:

> > git status && behappy && git commit -A
>=20
> That may not give the full picture of untracked stuff in subdirs.

May I ask why not? AFAIK git status outputs staged and untracked stuff.

> > git commit -A && look at status $EDITOR && behapy && save
>=20
> Yes, I even mentioned that, but you cut it. Bad bad boy! ;)
>=20
> >> Also, "-A" supports a very "un-gitty" way of using git. This makes=
 it
> >> unlikely that someone cares to implement it...

I think it *can* be used in an appropriate manner.
BTW: Why isn't commit -a =C2=BBun-gitty=C2=AB?


Marco
