From: Bill Lear <rael@zopyra.com>
Subject: Re: Why is git clone not checking out files?
Date: Tue, 30 Jan 2007 12:18:45 -0600
Message-ID: <17855.35845.922009.364704@lisa.zopyra.com>
References: <17855.35058.967318.546726@lisa.zopyra.com>
	<epo1tn$9sl$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 19:19:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBxZL-0006UJ-4V
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 19:18:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965571AbXA3SS4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 13:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965579AbXA3SS4
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 13:18:56 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60187 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965571AbXA3SSz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 13:18:55 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0UIIn428402;
	Tue, 30 Jan 2007 12:18:49 -0600
In-Reply-To: <epo1tn$9sl$1@sea.gmane.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38181>

On Tuesday, January 30, 2007 at 19:15:33 (+0100) Jakub Narebski writes:
>Bill Lear wrote:
>
>> I don't understand why clone (version 1.4.4.1) is not checking out my
>> files:
>
>Unless you use git clone --bare, it should checkout HEAD branch...

Ok, well, I certainly did not issue git clone --bare, it was just a
plain ol' clone:

% git clone /repos/git/project

and no checkout ensued.  Can I fix this somehow?  I've tried the clone
several times with no success.  Is there anything I can check in the
source repo (the above /repos/git/project) to see why it would not be
working?


Bill
