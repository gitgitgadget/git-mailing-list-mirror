From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: tip tree clone fail
Date: Sun, 12 Oct 2008 14:59:56 +0200
Message-ID: <20081012125956.GI536@genesis.frugalware.org>
References: <48EEA714.4010205@cn.fujitsu.com> <20081010072951.GB16016@elte.hu> <20081010083720.GA32069@elte.hu> <alpine.LFD.2.00.0810101040200.3271@apollo> <48EF14FC.1000801@cn.fujitsu.com> <alpine.LFD.2.00.0810101046260.3271@apollo> <48EF1902.4070309@cn.fujitsu.com> <48EF7BC1.4000401@zytor.com> <20081012124105.GA26988@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aJDJANv8BPX70wwH"
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Wang Chen <wangchen@cn.fujitsu.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	FNST-Lai Jiangshan <laijs@cn.fujitsu.com>,
	FJ-KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Sun Oct 12 15:01:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp0Za-00065a-9H
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 15:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920AbYJLNAD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 09:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752744AbYJLNAD
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 09:00:03 -0400
Received: from virgo.iok.hu ([193.202.89.103]:44825 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752076AbYJLNAB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 09:00:01 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 0B15558090;
	Sun, 12 Oct 2008 14:59:59 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 16DD04465E;
	Sun, 12 Oct 2008 14:59:56 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 0617011901A1; Sun, 12 Oct 2008 14:59:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20081012124105.GA26988@elte.hu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98017>


--aJDJANv8BPX70wwH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2008 at 02:41:05PM +0200, Ingo Molnar <mingo@elte.hu> wrote:
> can i simply put "git update-server-info" into .git/hooks/post-receive=20
> to solve this problem?

Yes. And don't forget the chmod +x it, if it's not done yet.

--aJDJANv8BPX70wwH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjx9MsACgkQe81tAgORUJZS4gCfWWkv+VwVbY9Ol41N6p4urgqy
VLYAoI/n987NeCsNWrIEY1CUh6rX+ddy
=2EHQ
-----END PGP SIGNATURE-----

--aJDJANv8BPX70wwH--
