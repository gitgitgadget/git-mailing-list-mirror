From: =?ISO-8859-1?Q?Gonzalo_Garramu=F1o?= <ggarra@advancedsl.com.ar>
Subject: cvs -> git tools?
Date: Fri, 21 Dec 2007 17:10:06 -0300
Message-ID: <476C1D9E.4060700@advancedsl.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 21 21:35:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5oaw-0005vv-Oi
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 21:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457AbXLUUfX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Dec 2007 15:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753423AbXLUUfW
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 15:35:22 -0500
Received: from gunalda.terra.com ([66.119.66.231]:13410 "EHLO
	gunalda.terra.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627AbXLUUfW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 15:35:22 -0500
X-Greylist: delayed 1503 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Dec 2007 15:35:22 EST
Received: from gorolba.terra.com (gorolba.terra.com [66.119.66.228])
	by gunalda.terra.com (Postfix) with ESMTP id AA587D20C79
	for <git@vger.kernel.org>; Fri, 21 Dec 2007 15:12:18 -0500 (EST)
Received: from elimba.terra.com (elimba.terra.com [66.119.66.67])
	by gorolba.terra.com (Postfix) with ESMTP id 7AC31B1C10A
	for <git@vger.kernel.org>; Fri, 21 Dec 2007 15:10:12 -0500 (EST)
X-Terra-Karma: 0%
X-Terra-Hash: 88e7cf4a0b4e0b1c3f09906d98ca1fed
Received-SPF: none (elimba.terra.com: 66.119.66.67 is neither permitted nor denied by domain of advancedsl.com.ar) client-ip=66.119.66.67; envelope-from=ggarra@advancedsl.com.ar; helo=[192.168.1.3];
Received: from [192.168.1.3] (unknown [201.255.55.187])
	(authenticated user ggarra@advancedsl.com.ar)
	by elimba.terra.com (Postfix) with ESMTP id 23DB61BC0A6
	for <git@vger.kernel.org>; Fri, 21 Dec 2007 15:10:05 -0500 (EST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69090>


I was wondering if there were any tools to keep a mirror repository of=20
CVS as a git repository.

Basically, I would like to mirror a CVS repository (that I don't=20
control) as a git "main" branch.  This CVS repository is live and=20
expected to remain so.

I would then work on another git branch and would do merges from the=20
main branch to mine as I see fit to develop some stuff.

Is there anything like that?   Basically, I'm looking for the equivalen=
t=20
of Tailor for Mercurial.

---

As a second question...

Are there any good websites that can host a git repository?  Something=20
equivalent to sourceforge but for git.



--=20
Gonzalo Garramu=F1o
ggarra@advancedsl.com.ar

AMD4400 - ASUS48N-E
GeForce7300GT
Xubuntu Gutsy
