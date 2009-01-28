From: Zabre <427@free.fr>
Subject: Re: (beginner) git rm
Date: Wed, 28 Jan 2009 10:25:17 -0800 (PST)
Message-ID: <1233167117028-2233899.post@n2.nabble.com>
References: <1233137498146-2231416.post@n2.nabble.com> <Pine.LNX.4.64.0901281133380.645@ds9.cixit.se> <1233140751523-2231622.post@n2.nabble.com> <49804385.908@dbservice.com> <1233144045221-2231849.post@n2.nabble.com> <49804D41.3010801@dbservice.com> <20090128130333.GA11160@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 19:26:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSF7d-0008CQ-05
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 19:26:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbZA1SZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 13:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbZA1SZS
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 13:25:18 -0500
Received: from kuber.nabble.com ([216.139.236.158]:58001 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbZA1SZR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 13:25:17 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1LSF6D-00039a-16
	for git@vger.kernel.org; Wed, 28 Jan 2009 10:25:17 -0800
In-Reply-To: <20090128130333.GA11160@mit.edu>
X-Nabble-From: 427@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107560>



Theodore Tso wrote:
> 
> I use this command enough that I have this defined as an alias in my
> ~/.gitconfig file.  Try running this command:
> 
> 	git config --global alias.revert-file "checkout HEAD --"
> 
> Now you will be able to do this:
> 
> 	git revert-file d.txt
> 
> This is also useful when I've edited d.txt, and decided that I didn't
> go about it the right away, and so I want to revert my edits.
> 

Very good, I'll try that. (Plus it shows me how to customize git, thanks!)
(Sorry for my late answer I've been unable to check my computer for a few
hours)
-- 
View this message in context: http://n2.nabble.com/%28beginner%29-git-rm-tp2231416p2233899.html
Sent from the git mailing list archive at Nabble.com.
