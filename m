From: Mike Hall <mikehall@enginsol.com>
Subject: Changing Spell checker under GIT
Date: Thu, 17 Jan 2013 19:08:09 +0000
Message-ID: <189327E1D7E3B64286ED8625AAEC642C08633B01@MDHQEXCH01.enginsol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 20:13:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvuuT-0000my-Qr
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 20:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753930Ab3AQTNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 14:13:37 -0500
Received: from mail.enginsol.com ([50.201.218.97]:23306 "EHLO
	mdhqvexch02.enginsol.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751814Ab3AQTNg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 14:13:36 -0500
X-Greylist: delayed 324 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Jan 2013 14:13:36 EST
Received: from MDHQEXCH01.enginsol.com ([fe80::950:2edd:ebfe:c41c]) by
 mdhqvexch02.enginsol.com ([fe80::5d8d:6e38:3552:78b5%11]) with mapi id
 14.01.0438.000; Thu, 17 Jan 2013 14:08:09 -0500
Thread-Topic: Changing Spell checker under GIT
Thread-Index: Ac305f0qGztgOaIBRG6flTB3+MKK6w==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [63.239.65.11]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213872>

As my organization has change from RedHat 5 to RedHat 6 Linux,
it appears that RedHat is trying to replace (deprecate) ispell/aspell
with a different tool (hunspell).

It appears that GIT GUI current supports changing the dictionary used
to support spell checks.   Is there currently a way to change the
spell check program to be used(can't find in documentation or version
of code that I'm currently installing), or would someone consider this
as a future program change?

Thanks for your time.
Mike Hall