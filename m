From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 1/1] update gitignore
Date: Wed, 16 Sep 2009 12:03:29 +0200
Message-ID: <20090916100320.GA22131@laphroaig.corp>
References: <1253095295-28919-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: gister@pobox.com
X-From: git-owner@vger.kernel.org Wed Sep 16 12:03:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnrMT-0004ZI-AI
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 12:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177AbZIPKDc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Sep 2009 06:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753719AbZIPKDb
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 06:03:31 -0400
Received: from pan.madism.org ([88.191.52.104]:41457 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753025AbZIPKDa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 06:03:30 -0400
Received: from laphroaig.corp (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	by hermes.madism.org (Postfix) with ESMTPSA id 5434440414;
	Wed, 16 Sep 2009 12:03:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1253095295-28919-1-git-send-email-madcoder@debian.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128635>

Huh sorry, forget it, I though my repository was clean and those were
new by-products of the build, but it appears it was not.

On Wed, Sep 16, 2009 at 12:01:35PM +0200, Pierre Habouzit wrote:
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>  .gitignore |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>=20
> diff --git a/.gitignore b/.gitignore
> index 47672b0..5604b82 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -105,6 +105,9 @@ git-reflog
>  git-relink
>  git-remote
>  git-remote-curl
> +git-remote-ftp
> +git-remote-http
> +git-remote-https
>  git-repack
>  git-replace
>  git-repo-config
> --=20
> 1.6.5.rc1.185.g9cbfa
>=20

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@d=
ebian.org
OOO                                                http://www.madism.or=
g
