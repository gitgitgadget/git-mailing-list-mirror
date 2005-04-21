From: Bryan Donlan <bdonlan@bd.beginyourfear.com>
Subject: Re: [ANNOUNCE] git-pasky-0.6.2 && heads-up on upcoming changes
Date: Wed, 20 Apr 2005 22:53:33 -0400
Message-ID: <u6hjj2-jl9.ln1@bd-home-comp.no-ip.org>
References: <20050420205633.GC19112@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Apr 21 05:00:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DORvb-000145-4v
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 05:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVDUDEu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 23:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVDUDEt
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 23:04:49 -0400
Received: from main.gmane.org ([80.91.229.2]:193 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261196AbVDUDEn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 23:04:43 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DORvD-00012s-3k
	for git@vger.kernel.org; Thu, 21 Apr 2005 05:00:07 +0200
Received: from cpe-24-198-10-141.maine.res.rr.com ([24.198.10.141])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Apr 2005 05:00:07 +0200
Received: from bdonlan by cpe-24-198-10-141.maine.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Apr 2005 05:00:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cpe-24-198-10-141.maine.res.rr.com
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
In-Reply-To: <20050420205633.GC19112@pasky.ji.cz>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

Petr Baudis wrote:
|   Hello,
|
|   so I've "released" git-pasky-0.6.2 (my SCMish layer on top of Linus
| Torvalds' git tree history storage system), find it at the usual
|
| 	http://pasky.or.cz/~pasky/dev/git/

When I run `git pull', I get:

Tree change:
55f9d5042603fff4ddfaf4e5f004d2995286d6d3:7a4c67965de68ae7bc7aa1fde33f8eb9d8114697
+100644	blob	8186a561108d3c62625614272bd5e2f7d5826b4b	README.reference
*100755->100755	blob
5f23301eb97a0fadd505a6e9cc851e98741a512a->bf277135908ee7c6b7d6ad330d1ce183b9bb411f
git
*100755->100755	blob
a78cf8ccab98861ef7aecb4cb5a79e47d3a84b67->74b4083d67eda87d88a6f92c6c66877bba8bda8a
gitcancel.sh
Tracked branch, applying changes...
Fast-forwarding 55f9d5042603fff4ddfaf4e5f004d2995286d6d3 ->
7a4c67965de68ae7bc7aa1fde33f8eb9d8114697
	on top of 55f9d5042603fff4ddfaf4e5f004d2995286d6d3...
patch: **** Only garbage was found in the patch input.

I'm on debian testing, patch 2.5.9. It seems to apply the changes
despite this error.

Thanks,

Bryan Donlan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQmcVqXhF4rlE0/81AQPNdA//fmL+O3amch3WUfYLZroSNarto/jcQ8WE
NAwthoT+nPkvUcrgoPVPvuJKmKlemBLGqJhz5raOgL8Cu09ttnHh9zi9fz/XD2uR
FFJ603xJDBqHGAG3FVS9EHaTdIFq7kSgVKn90BGdR/gxYR5oCt9DHbOzpI9S0DC5
o580CvtMHRfN1mUwhmxt8oU1E5obRvHlwQ2R4kVl90DBmPNRNXMiWziKjaVyKVng
IXR2ERfCb1HurZfoOlcmhw0Aod7sJpjubf/tm9CDdRIkMdKkeuKBqWbanzHJTlJG
2GOH2Q0CNp1HscFO+DKsCPBMa8zLAPuN0AF//o8URzXElwFiAfQNMjK8hOFVBI2y
6OR/WUvwlXUs47+9QJX7mLTjTJIgcHsxZF9amX37jXKiL5iZyDUJD9wxcFL6A1ut
eVntC36Fp6yx8zROAex0hNx68LHTILUh5bDi3N9gTnpplWpCn02GNkQi18GQLk4Z
Y34WipxwGImbJooGveHh8nH6v/6V4fOy1SaxaV5q4EL563wGrRlIZ9/POgWeJoas
D5S7aJgXCw0GLTJFZCEDORUTCv73HgxR7zSlyqup2qR0Tjqv/JWTCfqCSRLJ8Ktc
PVKf2Alx6ycVFbh9XhQUKWT4tLm1KywpTUvZe+K0DMfw28dbRREnRyFVqbId8JmX
LJgbHTVxRCs=
=Fx+f
-----END PGP SIGNATURE-----

