From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 2/5] Not all vendor diffs support GNUisms (resend)
Date: Sun, 25 Apr 2010 18:20:26 +0200
Message-ID: <4BD46BCA.3010308@lsrfire.ath.cx>
References: <20100311163039.GB7877@thor.il.thewrittenword.com> <4B994324.9060400@lsrfire.ath.cx> <20100315050943.GA22128@thor.il.thewrittenword.com> <4BD45874.9010700@lsrfire.ath.cx> <20100425152130.GA27695@thor.il.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Sun Apr 25 18:21:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O64aC-00015x-9q
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 18:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480Ab0DYQVO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Apr 2010 12:21:14 -0400
Received: from india601.server4you.de ([85.25.151.105]:36521 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753141Ab0DYQUx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 12:20:53 -0400
Received: from [10.0.1.100] (p57B7D359.dip.t-dialin.net [87.183.211.89])
	by india601.server4you.de (Postfix) with ESMTPSA id D81D22F8069;
	Sun, 25 Apr 2010 18:20:51 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <20100425152130.GA27695@thor.il.thewrittenword.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145747>

Am 25.04.2010 18:03, schrieb Gary V. Vaughan:
> Apologies for the long delay before my resent repost... it took me
> until now to figure out why most of my messages to this lest were
> being rejected...
>=20
> On Sun, Apr 25, 2010 at 04:57:56PM +0200, Ren? Scharfe wrote:
>> Am 25.04.2010 10:35, schrieb Gary V. Vaughan:
>>>> (I'd split the introduction of DIFF/$DIFF, the diff -> test_cmp
>>>> conversions and the change to set GIT_TEST_CMP=3Dcmp for your plat=
form
>>>> into three separate patches.)
>>>
>>> Will do. And then I'll resubmit the whole series.
>>
>> Commits c296134d and 4a2284b9 from Junio (in git 1.7.1) already do s=
ome
>> part of the work, converting two test script to test_cmp.
>=20
> Excellent.  ETA on a release from that branch so that I can finish an=
y
> necessary changes to my outstanding changesets?
>=20
> ...or is there time for me to clone the repository and rebase those
> changes in time for the 1.7.1 release?

Junio released git 1.7.1 just yesterday.

Ren=E9
