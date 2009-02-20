From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: [PATCH] check_updates(): effective removal of cache entries marked
 CE_REMOVE
Date: Fri, 20 Feb 2009 11:15:27 +0100
Organization: private
Message-ID: <86iqn5ifcw.fsf@broadpark.no>
References: <1234995483-933-1-git-send-email-barvik@broadpark.no>
 <7vskm9ftcq.fsf@gitster.siamese.dyndns.org> <86vdr5iis0.fsf@broadpark.no>
 <alpine.DEB.1.00.0902201014180.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 20 11:18:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaSSR-0003zr-RZ
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 11:18:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754051AbZBTKPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 05:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752985AbZBTKPc
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 05:15:32 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:38497 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbZBTKPa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 05:15:30 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KFD001CK0HSD680@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Fri, 20 Feb 2009 11:15:28 +0100 (CET)
Received: from localhost ([84.48.79.78]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KFD009L50HRTM00@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Fri, 20 Feb 2009 11:15:28 +0100 (CET)
In-reply-to: <alpine.DEB.1.00.0902201014180.10279@pacific.mpi-cbg.de>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110833>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Fri, 20 Feb 2009, Kjetil Barvik wrote:
>
>>   I guess that 77 milliseconds compared to 15 seconds is not noticable
>
> I guess you meant 15 milliseconds?  ;-)

  Ok, I guess I was thinkning abouth the 77 milliseconds reduction of
  the total time this git chekcout' test take, and the total time is 15
  seconds.

  -- kjetil, :-)


 
