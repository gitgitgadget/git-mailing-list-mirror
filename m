From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] Enable support for IPv6 on MinGW
Date: Tue, 24 Nov 2009 08:41:13 +0100
Message-ID: <4B0B8E19.2090705@viscovery.net>
References: <alpine.DEB.2.00.0911240052440.14228@cone.home.martin.st> <alpine.DEB.2.00.0911240055170.14228@cone.home.martin.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?ISO-8859-1?Q?Martin_Storsj=F6?= <martin@martin.st>
X-From: git-owner@vger.kernel.org Tue Nov 24 08:41:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCq1e-0007PU-FL
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 08:41:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757720AbZKXHlP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Nov 2009 02:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757669AbZKXHlP
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 02:41:15 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:29767 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757534AbZKXHlO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Nov 2009 02:41:14 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NCq1S-0002Rw-3s; Tue, 24 Nov 2009 08:41:14 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id DEFF29F88; Tue, 24 Nov 2009 08:41:13 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <alpine.DEB.2.00.0911240055170.14228@cone.home.martin.st>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133566>

Martin Storsj=F6 schrieb:
> The IPv6 support functions are loaded dynamically, to maintain backwa=
rds
> compatibility with versions of Windows prior to XP, and fallback wrap=
pers
> are provided, implemented in terms of gethostbyname and gethostbyaddr=
=2E
>=20
> Signed-off-by: Martin Storsjo <martin@martin.st>

Acked-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes
