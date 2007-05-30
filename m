From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH 0/4] Make MINGW port cross-compilable from Linux
Date: Wed, 30 May 2007 08:51:09 +0200
Organization: eudaptics software gmbh
Message-ID: <465D1EDD.658483B4@eudaptics.com>
References: <11804928354163-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 30 08:50:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtI0h-0006RI-KE
	for gcvg-git@gmane.org; Wed, 30 May 2007 08:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbXE3GuQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 30 May 2007 02:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbXE3GuQ
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 02:50:16 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.24]:7617 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbXE3GuP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 May 2007 02:50:15 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtp (Exim 4.44)
	id 1HtI0a-0000FN-Kl; Wed, 30 May 2007 08:50:12 +0200
Received: from eudaptics.com (unknown [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5B6BA4E9; Wed, 30 May 2007 08:50:12 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 0.0 (/)
X-Spam-Report: AWL=0.044
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48748>

"Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy" wrote:
>=20
> The following patches allow to cross compile mingw port from Linux le=
ss painful.

Thank you. Could you please push this to the mob branch?

git push mob@repo.or.cz:/srv/git/git/mingw.git +mybranch:mob

The series should be based on mingw.git's master branch (not devel)!

-- Hannes
