From: Bill Lear <rael@zopyra.com>
Subject: Re: [Announce] GIT v1.5.0-rc2
Date: Tue, 23 Jan 2007 12:12:34 -0600
Message-ID: <17846.20498.635623.173653@lisa.zopyra.com>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net>
	<eovccc$usc$1@sea.gmane.org>
	<Pine.LNX.4.63.0701211207500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 19:12:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9Q8W-00030D-4h
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 19:12:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933093AbXAWSMm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 13:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933099AbXAWSMm
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 13:12:42 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61624 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933093AbXAWSMl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 13:12:41 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0NICcC22920;
	Tue, 23 Jan 2007 12:12:38 -0600
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701211207500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37555>

On Sunday, January 21, 2007 at 12:08:25 (+0100) Johannes Schindelin writes:
>Hi,
>
>On Sun, 21 Jan 2007, Jakub Narebski wrote:
>
>> By the way, was the pager configured to saner values, so "git diff" on a 
>> repository with no changes does not output empty page?
>
>As Junio mentioned: it already does. Maybe you have set the environment 
>variable "LESS", and forgot to include "-F"?

I can't seem to get this to work, no matter what I do, using the
latest 1.5.0-rc2 code.  I have the environment variables LESS, PAGER,
PAGER_FLAGS, and I can't seem to get 'git diff' to not plough through
my screen each time it is run, no matter the combinations...  Could
someone post the magic?


Bill
