From: Lars Noschinski <lars@public.noschinski.de>
Subject: Re: [PATCH] cvsserver: add option to configure commit message
Date: Sun, 4 Jan 2009 12:23:18 +0100
Message-ID: <20090104112318.GB7732@lars.home.noschinski.de>
References: <1230910814-32307-1-git-send-email-fabian.emmes@rwth-aachen.de> <7viqovz8y0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Fabian Emmes <fabian.emmes@rwth-aachen.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 04 12:24:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJR67-00011E-Hs
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 12:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbZADLX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 06:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbZADLX1
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 06:23:27 -0500
Received: from smtprelay08.ispgateway.de ([80.67.29.8]:51009 "EHLO
	smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbZADLX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 06:23:26 -0500
Received: from [87.78.124.200] (helo=vertikal.home.noschinski.de)
	by smtprelay08.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <lars@public.noschinski.de>)
	id 1LJR4g-0000r7-SG; Sun, 04 Jan 2009 12:23:19 +0100
Received: from lars by vertikal.home.noschinski.de with local (Exim 4.69)
	(envelope-from <lars@public.noschinski.de>)
	id 1LJR4g-0002RR-6L; Sun, 04 Jan 2009 12:23:18 +0100
Content-Disposition: inline
In-Reply-To: <7viqovz8y0.fsf@gitster.siamese.dyndns.org>
User-Agent: mutt-ng/devel-r804 (Linux)
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104507>

* Junio C Hamano <gitster@pobox.com> [09-01-04 12:13]:
>Fabian Emmes <fabian.emmes@rwth-aachen.de> writes:
>
>> cvsserver annotates each commit message by "via git-CVS emulator". This is
>> made configurable via gitcvs.commitmsgannotation.
>>
>> Signed-off-by: Fabian Emmes <fabian.emmes@rwth-aachen.de>
>> Signed-off-by: Lars Noschinski <lars@public.noschinski.de>
>
>I do not see the development history behind this and am somewhat puzzled
>by these two S-o-b lines.  Is it "Fabian developed it, showed it to Lars
>who cleaned it up and/or enhanced it and here is the result"?  Or is it
>"Lars developed it, circulated it in his closer circle, Fabian found it
>useful and worthy for inclusion and sending it to the mailing list"?

It is "Fabian and Lars developed it and Fabian is the one who mailed it
for inclusion". We could just leave off the second S-o-b line, if this
is less irritating?

>Whichever it is, I just will take it as "This is co-developed and between
>the authors Fabian is the primary author" and apply.

Fine with me.

  - Lars.
