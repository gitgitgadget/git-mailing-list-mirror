From: Robert Haines <rhaines@manchester.ac.uk>
Subject: CVS import: Changing/cleaning authors and committers
Date: Thu, 24 Jan 2008 15:12:08 +0000
Message-ID: <1424F1B0-7342-4436-9B4A-72D985DDA161@manchester.ac.uk>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 24 16:37:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI494-0004Rt-LG
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 16:37:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752436AbYAXPhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 10:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbYAXPhF
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 10:37:05 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:52013 "EHLO
	probity.mcc.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422AbYAXPhD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 10:37:03 -0500
X-Greylist: delayed 1532 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jan 2008 10:37:03 EST
Received: from gerhayn.mcc.ac.uk ([10.2.18.1])
	by probity.mcc.ac.uk with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.63 (FreeBSD))
	(envelope-from <rhaines@manchester.ac.uk>)
	id 1JI3jj-0003fY-3L; Thu, 24 Jan 2008 15:11:27 +0000
Received: from leela.rcs.manchester.ac.uk ([130.88.1.66]:54986)
	by gerhayn.mcc.ac.uk with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.67 (FreeBSD))
	(envelope-from <rhaines@manchester.ac.uk>)
	id 1JI3ji-000PNo-Uz; Thu, 24 Jan 2008 15:11:26 +0000
X-Mailer: Apple Mail (2.753)
X-Authenticated-Sender: Robert Haines from leela.rcs.manchester.ac.uk [130.88.1.66]:54986
X-Authenticated-From: Robert.Haines@manchester.ac.uk
X-UoM: Scanned by the University Mail System. See http://www.itservices.manchester.ac.uk/email/filtering/information/ for details.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71623>

Hi all,

I am very new to git, but already impressed! I am in the process of  
converting my old CVS repos into git. So far so good, it all works  
with 'git cvsimport' but I was wondering about the author and  
committer names. All mine have come out as the username of the person  
who committed the change into CVS:

author xxcguxx <xxcguxx>
committer xxcguxx <xxcguxx>

I was wondering if it would be able to go through and change all that  
to:

author Name <email@address>
etc

Is this something that can be retrospectively done? Is it something  
that can be done during cvsimport? Is it even doable?

Any suggestions gratefully received!

Best wishes,
Rob

--
Robert Haines

Research Associate, RealityGrid          Tel. : +44 (0)161 275 6067
Research Computing Services              Fax. : +44 (0)161 275 0637
Kilburn Building                         Email: rhaines@manchester.ac.uk
University of Manchester                 Web  : www.realitygrid.org
Manchester, M13 9PL, UK                       : www.rcs.manchester.ac.uk
