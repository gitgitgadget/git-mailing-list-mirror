From: James Walmsley <james@fullfat-fs.co.uk>
Subject: Identify Commit ID from an Extracted Source Snapshot
Date: Thu, 16 Feb 2012 22:06:55 +0000
Message-ID: <BEDA323D25EF6045A68DAB9FD91A0BF123A85B38@DB3PRD0402MB118.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 16 23:07:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ry9Ts-0000r3-Jf
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 23:07:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687Ab2BPWHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 17:07:05 -0500
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:44317
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753981Ab2BPWHE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 17:07:04 -0500
Received: from mail209-ch1-R.bigfish.com (10.43.68.239) by
 CH1EHSOBE009.bigfish.com (10.43.70.59) with Microsoft SMTP Server id
 14.1.225.23; Thu, 16 Feb 2012 22:07:02 +0000
Received: from mail209-ch1 (localhost [127.0.0.1])	by
 mail209-ch1-R.bigfish.com (Postfix) with ESMTP id A06A4200485	for
 <git@vger.kernel.org>; Thu, 16 Feb 2012 22:07:01 +0000 (UTC)
X-SpamScore: 1
X-BigFish: PS1(zzzz1202hzzz32i2a8h668h839h944h)
X-Forefront-Antispam-Report: CIP:157.55.9.135;KIP:(null);UIP:(null);IPV:NLI;H:DB3PRD0402HT003.eurprd04.prod.outlook.com;RD:none;EFVD:NLI
Received: from mail209-ch1 (localhost.localdomain [127.0.0.1]) by mail209-ch1
 (MessageSwitch) id 1329430019748424_27506; Thu, 16 Feb 2012 22:06:59 +0000
 (UTC)
Received: from CH1EHSMHS002.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.236])	by mail209-ch1.bigfish.com (Postfix) with ESMTP id
 99E241C0047	for <git@vger.kernel.org>; Thu, 16 Feb 2012 22:06:59 +0000 (UTC)
Received: from DB3PRD0402HT003.eurprd04.prod.outlook.com (157.55.9.135) by
 CH1EHSMHS002.bigfish.com (10.43.70.2) with Microsoft SMTP Server (TLS) id
 14.1.225.23; Thu, 16 Feb 2012 22:06:57 +0000
Received: from DB3PRD0402MB118.eurprd04.prod.outlook.com ([169.254.8.74]) by
 DB3PRD0402HT003.eurprd04.prod.outlook.com ([10.3.187.86]) with mapi id
 14.15.0039.001; Thu, 16 Feb 2012 22:06:55 +0000
Thread-Topic: Identify Commit ID from an Extracted Source Snapshot
Thread-Index: Aczs9fQtDNNi4HyDRaSPl1uY1Z06RQAAN2OQAAAZm2A=
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.17.65.113]
X-OriginatorOrg: fullfat-fs.co.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190916>

Hi

I couldn't find this on google, and I have no idea if its even possible. I have several zip files from previous versions of my source code. (I imported svn into git).
I would like to add TAGS to git which represent the versions based on the files in my zip archives.

Does anyone know how to do this?

Thanks for any help in advance,

GIT is amazing!

James Walmsley
