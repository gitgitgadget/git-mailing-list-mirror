From: Stephen Scott <sscott@intellimec.com>
Subject: Remote End Hung Up Error
Date: Mon, 11 May 2015 18:14:53 +0000
Message-ID: <8FF1A22F7C52194BA8546AEBBC84EF5D1A9B4E1F@ims-exch1vc-wat.imscorp.intellimec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 11 20:15:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrsEJ-0004ai-1S
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 20:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301AbbEKSO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 14:14:57 -0400
Received: from mail.intellimec.com ([216.16.251.249]:62065 "EHLO
	ims-exch1vc-wat.imscorp.intellimec.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753598AbbEKSOy convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 14:14:54 -0400
Received: from IMS-EXCH1VC-WAT.imscorp.intellimec.com
 ([fe80::7de3:2812:22a5:6300]) by ims-exch1vc-wat.imscorp.intellimec.com
 ([fe80::7de3:2812:22a5:6300%11]) with mapi id 14.01.0438.000; Mon, 11 May
 2015 14:14:54 -0400
Thread-Topic: Remote End Hung Up Error
Thread-Index: AdCMFl+BAVI5VfhQR02c/xnuHkhgKA==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.20.220]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268812>

Greetings;

I am getting this error when trying to retrieve a repo from git. Has anyone seen this issue before, and if you have how did you resolve it.

Cloning into 'xxxxxxxxx'...
remote: Counting objects: 187683, done
remote: Finding sources: 100% (187683/187683)
remote: Getting sizes: 100% (98684/98684)
remote: Compressing objects: 89% (8667/9643)
efrror: RPC failed; result=56, HTTP code = 200 MiB | 42.00 KiB/s
fatal: The remote end hung up unexpectedly
atal: early EOF
fatal: index-pack failed

Cloning into 'xxxxxxxxx'...
remote: Counting objects: 187683, done
remote: Finding sources: 100% (187683/187683)
efrror: RPC failed; result=56, HTTP code = 200
atal: The remote end hung up unexpectedly
fatal: protocol error: bad pack header

Thank you in advance;
Stephen Scott
This e-mail message is confidential, may be privileged and is intended for the exclusive use of the addressee. Any other person is strictly prohibited from disclosing, distributing or reproducing it. If the addressee cannot be reached or is unknown to you, please inform us immediately and delete this e-mail message and destroy all copies. Thank you.
