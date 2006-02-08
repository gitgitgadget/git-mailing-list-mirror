From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] Add git-annotate - a tool for annotating files with  the revision and person that created each line in the file.
Date: 08 Feb 2006 10:47:40 -0800
Message-ID: <86ek2dsn5f.fsf@blue.stonehenge.com>
References: <11394103753694-git-send-email-ryan@michonline.com>
	<cda58cb80602080835s38713193t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <ryan@michonline.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 08 19:47:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6uM1-0005cx-4u
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 19:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030450AbWBHSrq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 13:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030451AbWBHSrq
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 13:47:46 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:9087 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1030450AbWBHSrp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 13:47:45 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 9F1768F597;
	Wed,  8 Feb 2006 10:47:40 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 03741-02-30; Wed,  8 Feb 2006 10:47:40 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 2C2BE8F598; Wed,  8 Feb 2006 10:47:40 -0800 (PST)
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
x-mayan-date: Long count = 12.19.13.0.12; tzolkin = 5 Eb; haab = 10 Pax
In-Reply-To: <cda58cb80602080835s38713193t@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15745>

>>>>> "Franck" == Franck Bui-Huu <vagabon.xyz@gmail.com> writes:

Franck> another perl script :(

Franck> Are there any rules on the choice of the script language ?

I could argue that they should all be Perl. :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
