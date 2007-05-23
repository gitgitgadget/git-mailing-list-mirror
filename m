From: Panagiotis Issaris <takis.issaris@uhasselt.be>
Subject: Re: HTTP trees trailing GIT trees
Date: Wed, 23 May 2007 16:11:12 +0200
Message-ID: <46544B80.90907@uhasselt.be>
References: <loom.20070523T154909-285@post.gmane.org> <20070523140552.GN4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed May 23 16:42:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hqs2K-0006sx-Ay
	for gcvg-git@gmane.org; Wed, 23 May 2007 16:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755773AbXEWOl5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 23 May 2007 10:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756156AbXEWOl4
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 10:41:56 -0400
Received: from alpha.uhasselt.be ([193.190.2.30]:54877 "EHLO alpha.uhasselt.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755773AbXEWOl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 10:41:56 -0400
X-Greylist: delayed 1802 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 May 2007 10:41:56 EDT
Received: from localhost (datastorage.uhasselt.be [193.190.2.17])
	by alpha.uhasselt.be (Postfix) with ESMTP id 029DB1AB1EC;
	Wed, 23 May 2007 16:11:53 +0200 (CEST)
X-Virus-Scanned: by Amavisd antivirus & antispam cluster at uhasselt.be
Received: from [172.17.10.54] (edm-005.edm.uhasselt.be [193.190.10.5])
	(Authenticated sender: lucp1751)
	by alpha.uhasselt.be (Postfix) with ESMTP id 856F31AB185;
	Wed, 23 May 2007 16:11:51 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.10 (X11/20070403)
In-Reply-To: <20070523140552.GN4489@pasky.or.cz>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48159>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

Petr Baudis wrote:
>   Hi,
>=20
> On Wed, May 23, 2007 at 04:01:33PM CEST, Panagiotis Issaris wrote:
>> I reported this to the person who had setup the repository:
>> http://article.gmane.org/gmane.comp.video.ffmpeg.devel/51151
>>
>> But unfortunately, the problem seems to remain.
>>
>> Is this a known problem, or might this be a bug or misconfiguration?
>=20
>   did any push happenned since the post-update hook was enabled? It
> takes effect only after the next push. So far,
>=20
> 	http://git.mplayerhq.hu/ffmpeg/info/refs
>=20
> and
>=20
> 	http://git.mplayerhq.hu/ffmpeg/refs/heads/master
>=20
> is still out-of-sync (keeping this in sync is what is the job of the
> post-update hook, or git-update-server-info respectively).

Yes, I'd think so, as M=E5ns stated that he had enabled the hook on
2007-05-22 20:43:27. The last commit shown on http://git.mplayerhq.hu/
through gitweb occurred 25 minutes ago ("Wed, 23 May 2007 13:46:11 +000=
0").

Thanks for your fast reply.

With friendly regards,
Takis
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGVEuA9kOxLuzz4CkRAkXTAJ9xqbkUO6qF88HwV7GSYnVkV+VRNgCfSr/D
ZPPYBfeD9RpqbXNKwmukObc=3D
=3Dwkyo
-----END PGP SIGNATURE-----
