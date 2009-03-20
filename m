From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: Minimum libCurl version for git
Date: Fri, 20 Mar 2009 23:31:30 +0100 (CET)
Message-ID: <alpine.DEB.1.10.0903202316170.2600@yvahk2.pbagnpgbe.fr>
References: <e2b179460903201059j20e37c1cr7ccfa4b42e45c9d9@mail.gmail.com> <7vy6uzg98v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	git list <git@vger.kernel.org>,
	Nick Hengeveld <nickh@reactrix.com>,
	Mike Hommey <mh@glandium.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 23:33:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LknHg-0007iy-T4
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 23:33:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757017AbZCTWcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 18:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756513AbZCTWcS
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 18:32:18 -0400
Received: from kluster1.contactor.se ([91.191.140.11]:40806 "EHLO
	kluster1.contactor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757296AbZCTWcR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 18:32:17 -0400
Received: from linux2.contactor.se (linux2.contactor.se [91.191.140.14])
	by kluster1.contactor.se (8.13.8/8.13.8/Debian-3) with ESMTP id n2KMVUJn019482;
	Fri, 20 Mar 2009 23:31:30 +0100
X-X-Sender: dast@linux2.contactor.se
In-Reply-To: <7vy6uzg98v.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114013>

On Fri, 20 Mar 2009, Junio C Hamano wrote:

> For non-commercial Linux folks I think it should be Ok to assume not too 
> ancient libcurl, but I have no clue on how the table like the above would 
> look like for things like AIX, IRIX, HPUX etc.  ... Oh, and SCO.

The oldest libcurl version I know is still being distributed to and therefor 
used by people is one IBM provides for AIX, and that is 7.9.3 - dated "Jan 23 
2002".

-- 

  / daniel.haxx.se
