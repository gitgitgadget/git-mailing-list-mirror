From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 2/5] Not all vendor diffs support GNUisms (resend)
Date: Sun, 25 Apr 2010 16:57:56 +0200
Message-ID: <4BD45874.9010700@lsrfire.ath.cx>
References: <20100311163039.GB7877@thor.il.thewrittenword.com> <4B994324.9060400@lsrfire.ath.cx> <20100315050943.GA22128@thor.il.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Sun Apr 25 16:58:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O63IK-0003Z8-MX
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 16:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219Ab0DYO6e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Apr 2010 10:58:34 -0400
Received: from india601.server4you.de ([85.25.151.105]:44856 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612Ab0DYO6e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 10:58:34 -0400
Received: from [10.0.1.100] (p57B7D359.dip.t-dialin.net [87.183.211.89])
	by india601.server4you.de (Postfix) with ESMTPSA id AC0062F8069;
	Sun, 25 Apr 2010 16:58:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <20100315050943.GA22128@thor.il.thewrittenword.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145740>

Am 25.04.2010 10:35, schrieb Gary V. Vaughan:
>> (I'd split the introduction of DIFF/$DIFF, the diff -> test_cmp
>> conversions and the change to set GIT_TEST_CMP=3Dcmp for your platfo=
rm
>> into three separate patches.)
>=20
> Will do. And then I'll resubmit the whole series.

Commits c296134d and 4a2284b9 from Junio (in git 1.7.1) already do some
part of the work, converting two test script to test_cmp.

Ren=E9
