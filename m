From: Phillip Susi <psusi@ubuntu.com>
Subject: Enabling scissors by default?
Date: Tue, 08 Jan 2013 16:42:30 -0500
Message-ID: <50EC92C6.7090509@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 22:43:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsgwg-0005hw-VF
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 22:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412Ab3AHVmd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 16:42:33 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:42330 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586Ab3AHVmc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 16:42:32 -0500
X-Authority-Analysis: v=2.0 cv=VZd1zSV9 c=1 sm=0 a=/DbS/tiKggfTkRRHPZEB4g==:17 a=Qsx_du5GiBkA:10 a=PJtIR_1cTkwA:10 a=7h0-D26dXtYA:10 a=S1A5HrydsesA:10 a=8nJEP1OIZ-IA:10 a=fxJcL_dCAAAA:8 a=EfLa-qcitT0A:10 a=QfKxxUxMAAAA:8 a=8Oxw-FJDfYSlFLrqOloA:9 a=wPNLvfGTeEIA:10 a=/DbS/tiKggfTkRRHPZEB4g==:117
X-Cloudmark-Score: 0
X-Authenticated-User: 
X-Originating-IP: 67.78.168.186
Received: from [67.78.168.186] ([67.78.168.186:64243] helo=[10.1.1.235])
	by cdptpa-oedge03.mail.rr.com (envelope-from <psusi@ubuntu.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id 00/DF-05345-6C29CE05; Tue, 08 Jan 2013 21:42:31 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/17.0 Thunderbird/17.0
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213008>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I was wondering why am's scissors option is not enabled by default.
It seems a very handy feature, but I'm reluctant to use it when
sending patches because the recipient has to notice the scissors and
remember to pass --scissors to git am.

Could this be made the default?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQEcBAEBAgAGBQJQ7JLGAAoJEJrBOlT6nu75iDYIANFiiH50RlL9WKEfaoybeA5K
ZLodBze1TcAYIx2/ad6qY+XCoq98+nVXTkv2IAleDiNlfeIhKD24UTWNCysT8p1J
5KeFfR4paxLJLJKkmSL5s3DJbyjLlJWcxD7vGku6F4k35NmY3VYR4rJ/CVv0YRrs
p4nNG/EXWBo3/ngiL9QS4E65N0CfcOOjn48RQUmk1DGXSFNHP4L1KuJ4dA9cs9BC
5KmNwh5X6OOal0Lf+ezbxzvoGMwQmhBAxx3t8JQR3E22dLQlUq7stlPl5LDd+Cis
XWfNk3B4NuFTum9LqWnM5TN89WCCFh4/pskdRd5ONF51G0jbuF/hBFbwU05qL/4=
=Qd94
-----END PGP SIGNATURE-----
