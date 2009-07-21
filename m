From: Daniel Trstenjak <trsten@science-computing.de>
Subject: Getting untracked files
Date: Tue, 21 Jul 2009 17:25:03 +0200
Message-ID: <20090721152458.GH24439@bug.science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Trstenjak <Daniel.Trstenjak@online.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 21 17:38:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTHQ0-00079B-Ay
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 17:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400AbZGUPiI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jul 2009 11:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbZGUPiH
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 11:38:07 -0400
Received: from smtp2.belwue.de ([129.143.2.15]:45292 "EHLO smtp2.belwue.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751124AbZGUPiH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jul 2009 11:38:07 -0400
X-Greylist: delayed 776 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Jul 2009 11:38:06 EDT
Received: from mx3.science-computing.de (mx3.science-computing.de [193.197.16.20])
	by smtp2.belwue.de with ESMTP id n6LFP8wZ007177
	for <git@vger.kernel.org>; Tue, 21 Jul 2009 17:25:08 +0200 (MEST)
	env-from (prvs=44694d3a7=D.Trstenjak@science-computing.de)
X-IronPort-AV: E=Sophos;i="4.43,240,1246831200"; 
   d="scan'208";a="68245"
Received: from unknown (HELO scmail.science-computing.de) ([192.168.2.1])
  by mx3.science-computing.de with ESMTP; 21 Jul 2009 17:25:08 +0200
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id D4A0BAC002;
	Tue, 21 Jul 2009 17:25:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (guinesstest.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NOhWPB0EhCPs; Tue, 21 Jul 2009 17:25:03 +0200 (CEST)
Received: from bug.science-computing.de (bug.science-computing.de [10.10.8.89])
	by scmail.science-computing.de (Postfix) with ESMTP id 7089FAC001;
	Tue, 21 Jul 2009 17:25:03 +0200 (CEST)
Received: by bug.science-computing.de (Postfix, from userid 1014)
	id 40E9B1285E1; Tue, 21 Jul 2009 17:25:03 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123670>


Hi all,

is there a nicer way to get the untracked files then
with grepping the output of 'git status'?

Is there a plumbing command?



Greetings,
Daniel

--=20
                                                                       =
                                                                   =20
 Daniel Trstenjak         Tel   : +49 (0)7071-9457-264
 science + computing ag   FAX   : +49 (0)7071-9457-511
 Hagellocher Weg 73       mailto: Daniel.Trstenjak@science-computing.de
 D-72070 T=FCbingen         WWW   : http://www.science-computing.de/   =
                                                                  =20
--=20
Vorstand/Board of Management:
Dr. Bernd Finkbeiner, Dr. Roland Niemeier,=20
Dr. Arno Steitz, Dr. Ingrid Zech
Vorsitzender des Aufsichtsrats/
Chairman of the Supervisory Board:
Michel Lepert
Sitz/Registered Office: Tuebingen
Registergericht/Registration Court: Stuttgart
Registernummer/Commercial Register No.: HRB 382196=20
