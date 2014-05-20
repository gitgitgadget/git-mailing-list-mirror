From: "Stewart, Louis (IS)" <louis.stewart@ngc.com>
Subject: GIT and large files
Date: Tue, 20 May 2014 15:37:41 +0000
Message-ID: <C755E6FBF6DC4447BEF161CE48BDE0BD2F0CD53E@XMBVAG73.northgrum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 20 17:39:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmm8K-0006WQ-CS
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 17:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258AbaETPjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 11:39:12 -0400
Received: from xspv0103.northgrum.com ([134.223.120.78]:10705 "EHLO
	xspv0103.northgrum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704AbaETPjM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 May 2014 11:39:12 -0400
Received: from XHTV0002.northgrum.com (unknown [134.223.80.11]) by xspv0103.northgrum.com with smtp
	(TLS: TLSv1/SSLv3,128bits,AES128-SHA)
	 id 33dd_069a_9be7b01c_6162_41b2_91f5_75e47dc20055;
	Tue, 20 May 2014 10:39:10 -0500
Received: from XHTVAG06.northgrum.com (134.223.82.83) by
 XHTV0002.northgrum.com (134.223.80.11) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Tue, 20 May 2014 10:37:41 -0500
Received: from XMBVAG73.northgrum.com ([169.254.4.90]) by
 XHTVAG06.northgrum.com ([134.223.82.83]) with mapi id 14.03.0174.001; Tue, 20
 May 2014 10:37:41 -0500
Thread-Topic: GIT and large files
Thread-Index: Ac90P2xEaMppYEtOT9uXMBUN72rp1QAAdwMQ
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.223.82.117]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249695>

Can GIT handle versioning of large 20+ GB files in a directory?

Lou Stewart
AOCWS Software Configuration Management
757-269-2388
