From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] fix t5403-post-checkout-hook.sh: built-in test in dash
 does not have "=="
Date: Thu, 04 Oct 2007 18:47:55 +0200
Message-ID: <4705193B.30400@lsrfire.ath.cx>
References: <1190842261-9750-1-git-send-email-jjengla@sandia.gov> <20071004133253.GA30393@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, Josh England <jjengla@sandia.gov>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 18:48:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdTs1-000801-EX
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 18:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757900AbXJDQsI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2007 12:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756179AbXJDQsH
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 12:48:07 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:53228
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756129AbXJDQsG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Oct 2007 12:48:06 -0400
Received: from [10.0.1.201] (p57B7DDE5.dip.t-dialin.net [87.183.221.229])
	by neapel230.server4you.de (Postfix) with ESMTP id 2E336873B7;
	Thu,  4 Oct 2007 18:48:04 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071004133253.GA30393@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59985>

Alex Riesen schrieb:
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
> Josh England, Wed, Sep 26, 2007 23:31:01 +0200:
>>  t/t5403-post-checkout-hook.sh |   74 ++++++++++++++++++++++++++++++=
+++++++++++
>=20
> on Ubuntu, /bin/sh is dash.

Ah, so YOU are the other Ubuntu user around here, Alex! ;-)  I've just
sent out the exact same patch.  Sorry for the duplication, please ignor=
e me.

Ren=E9
