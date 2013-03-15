From: Joydeep Bakshi <joydeep.bakshi@infoservices.in>
Subject: Re: building git ; need suggestion
Date: Fri, 15 Mar 2013 18:13:28 +0530
Message-ID: <FB013A89-A4A5-431B-A288-D0C922F156A4@infoservices.in>
References: <868B103B-690E-477B-BF75-8F954F893E6F@infoservices.in>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 13:44:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGTzN-0004YB-Tw
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 13:44:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754448Ab3COMnf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 08:43:35 -0400
Received: from static.88-198-19-49.clients.your-server.de ([88.198.19.49]:45446
	"EHLO zimbra.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754440Ab3COMne convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 08:43:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.infoservices.in (Postfix) with ESMTP id 5C910CF7BC6
	for <git@vger.kernel.org>; Fri, 15 Mar 2013 18:13:33 +0530 (IST)
X-Virus-Scanned: amavisd-new at zimbra.infoservices.in
Received: from zimbra.infoservices.in ([127.0.0.1])
	by localhost (zimbra.infoservices.in [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VkQAhe6IBv3j for <git@vger.kernel.org>;
	Fri, 15 Mar 2013 18:13:32 +0530 (IST)
Received: from [192.168.1.116] (unknown [122.176.30.116])
	by zimbra.infoservices.in (Postfix) with ESMTPSA id B9D75CF7ACB
	for <git@vger.kernel.org>; Fri, 15 Mar 2013 18:13:31 +0530 (IST)
In-Reply-To: <868B103B-690E-477B-BF75-8F954F893E6F@infoservices.in>
X-Mailer: Apple Mail (2.1499)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218241>


forgot to mention:
------------------------

a code review system like gerrit is also helpful, but don't know if ger=
rit
has such fine control mechanism.




On 15-Mar-2013, at 5:54 PM, Joydeep Bakshi <joydeep.bakshi@infoservices=
=2Ein> wrote:

> Hello list,
>=20
> Greetings !!!
>=20
> I'm building a git repo on a dedicated server; hence need some kind g=
uidelines from you.
>=20
> [1] the server will have different git repo with branches
> [2] there will be a web-based GUI which must be flexible to show just=
 a specific branch of a repo based on user authentication
> [3] the web-based GUI should also have the flexibility to show a sing=
le repo based on the authentication
> [4] the web-based GUI should have an admin account to supervise and c=
onfigure all repos along with their branches
> [3] there must be a control mechanism in the repo/web based GUI which=
 have ACL on branches i.e.
> some specific users should see some specific/ or just a branch and ab=
le to commit there only.
>=20
> based on the above scenario could anyone suggest the best available s=
olution ?
> There are many like gitolike/github etc=85. but don't know whig one h=
as much finer granular
> control/ACL/web-based GUI=85
>=20
> Thanks in advanced for your kind response.
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
