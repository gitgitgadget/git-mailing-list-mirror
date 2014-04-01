From: Phillip Susi <psusi@ubuntu.com>
Subject: Repository formats
Date: Tue, 01 Apr 2014 10:18:55 -0400
Message-ID: <533ACACF.408@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 01 16:19:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUzWp-0004jF-EJ
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 16:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbaDAOS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 10:18:58 -0400
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:44539 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbaDAOS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 10:18:57 -0400
X-Authority-Analysis: v=2.0 cv=H69ZMpki c=1 sm=0 a=/DbS/tiKggfTkRRHPZEB4g==:17 a=h2n2wN--3AMA:10 a=S1A5HrydsesA:10 a=Qsx_du5GiBkA:10 a=8nJEP1OIZ-IA:10 a=fxJcL_dCAAAA:8 a=KGjhK52YXX0A:10 a=QfKxxUxMAAAA:8 a=CzSdqvXVPoGPcfOfQ7sA:9 a=wPNLvfGTeEIA:10 a=/DbS/tiKggfTkRRHPZEB4g==:117
X-Cloudmark-Score: 0
X-Authenticated-User: 
X-Originating-IP: 67.78.168.186
Received: from [67.78.168.186] ([67.78.168.186:61194] helo=[10.1.1.236])
	by cdptpa-oedge04.mail.rr.com (envelope-from <psusi@ubuntu.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id F9/DE-11872-DCACA335; Tue, 01 Apr 2014 14:18:53 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245590>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I have seen some discussion about various changes to the format of the
index and pack files over time, but can't find anything about it in
the man pages.  Are the different formats documented anywhere, and how
to tell which format you are using?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJTOsrPAAoJEI5FoCIzSKrwk2cIAIKZYz4yBoKjDUitHrSmhuMo
Rb9x+A1mISnzeTon30BGacPkMUppvPI3RFQIA2VgmstrBVrT8QrKMH2Ir91gmEs4
rLW5LkhRv7OATDdMy6UIJHej+rTMUXZo22+2BVTPKsS0vbtiHC9ypOweIk911jxw
PutmeBMLrc1h8eznsKGptZwxIB4bJThYIixR767XVFb53R2XTosj7gINOUsVzOM/
TFtkp3eo+TD852RZ31wNxhzukUA3O7zqdNLYpUD5zkpniGYhaKxruEPfL0Wy43dS
3cmFztoHFlIoeNesJhFNtnP7VPlfO6/D8C1PgSIPHyg7aBFoFjreQgTr6j24uvo=
=yiki
-----END PGP SIGNATURE-----
