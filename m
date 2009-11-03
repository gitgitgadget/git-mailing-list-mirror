From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git pull --rebase and losing commits
Date: Mon, 02 Nov 2009 20:27:33 -0800
Message-ID: <86my3444i2.fsf@blue.stonehenge.com>
References: <alpine.DEB.2.00.0911021318400.3919@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Nov 03 05:27:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5Azd-0008Sh-5b
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 05:27:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755628AbZKCE13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 23:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755553AbZKCE13
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 23:27:29 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:8392 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755541AbZKCE12 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 23:27:28 -0500
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 84D311DE38A; Mon,  2 Nov 2009 20:27:33 -0800 (PST)
x-mayan-date: Long count = 12.19.16.14.15; tzolkin = 3 Men; haab = 13 Zac
In-Reply-To: <alpine.DEB.2.00.0911021318400.3919@ds9.cixit.se> (Peter Krefting's message of "Mon, 2 Nov 2009 13:26:37 +0100 (CET)")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131943>

>>>>> "Peter" == Peter Krefting <peter@softwolves.pp.se> writes:

Peter>  git pull --rebase --strategy=ours origin master

"No good can come of this."

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
