From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git-commit: allow From: line to be entered in commit message
Date: Thu, 12 Jan 2006 21:16:46 +0100
Message-ID: <20060112201646.GA3179@steel.home>
References: <20060112093700.1d3d25db.seanlkml@sympatico.ca>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 12 21:17:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ex8sV-00020H-RY
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 21:17:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161238AbWALUQ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 15:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161237AbWALUQ5
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 15:16:57 -0500
Received: from devrace.com ([198.63.210.113]:64268 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1161238AbWALUQ4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2006 15:16:56 -0500
Received: from tigra.home (p54A07A2B.dip.t-dialin.net [84.160.122.43])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k0CKGmhH058458;
	Thu, 12 Jan 2006 14:16:49 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1Ex8sI-0000Tn-00; Thu, 12 Jan 2006 21:16:46 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1Ex8sI-0001Y1-4i; Thu, 12 Jan 2006 21:16:46 +0100
To: sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <20060112093700.1d3d25db.seanlkml@sympatico.ca>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14584>

sean, Thu, Jan 12, 2006 15:37:00 +0100:
> 
> Mostly just for comment to see if there is any support
> for this feature....
> 
> Sean
> 
> ---
> Use the author name and email information given as the 
> first line of the commit message in the form of:
> 
> From: name <email>
> 

Isn't this what git-am expect (as a part of mbox) and handle?
