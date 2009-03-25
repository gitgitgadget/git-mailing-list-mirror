From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH v4 2/2] git-gui: minor spelling fix and string
	factorisation.
Date: Wed, 25 Mar 2009 16:27:41 +0100
Message-ID: <20090325152740.GA22719@glandium.org>
References: <20090324230238.GQ23521@spearce.org> <20090324231900.GB14967@zoy.org> <fabb9a1e0903250604t2909e9bbg66c6dab82dcf3333@mail.gmail.com> <20090325152338.GD30959@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Sam Hocevar <sam@zoy.org>
X-From: git-owner@vger.kernel.org Wed Mar 25 16:31:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmV43-0000Fh-KV
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 16:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762926AbZCYP1w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 11:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762874AbZCYP1v
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 11:27:51 -0400
Received: from vuizook.err.no ([85.19.221.46]:50505 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762563AbZCYP1u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 11:27:50 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=vaio.glandium.org)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LmV15-0006c8-Ee; Wed, 25 Mar 2009 16:27:46 +0100
Received: from mh by vaio.glandium.org with local (Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LmV13-0005ua-ON; Wed, 25 Mar 2009 16:27:41 +0100
Content-Disposition: inline
In-Reply-To: <20090325152338.GD30959@zoy.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114608>

On Wed, Mar 25, 2009 at 04:23:38PM +0100, Sam Hocevar <sam@zoy.org> wro=
te:
> On Wed, Mar 25, 2009, Sverre Rabbelier wrote:
> > Heya,
> >=20
> > On Wed, Mar 25, 2009 at 00:19, Sam Hocevar <sam@zoy.org> wrote:
> > > ---
> > >  =E2=96=81=E2=96=82=E2=96=83=E2=96=84=E2=96=85=E2=96=86=E2=96=87=E2=
=96=88
> >=20
> > I'm curious, where'd this come from?
>=20
>    Just a few characters from the "Block Elements" Unicode block.
> For some reason, even though my locale is en_GB.UTF-8, Mutt insists
> on converting my messages to iso8859-1 when doing so does not lose
> information, resulting in corrupted patches, hence my addition of the
> above characters.

echo 'set send_charset=3D"utf-8"' >> $HOME/.mutt/muttrc

Mike
