From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Regression in e02ca72: git svn rebase is broken on Windows
Date: Tue, 10 Sep 2013 18:13:10 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1309101812450.1191@s15462909.onlinehome-server.info>
References: <17231378818848@web5m.yandex.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Tvangeste <i.4m.l33t@yandex.ru>
X-From: git-owner@vger.kernel.org Tue Sep 10 18:13:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJQZ8-0002O1-5B
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 18:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926Ab3IJQNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 12:13:13 -0400
Received: from mout.gmx.net ([212.227.15.19]:64521 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751654Ab3IJQNN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 12:13:13 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0LjuR3-1VqIPP2Cl7-00bpzP
 for <git@vger.kernel.org>; Tue, 10 Sep 2013 18:13:10 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <17231378818848@web5m.yandex.ru>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:TSTA+qOoZKb9Q+Bxc0CqQThFhBrmWIx7bydgz+dwXPCt+xWFuuI
 tTWxcbOCifOwqK5j7x66kxowA/k0TvzY02jH4pHJDlid5sFtPtnWkONpAmZA+Ny44OC8Ja9
 liKHP/xCmW6yUs83dpiW108PGAiTVJvSVXASd75RDuT02skZUyjPwNAUQVUKsvF5TmiAB1t
 OFKNOi0uOdRpuDYPI+bRQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234439>

Hi Tvangeste,

On Tue, 10 Sep 2013, Tvangeste wrote:

> After bisecting this problem I ended up with the mentioned commit that
> completely breaks git-svn for me on Windows (mingw/msys version).

Have you tried with Git for Windows yet?

Ciao,
Johannes
