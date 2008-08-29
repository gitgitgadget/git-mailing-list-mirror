From: Perry Wagle <wagle@cs.indiana.edu>
Subject: Re: Future suggestion's to assist with changes to git.
Date: Thu, 28 Aug 2008 17:31:07 -0700
Message-ID: <F50DF26D-3CD3-4A20-BAFB-758D0441CD00@cs.indiana.edu>
References: <alpine.LNX.1.10.0808281646570.18129@suse104.zenez.com> <20080828233045.GE29609@coredump.intra.peff.net> <7vej48d73e.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.10.0808281801510.18129@suse104.zenez.com>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 29 02:32:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYruV-0002Nf-MF
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 02:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753406AbYH2AbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 20:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753418AbYH2AbN
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 20:31:13 -0400
Received: from newman.cs.indiana.edu ([129.79.247.4]:33680 "EHLO
	newman.cs.indiana.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbYH2AbM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 20:31:12 -0400
Received: from smtp.cs.indiana.edu (smtp.cs.indiana.edu [129.79.247.7])
	by newman.cs.indiana.edu (8.13.1/8.13.1/IUCS_2.87) with ESMTP id m7T0VBcG017428
	for <git@vger.kernel.org>; Thu, 28 Aug 2008 20:31:12 -0400
Received: from dhcp-2.metabiology.com (pool-96-253-170-5.ptldor.fios.verizon.net [96.253.170.5])
	(authenticated bits=0)
	by rage.cs.indiana.edu (8.13.1/8.13.1/IUCS_SMTP_Alternate_Port_1.4) with ESMTP id m7T0V7se011676
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Thu, 28 Aug 2008 20:31:11 -0400
In-Reply-To: <alpine.LNX.1.10.0808281801510.18129@suse104.zenez.com>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94235>

Here's my relevant paragraph from the other thread:

I think the lesson here, however, it that the correct way to have done  
this is to first remove all the git<DASH>'s from the source, demos,  
sample, documentation, etc.  Second, BIG PAUSE (full minor version  
release cycle?) Then, third, get rid of git<DASH> in <prefix>/bin.

-- Perry
