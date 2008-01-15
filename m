From: Stelian Pop <stelian@popies.net>
Subject: Re: [PATCH] hg-to-git: improve popen calls
Date: Tue, 15 Jan 2008 10:52:14 +0100
Message-ID: <1200390734.10025.28.camel@galileo>
References: <478C0837.7090804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, brian.ewins@gmail.com
To: Mark Drago <markdrago@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 10:58:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEiYr-0004bp-DJ
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 10:58:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667AbYAOJ55 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jan 2008 04:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752611AbYAOJ55
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 04:57:57 -0500
Received: from sd-11162.dedibox.fr ([88.191.70.230]:42051 "EHLO
	sd-11162.dedibox.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbYAOJ54 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 04:57:56 -0500
X-Greylist: delayed 340 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jan 2008 04:57:56 EST
Received: from sd-11162.dedibox.fr (localhost.localdomain [127.0.0.1])
	by sd-11162.dedibox.fr (Postfix) with ESMTP id 8DD8F92DFB;
	Tue, 15 Jan 2008 10:52:15 +0100 (CET)
Received: from [192.168.6.8] (voyager.popies.net [62.147.231.2])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sd-11162.dedibox.fr (Postfix) with ESMTP id 21F3992CF5;
	Tue, 15 Jan 2008 10:52:15 +0100 (CET)
In-Reply-To: <478C0837.7090804@gmail.com>
X-Mailer: Evolution 2.12.1 
X-AV-Checked: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70507>


Le lundi 14 janvier 2008 =C3=A0 20:11 -0500, Mark Drago a =C3=A9crit :
> This patch improves all of the popen calls in hg-to-git.py by specify=
ing the
> template 'hg log' should use instead of calling 'hg log' and grepping=
 for the
> desired data.
>=20
> Signed-off-by: Mark Drago <markdrago@gmail.com>

Nice !

Acked-by: Stelian Pop <stelian@popies.net>

Thanks.

Stelian.

--=20
Stelian Pop <stelian@popies.net>
