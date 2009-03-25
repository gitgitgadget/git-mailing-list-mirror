From: Sam Hocevar <sam@zoy.org>
Subject: Re: [PATCH v4 2/2] git-gui: minor spelling fix and string factorisation.
Date: Wed, 25 Mar 2009 16:23:38 +0100
Message-ID: <20090325152338.GD30959@zoy.org>
References: <20090324230238.GQ23521@spearce.org> <20090324231900.GB14967@zoy.org> <fabb9a1e0903250604t2909e9bbg66c6dab82dcf3333@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 16:25:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmUz8-0006G0-CH
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 16:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759269AbZCYPXm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 11:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757036AbZCYPXl
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 11:23:41 -0400
Received: from poulet.zoy.org ([80.65.228.129]:53765 "EHLO poulet.zoy.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753732AbZCYPXl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 11:23:41 -0400
Received: by poulet.zoy.org (Postfix, from userid 1000)
	id 916FF120430; Wed, 25 Mar 2009 16:23:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <fabb9a1e0903250604t2909e9bbg66c6dab82dcf3333@mail.gmail.com>
Mail-Copies-To: never
X-No-CC: I read mailing-lists; do not CC me on replies.
X-Snort: uid=0(root) gid=0(root)
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114605>

On Wed, Mar 25, 2009, Sverre Rabbelier wrote:
> Heya,
>=20
> On Wed, Mar 25, 2009 at 00:19, Sam Hocevar <sam@zoy.org> wrote:
> > ---
> >  =E2=96=81=E2=96=82=E2=96=83=E2=96=84=E2=96=85=E2=96=86=E2=96=87=E2=
=96=88
>=20
> I'm curious, where'd this come from?

   Just a few characters from the "Block Elements" Unicode block.
=46or some reason, even though my locale is en_GB.UTF-8, Mutt insists
on converting my messages to iso8859-1 when doing so does not lose
information, resulting in corrupted patches, hence my addition of the
above characters.

   By the way, your own mailer seems to be mangling those Unicode
characters when answering.

Cheers,
--=20
Sam.
