From: Daniel Trstenjak <Daniel.Trstenjak@science-computing.de>
Subject: 'git stash apply' in dirty working directory
Date: Tue, 15 Sep 2009 15:05:26 +0200
Message-ID: <20090915130526.GA26131@bug.science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 15:17:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnXuv-0007KG-33
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 15:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753829AbZIONRY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Sep 2009 09:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753531AbZIONRW
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 09:17:22 -0400
Received: from smtp2.belwue.de ([129.143.2.15]:42360 "EHLO smtp2.belwue.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753841AbZIONRV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Sep 2009 09:17:21 -0400
X-Greylist: delayed 711 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Sep 2009 09:17:21 EDT
Received: from mx3.science-computing.de (mx3.science-computing.de [193.197.16.20])
	by smtp2.belwue.de with ESMTP id n8FD5Wve027852
	for <git@vger.kernel.org>; Tue, 15 Sep 2009 15:05:32 +0200 (MEST)
	env-from (prvs=502079ea3=D.Trstenjak@science-computing.de)
X-IronPort-AV: E=Sophos;i="4.44,390,1249250400"; 
   d="scan'208";a="227509"
Received: from unknown (HELO scmail.science-computing.de) ([192.168.2.1])
  by mx3.science-computing.de with ESMTP; 15 Sep 2009 15:05:32 +0200
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id C1B28414002
	for <git@vger.kernel.org>; Tue, 15 Sep 2009 15:05:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (obitest.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VXmTw8DqE0cY for <git@vger.kernel.org>;
	Tue, 15 Sep 2009 15:05:27 +0200 (CEST)
Received: from bug.science-computing.de (bug.science-computing.de [10.10.8.89])
	by scmail.science-computing.de (Postfix) with ESMTP id 0D95A414001
	for <git@vger.kernel.org>; Tue, 15 Sep 2009 15:05:27 +0200 (CEST)
Received: by bug.science-computing.de (Postfix, from userid 1014)
	id DB72C12852E; Tue, 15 Sep 2009 15:05:26 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128542>


Hi all,

isn't the stash for fumbling around with my working directory?
So why I shouldn't be able to apply the stash to a dirty working direct=
ory?

I'm not even a fan of not being able to pull in a dirty working
directory. There might be some arguments for it, but most of them
boil down that you better should know what you're doing.=20

But not being able to apply the stash to a dirty working directory?
Come on!




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
