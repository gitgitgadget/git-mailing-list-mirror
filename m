From: Ismail Donmez <ismail@uludag.org.tr>
Subject: Re: non-trivial merge failures
Date: Sun, 20 Nov 2005 23:51:42 +0200
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK/UEKAE?=
Message-ID: <200511202351.42320.ismail@uludag.org.tr>
References: <20051120.134945.104623647.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Nov 20 22:53:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Edx6R-0005n8-Ea
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 22:52:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbVKTVwA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 20 Nov 2005 16:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbVKTVwA
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 16:52:00 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:61096 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S932091AbVKTVwA convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2005 16:52:00 -0500
Received: from [85.101.233.42] (unknown [85.101.233.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 71467AAF19
	for <git@vger.kernel.org>; Sun, 20 Nov 2005 23:51:53 +0200 (EET)
To: git@vger.kernel.org
User-Agent: KMail/1.8.92
In-Reply-To: <20051120.134945.104623647.davem@davemloft.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12405>

Sunday 20 November 2005 23:49 tarihinde =C5=9Funlar=C4=B1 yazm=C4=B1=C5=
=9Ft=C4=B1n=C4=B1z:
> ImportError: No module named subprocess

You need Python 2.4.x, subprocess is a new module in Python 2.4

Regards,
ismail
