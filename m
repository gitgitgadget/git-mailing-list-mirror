From: Woody Wu <woody.wu@vip.163.com>
Subject: Big repository cannot be reduced
Date: Wed, 16 Jul 2014 00:43:43 +0800
Message-ID: <a45d5548-b577-4588-92db-75339498034d@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 15 18:44:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X75qa-0004Ka-Rh
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 18:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115AbaGOQox convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jul 2014 12:44:53 -0400
Received: from m181-177.vip.163.com ([123.58.177.181]:45799 "EHLO
	m181-177.vip.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960AbaGOQow (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 12:44:52 -0400
Received: from [192.168.1.13] (unknown [183.45.123.178])
	by smtp2 (Coremail) with SMTP id oWZ4CkDpPUGCWsVTLTZGAA--.12132S2;
	Wed, 16 Jul 2014 00:44:50 +0800 (CST)
User-Agent: K-9 Mail for Android
X-CM-TRANSID: oWZ4CkDpPUGCWsVTLTZGAA--.12132S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUTt80UUUUU
X-Originating-IP: [183.45.123.178]
X-CM-SenderInfo: xzrrv5gozxq4llsoil2tof0z/1tbiFRTJmFO2bW6o+AAAsm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253572>

Hi,

I have tried some methods introduced in the network, but always failed.=
 =C2=A0Some big files committed by me to a very old branch then the fil=
es deleted and new branches were continuously created. Now the checkout=
 directory has grown to about 80 megabytes. =C2=A0What's the right way =
to permenently erase those garbage big files?

Thanks in advance.
-
Woody Wu from mobile phone
