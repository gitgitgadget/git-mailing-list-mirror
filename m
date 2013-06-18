From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: send-email adds redundant From: lines to message body
Date: Tue, 18 Jun 2013 13:48:00 +0200
Message-ID: <20130618114800.GB20052@goldbirke>
References: <20130618110904.GA20052@goldbirke>
 <20130618114207.GD26857@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 13:48:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UouOT-00027X-So
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 13:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932659Ab3FRLsH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jun 2013 07:48:07 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:61655 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932189Ab3FRLsG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 07:48:06 -0400
Received: from localhost6.localdomain6 (g230129165.adsl.alicedsl.de [92.230.129.165])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0MLEXd-1UpBVQ3AKP-000xh0; Tue, 18 Jun 2013 13:48:02 +0200
Content-Disposition: inline
In-Reply-To: <20130618114207.GD26857@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:dcVECstaog9QkoWaTTBRtXhKym6PkMdAWiN7wk/1OzX
 UHQRObbCBVapir8fZ74XN6rS0OEbcsX1Rx9hcrTRqYvjHoqldP
 hCo9SvOEkDo/4lsfnbe4Y+lzfcsWvhRbNRFZQ2Tw8jLGjohufD
 /wjWRLCWP92m9ZBBgV7TXSVMlFqMsAKeVyq0nNdH+9xRUrUPml
 FabwiVEpFDX+0q19XyaXDrVNZC411BoN5gUKFypSHZChxSn5MC
 PXp4el/2Owl62ZTgxq8iG3qPqBjHDeBlMauCqLEPTnc1qHvrJy
 JxQykT5AnntkX9mBuvQH7ApNa59PlqS6K/xMMqmgyszHZvvqAu
 /s0+U2ZFcvkXOYPgMB5PPgVFFmcTYgdCT1WLYRAuM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228200>

On Tue, Jun 18, 2013 at 02:42:07PM +0300, Michael S. Tsirkin wrote:
> On Tue, Jun 18, 2013 at 01:09:04PM +0200, SZEDER G=E1bor wrote:
> > Hi,
> >=20
> > 'git send-email' recently started to add redundant From: lines to m=
y
> > messages, see e.g.
> >=20
> >   http://article.gmane.org/gmane.comp.version-control.git/228132
>=20
> Can you please show what do commits point to?
> E.g. push to some public tree?

Sure.

  https://github.com/szeder/git.git bash-prompt-speedup
