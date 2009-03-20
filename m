From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 2/2] git-gui: some French translation enhancements
Date: Fri, 20 Mar 2009 08:13:16 +0100
Message-ID: <20090320071316.GB5693@glandium.org>
References: <cd2d922d5257aac105de08fd90e6dbd389f0b6f0.1237506346.git.nicolas.s-dev@laposte.net> <5b4295c484a9659d1c5813e1859f192c34d6a99e.1237506346.git.nicolas.s-dev@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Sam Hocevar <sam@zoy.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Alexandre Bourget <alexandre.bourget@savoirfairelinux.com>
To: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
X-From: git-owner@vger.kernel.org Fri Mar 20 08:15:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkYwI-0008R0-Gi
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 08:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbZCTHNR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Mar 2009 03:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbZCTHNR
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 03:13:17 -0400
Received: from vuizook.err.no ([85.19.221.46]:33454 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751484AbZCTHNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 03:13:16 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LkYui-0007GK-Ls; Fri, 20 Mar 2009 08:13:11 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LkYuq-0004fC-GL; Fri, 20 Mar 2009 08:13:16 +0100
Content-Disposition: inline
In-Reply-To: <5b4295c484a9659d1c5813e1859f192c34d6a99e.1237506346.git.nicolas.s-dev@laposte.net>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 1.6): No, score=1.6 required=5.0 tests=RDNS_DYNAMIC,WEIRD_PORT autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113906>

On Fri, Mar 20, 2009 at 01:54:02AM +0100, Nicolas Sebrecht wrote:
>=20
>=20
> Signed-off-by: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
> ---
>  po/fr.po |   21 ++++++++++-----------
>  1 files changed, 10 insertions(+), 11 deletions(-)
>=20
> diff --git a/po/fr.po b/po/fr.po
> index eb5f68e..2f96054 100644
> --- a/po/fr.po
> +++ b/po/fr.po
> @@ -316,11 +316,11 @@ msgstr "Indexer toutes modifications"
> =20
>  #: git-gui.sh:2479
>  msgid "Unstage From Commit"
> -msgstr "D=C3=A9sindexer"
> +msgstr "Retirer de l'index"

IMHO, we should find a better way to say that than to use the "index"
word at all. This obviously applies to all uses of "index" in french
where we avoided it in english.

OTOH, the best I can find for "staging area" is "zone de pr=E9paration"=
,
and that doesn't help finding a word for stage and unstage.

Mike
