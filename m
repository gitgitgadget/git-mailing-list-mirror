From: Paul Gardiner <paul@laser-point.co.uk>
Subject: What am I doing wrong?
Date: Fri, 16 May 2008 12:25:53 +0100
Message-ID: <482D6F41.2060809@laser-point.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: lists@glidos.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 13:34:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwyCJ-0000jX-IK
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 13:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831AbYEPLdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 07:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754787AbYEPLdM
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 07:33:12 -0400
Received: from mk-outboundfilter-5.mail.uk.tiscali.com ([212.74.114.1]:11240
	"EHLO mk-outboundfilter-5.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752167AbYEPLdL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 May 2008 07:33:11 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 May 2008 07:32:53 EDT
X-Trace: 28336348/mk-outboundfilter-5.mail.uk.tiscali.com/PIPEX/$ACCEPTED/pipex-customers/81.86.57.226
X-SBRS: None
X-RemoteIP: 81.86.57.226
X-IP-MAIL-FROM: paul@laser-point.co.uk
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AsgAAFQKLUhRVjni/2dsb2JhbAAIrjo
X-IronPort-AV: E=Sophos;i="4.27,497,1204502400"; 
   d="scan'208";a="28336348"
X-IP-Direction: IN
Received: from 81-86-57-226.dsl.pipex.com (HELO [10.0.0.24]) ([81.86.57.226])
  by smtp.pipex.tiscali.co.uk with ESMTP; 16 May 2008 12:25:55 +0100
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82275>

I create the initial repository with

     git-clone /<full-path>/<name>.git/ <folder>

That works fine, but then I can't fetch. git-fetch gives the error
"fatal: 'origin': unable to chdir or not a git archive"
"fatal: The remote end hung up unexpectedly"

P.
