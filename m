From: "Kiser, Ryan Lee" <rlkiser@iu.edu>
Subject: File Hash for Windows executable
Date: Mon, 10 Aug 2015 13:54:11 +0000
Message-ID: <e44d9f36ecee4fd5965444deed1877f7@bl-cci-exch01.ads.iu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 10 16:03:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOngB-0007ti-VU
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 16:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388AbbHJODv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 10:03:51 -0400
Received: from hartman.uits.indiana.edu ([129.79.1.194]:4815 "EHLO
	hartman.uits.indiana.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbbHJODu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2015 10:03:50 -0400
X-Greylist: delayed 578 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Aug 2015 10:03:50 EDT
X-IronPort-AV: E=Sophos;i="5.15,645,1432612800"; 
   d="scan'208";a="277562102"
Received: from mssg-relay.indiana.edu ([129.79.1.73])
  by irpt-internal-relay.indiana.edu with ESMTP; 10 Aug 2015 09:54:12 -0400
Received: from bl-cci-exch03.ads.iu.edu (bl-cci-exch03.ads.iu.edu [10.79.80.136])
	by mssg-relay.indiana.edu (8.14.7/8.14.4/IU Campus Communications Team) with ESMTP id t7ADsBfQ026401
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Mon, 10 Aug 2015 09:54:12 -0400
Received: from bl-cci-exch01.ads.iu.edu (2001:18e8:2:cc1::10a) by
 bl-cci-exch03.ads.iu.edu (2001:18e8:2:cc1::10c) with Microsoft SMTP Server
 (TLS) id 15.0.1104.5; Mon, 10 Aug 2015 09:54:11 -0400
Received: from bl-cci-exch01.ads.iu.edu ([fe80::55a7:2eca:d7bd:dd6]) by
 bl-cci-exch01.ads.iu.edu ([fe80::55a7:2eca:d7bd:dd6%22]) with mapi id
 15.00.1104.000; Mon, 10 Aug 2015 09:54:11 -0400
Thread-Topic: File Hash for Windows executable
Thread-Index: AdDTczTyRg3s1Zd+SLyt+RCDLc6Mhw==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [129.79.49.213]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275623>

Hello,

I've downloaded the Windows installer for Git, but can't seem to find hashes published anywhere for verification. Since the downloaded file doesn't seem to be signed, I'll need another way to verify it's integrity before running it on my system.

Are hashes published somewhere that I'm missing? If not, is this planned for the future?

Thank you,

Ryan
