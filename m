From: "Hopkins, Jesse" <jesse.hopkins@lmco.com>
Subject: Incorrect documention for git-credential-store
Date: Thu, 23 Oct 2014 17:14:56 +0000
Message-ID: <E3D4929B4BF48B439B609986B0C719EA25896EBB@HDXDSP52.us.lmco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 23 21:22:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhNyC-0002T9-6O
	for gcvg-git-2@plane.gmane.org; Thu, 23 Oct 2014 21:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269AbaJWTWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2014 15:22:42 -0400
Received: from mailfo02.lmco.com ([192.35.35.12]:58936 "EHLO mailfo02.lmco.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751700AbaJWTWk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Oct 2014 15:22:40 -0400
X-Greylist: delayed 7653 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Oct 2014 15:22:40 EDT
Received: from HDXHTPN10.us.lmco.com (hdxhtpn10.ems.lmco.com [158.188.83.20])
	by mailfo02.lmco.com (8.14.5/8.14.5) with ESMTP id s9NHEIMK003216
	for <git@vger.kernel.org>; Thu, 23 Oct 2014 18:15:06 +0100
Received: from HDXDSP52.us.lmco.com ([fe80::35ac:f606:4171:7ca8]) by
 HDXHTPN10.us.lmco.com ([fe80::cc18:d817:48d2:b2b0%15]) with mapi id
 14.03.0174.001; Thu, 23 Oct 2014 11:14:57 -0600
Thread-Topic: Incorrect documention for git-credential-store
Thread-Index: Ac/u5MWOt0oC4+34TVqSVGj5NxameQ==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [158.188.95.6]
X-LM-Outbound: External 158.188.83.20 cntry=us g=c121af63cac238479bd3b3be874e4eab
 q=s9NHEIMK003216 m=18
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.12.52,1.0.28,0.0.0000
 definitions=2014-10-23_06:2014-10-23,2014-10-23,1970-01-01 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The man page for git-credential-store at
http://git-scm.com/docs/git-credential-store
and
https://www.kernel.org/pub/software/scm/git/docs/git-credential-store.html

incorrectly state that the option to change the credential storage path is '--store'.  The name of the option should be '--file'. I have noticed this running it 1.8.5.3

Regards - 
Jesse
