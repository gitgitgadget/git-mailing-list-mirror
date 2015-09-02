From: =?iso-8859-1?Q?Jesper_J=F8rgensen?= <Jesper.Jorgensen@prevas.dk>
Subject: Git book figure bug
Date: Wed, 2 Sep 2015 07:45:21 +0000
Message-ID: <FADA8795DF99B842A563D149FBDDAE5F58341EF5@VMPREVAS2.prevas.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 02 09:45:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZX2jX-00085i-4z
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 09:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbbIBHpX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Sep 2015 03:45:23 -0400
Received: from mail01.prevas.se ([62.95.78.3]:26966 "EHLO mail01.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806AbbIBHpX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Sep 2015 03:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=prevas.dk; i=@prevas.dk; l=734; q=dns/txt;
  s=ironport1; t=1441179923; x=1472715923;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=LvaczWQt2Rj288MufTMOIrG0l1Sp/n0Za3U9RwHbeV0=;
  b=RIGvbAE6+D2Gu/RGAQTJN9cIv0xzcvt6UlvbCvxBQBaAiZGEaryWagro
   b/QcRbs0EiWBGX/yW0B9EYlMnuBL/jE7F1NoZPESq23g9yO798X7N0vGh
   zZwEINXB5ubgprFX2kZ9Ke14XcbEo2dgdLC/bGAsSMMdNmec/bxDZoCgY
   0=;
X-IronPort-AV: E=Sophos;i="5.17,451,1437429600"; 
   d="scan'208";a="6325616"
Received: from vmprevas3.prevas.se (HELO smtp.prevas.se) ([172.16.8.103])
  by ironport1.prevas.se with ESMTP/TLS/AES128-SHA; 02 Sep 2015 09:45:21 +0200
Received: from VMPREVAS2.prevas.se ([fe80::ddc4:1ca4:65e1:d098]) by
 VMPREVAS3.prevas.se ([172.16.8.103]) with mapi id 14.02.0387.000; Wed, 2 Sep
 2015 09:45:21 +0200
Thread-Topic: Git book figure bug
Thread-Index: AdDlU0nOgG4SXHqHSKuEhpb+hYOvEg==
Accept-Language: en-GB, sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.11.4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277077>

Hi,

I am learning how git works, and is using the excellent book on the off=
icial site.=20
I believe I have located a mistake in one of the images.=20
It is  about Figure 3.17 on this page : http://git-scm.com/book/en/v2/G=
it-Branching-Basic-Branching-and-Merging

As far as I understand it, the right most snapshot called C5 should hav=
e been named C6.=20
The texts describes a new snapshot being made from the merge of the 2 b=
ranches.=20
Having 2 snapshots both named C5 does not seem like it can be possible.=
=20

Best regards
JESPER J=D8RGENSEN, Prevas A/S
Software developer, Aarhus
Hedeager 1, DK-8200 Aarhus N=20
Phone +45 87438070
Mobile +45 40282198
jesper.jorgensen@prevas.dk
www.prevas.dk

=20
