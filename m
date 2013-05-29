From: =?ISO-8859-2?Q?=22=C1kos=2C_Tajti=22?= <akos.tajti@intland.com>
Subject: git init doesn't create master branch
Date: Wed, 29 May 2013 14:47:28 +0200
Message-ID: <51A5F8E0.8060906@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 14:47:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhfmy-0004ED-HG
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 14:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759559Ab3E2Mrb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 08:47:31 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:52934 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759549Ab3E2Mrb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 08:47:31 -0400
Received: from [127.0.0.1] (188-143-39-115.pool.digikabel.hu [188.143.39.115])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MbLRw-1Uy6i52x9w-00J469; Wed, 29 May 2013 14:47:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
X-Antivirus: avast! (VPS 130529-0, 2013.05.29), Outbound message
X-Antivirus-Status: Clean
X-Provags-ID: V02:K0:PtSmQ//UANsmfN0cFrx8DGXrAOdG2P80WEa33M4sKd6
 qzEyAxhJ2EhiPLSkqcRt9kIq4bweBdDpTqHoiEZhaRO3vOIjyj
 BKgOyeHs8zFAvM2vXGxmzlqprLyRTZ/JYV90psBYfatPMt+TBd
 Ah75hgW2kmewm1A7R+YmrBwJuqx3g0r+F3wUnfxGvBtJsvxFIe
 y9WEKUsOaWq+9YlfxMYKRg854oUlCUdvSsvmn8JqzI4whY6vm5
 h4c+m2SAGO4we0ms4XKyyPnebiBVcVlIEgOXkWvoJgQPPzlLL0
 Xlt4Nb7gBlBW98Jg5odFTkUu00SakMxDVtq9Ksvq6nLWR5OY85
 G1299Z2GFAgZdDuBJ4mI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225803>

Dear List,

the manual of git init says: "An initial HEAD file that references the=20
HEAD of the master branch is also created."

However, after creating the repository using git init there's no master=
=20
branch. How can make sure that master is created?

Thanks in advance,
=C1kos Tajti
