From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-svn doesn't fetch anything
Date: Thu, 05 Feb 2009 12:08:26 +0100
Message-ID: <498AC8AA.5040902@drmicha.warpmail.net>
References: <941ff7dd0902041549y238f8460m3e1173cee6f44328@mail.gmail.com>	 <20090205033638.GD28280@atjola.homenet> <941ff7dd0902050054v51853a4bgad1dca9211bcd75a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	git@vger.kernel.org
To: Harry Vangberg <ichverstehe@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 12:10:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV27L-0005Ao-Bj
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 12:09:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbZBELId convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Feb 2009 06:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752057AbZBELId
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 06:08:33 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:42859 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751863AbZBELIc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Feb 2009 06:08:32 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id F13332864B3;
	Thu,  5 Feb 2009 06:08:30 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 05 Feb 2009 06:08:31 -0500
X-Sasl-enc: +r8/kFW/sLMRmXjWxmP6p3GItIjk/xj+lVXvd6GHSzJ5 1233832110
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 46BEA24D9D;
	Thu,  5 Feb 2009 06:08:30 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <941ff7dd0902050054v51853a4bgad1dca9211bcd75a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108551>

Harry Vangberg venit, vidit, dixit 05.02.2009 09:54:
> 2009/2/5 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
>> Hm, the branches and tags config looks weird to me. Is the path to t=
hem
>> really ".../turntool/plantool/plantool/branches"?
>=20
> I tried doing this:
>=20
> $ git svn init https://svn.turntool.com/svn/turntool/plantool -s
> --username=3Dharry
> Initialized empty Git repository in /Users/h/work/projsvn/.git/
> $

Is there a read-only guest account or something which could help us
track this down? Otherwise the answer will probably be "it should work
like that, it must be a weird repo".

Cheers,
Michael
