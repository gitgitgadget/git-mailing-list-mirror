From: "McChesney, Adam" <Adam.McChesney@kbslp.com>
Subject: RE: Git installer questions
Date: Tue, 7 Jul 2015 16:39:09 -0500
Message-ID: <47895290476F5048B96E7C3589EE00B821DDBE58E7@MSGICTC.kochind.com>
References: <47895290476F5048B96E7C3589EE00B821DD60F1DC@MSGICTC.kochind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "'git@vger.kernel.org'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 07 23:40:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCabU-00025R-Bz
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 23:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758096AbbGGVkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 17:40:33 -0400
Received: from mx0a-00164e01.pphosted.com ([67.231.148.85]:20159 "EHLO
	mx0a-00164e01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758121AbbGGVk1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Jul 2015 17:40:27 -0400
Received: from pps.filterd (m0048132.ppops.net [127.0.0.1])
	by mx0a-00164e01.pphosted.com (8.15.0.59/8.14.7) with SMTP id t67LXnSZ003836
	for <git@vger.kernel.org>; Tue, 7 Jul 2015 16:40:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kbslp.com; h=from : to : date :
 subject : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=00164E01;
 bh=1rbDrfzi284iy+fEXxp1hQrhg5agrceRNjLDb3Z/dtQ=;
 b=bGwAmiG8vrH+BSCijYQP552inTUShj6eg6i6fsQg/jCLG3pZ4KZFKtXPcWFHei+RTJ/z
 qXvjiTh6RtEGsHEFSHzVWwlvEpkllhHkE9MmDPg3Wct39n0FDJ6/bJK3cOJwydyiRtoO
 YtwHHeTOkaaiQl459Mzk9e6/GWLOvsQKQbyBYyajxfrbCdPx6+kMLCVoyyNssWBEra+n
 VMLN4GRgq0qzpmHelhukeJEAqRyYJpkVqaqSmO6WrGTgJkbeGdB7mqcpFNTIZRVG4qEB
 tErwWP2DKPY7SEVhUX61erFEwidodGIq5vGCev5Z5DGbvmHkW+i5U076D4gfkHn1mhHY uQ== 
Received: from msgictmtaout.kochind.com ([146.209.148.136])
	by mx0a-00164e01.pphosted.com with ESMTP id 1vgp4g834u-1
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 07 Jul 2015 16:40:24 -0500
Received: from MSGSMTPICTA.kochind.com (unknown [146.209.235.11]) by MSGICTMTAOUT.kochind.com with smtp
	(TLS: TLSv1/SSLv3,128bits,AES128-SHA)
	 id 6b62_1dd4_c7df1c0a_338d_48ef_bafa_15532a252b5b;
	Tue, 07 Jul 2015 16:40:23 -0500
Received: from MSGICTC.kochind.com ([146.209.235.19]) by
 MSGSMTPICTA.kochind.com ([146.209.235.11]) with mapi; Tue, 7 Jul 2015
 16:39:11 -0500
Thread-Topic: Git installer questions
Thread-Index: AdC4+Mx+hJcKmdBGT02/7wMDNTOGaAABH3wQ
In-Reply-To: <47895290476F5048B96E7C3589EE00B821DD60F1DC@MSGICTC.kochind.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.14.151,1.0.33,0.0.0000
 definitions=2015-07-07_07:2015-07-07,2015-07-07,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbounddefaultpolicy_notspam policy=outbounddefaultpolicy score=0
 spamscore=0 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=7.0.1-1506180000
 definitions=main-1507070327
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273604>

I am curious as whether or not the windows installer has silent install flags that are configurable for automated installation? I was looking about the documentation and haven't been able to find them, if it does exist in the documentation could you point me to where they might be?

Thanks,
Adam Mcchesney 
