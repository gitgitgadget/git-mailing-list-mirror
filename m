From: Joydeep Bakshi <joydeep.bakshi@infoservices.in>
Subject: building git ; need suggestion
Date: Fri, 15 Mar 2013 17:54:05 +0530
Message-ID: <868B103B-690E-477B-BF75-8F954F893E6F@infoservices.in>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 13:30:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGTmR-0006Xv-Ez
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 13:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754361Ab3COMaK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 08:30:10 -0400
Received: from static.88-198-19-49.clients.your-server.de ([88.198.19.49]:45005
	"EHLO zimbra.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754333Ab3COMaJ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 08:30:09 -0400
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Mar 2013 08:30:09 EDT
Received: from localhost (localhost [127.0.0.1])
	by zimbra.infoservices.in (Postfix) with ESMTP id B054CDC1A33
	for <git@vger.kernel.org>; Fri, 15 Mar 2013 17:54:10 +0530 (IST)
X-Virus-Scanned: amavisd-new at zimbra.infoservices.in
Received: from zimbra.infoservices.in ([127.0.0.1])
	by localhost (zimbra.infoservices.in [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JPZG2cg8ETE0 for <git@vger.kernel.org>;
	Fri, 15 Mar 2013 17:54:08 +0530 (IST)
Received: from [192.168.1.116] (unknown [122.176.30.116])
	by zimbra.infoservices.in (Postfix) with ESMTPSA id 3BE93DC1A2F
	for <git@vger.kernel.org>; Fri, 15 Mar 2013 17:54:08 +0530 (IST)
X-Mailer: Apple Mail (2.1499)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218238>

Hello list,

Greetings !!!

I'm building a git repo on a dedicated server; hence need some kind gui=
delines from you.

[1] the server will have different git repo with branches
[2] there will be a web-based GUI which must be flexible to show just a=
 specific branch of a repo based on user authentication
[3] the web-based GUI should also have the flexibility to show a single=
 repo based on the authentication
[4] the web-based GUI should have an admin account to supervise and con=
figure all repos along with their branches
[3] there must be a control mechanism in the repo/web based GUI which h=
ave ACL on branches i.e.
some specific users should see some specific/ or just a branch and able=
 to commit there only.

based on the above scenario could anyone suggest the best available sol=
ution ?
There are many like gitolike/github etc=85. but don't know whig one has=
 much finer granular
control/ACL/web-based GUI=85

Thanks in advanced for your kind response.
