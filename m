From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [GITK PATCH] gitk: add menuitem for file checkout from
	selected or parent commit
Date: Wed, 29 Sep 2010 17:23:00 +0200
Message-ID: <20100929152259.GA13887@book.hvoigt.net>
References: <20100928200344.GA12843@book.hvoigt.net> <AANLkTi=GmR3kV-ChSNybcaw4c=Dwt5G98e31WVuzJcfC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 17:23:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0yUv-0002bQ-Mf
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 17:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381Ab0I2PXD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Sep 2010 11:23:03 -0400
Received: from darksea.de ([83.133.111.250]:49819 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752761Ab0I2PXC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 11:23:02 -0400
Received: (qmail 18994 invoked from network); 29 Sep 2010 17:23:00 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 29 Sep 2010 17:23:00 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTi=GmR3kV-ChSNybcaw4c=Dwt5G98e31WVuzJcfC@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157578>

Hi,

On Tue, Sep 28, 2010 at 09:09:43PM +0000, =C6var Arnfj=F6r=F0 Bjarmason=
 wrote:
> On Tue, Sep 28, 2010 at 20:03, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > This is useful if a user wants to checkout a file from a certain
> > commit. This is equivalent to
>=20
> It looks like the existing msgid/msgstr pairs have line number
> comments. Why not add that for the new strings? Presumably it might
> inflate the patch a lot though, as old strings get displaced.

I was wondering what these numbers were for. Now it makes sense. I am
not against doing it but I would need a script to update the existing
ones. Is there something like that? Otherwise I would just add the line
number for the two new msgs.

Cheers Heiko
