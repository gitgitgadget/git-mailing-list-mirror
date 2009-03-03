From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] git-clone: Add option --branch to override initial
 branch
Date: Tue, 3 Mar 2009 10:07:31 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903031004570.6399@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0903030047130.10279@pacific.mpi-cbg.de> <1236040414-19089-1-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-269147574-1236071252=:6399"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 10:09:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeQca-00021e-W1
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 10:09:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbZCCJHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 04:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752509AbZCCJHg
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 04:07:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:34299 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752137AbZCCJHf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 04:07:35 -0500
Received: (qmail invoked by alias); 03 Mar 2009 09:07:32 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp011) with SMTP; 03 Mar 2009 10:07:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18BUfV7Q+IBkSywCFZ+rasi/0mZUS6NdVQN/32cgE
	kmE8Xq1DkeZruV
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1236040414-19089-1-git-send-email-torarnv@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112037>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-269147574-1236071252=:6399
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 3 Mar 2009, Tor Arne Vestbø wrote:

> Something like this?

Leaving unnecessary initialization and funny indentation aside for a 
moment, what about the objection that it might not be necessary?

Keep in mind: your change (as every change) bears the potential to 
introduce bugs and to complicate the user interface.  The change must be 
worth those risks.

So could you make a case (if you resubmit a patch, in the commit message, 
please) why your change is desirable?

Thanks,
Dscho
--8323329-269147574-1236071252=:6399--
