From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: how to git a read only directory
Date: Thu, 22 Jan 2009 14:35:13 +0200
Message-ID: <49786801.4010606@panasas.com>
References: <20090121083354.GG6970@b2j> <4977164B.4020706@panasas.com> <20090121155256.GB6966@b2j> <4977515B.9030807@panasas.com> <20090122100008.GC6936@b2j> <4978483D.6040105@panasas.com> <20090122102925.GD6936@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Boaz Harrosh <bharrosh@panasas.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 22 13:36:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPynl-0006ox-FZ
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 13:36:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754554AbZAVMfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 07:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754200AbZAVMfX
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 07:35:23 -0500
Received: from gw-ca.panasas.com ([66.104.249.162]:29057 "EHLO
	laguna.int.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753484AbZAVMfW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 07:35:22 -0500
Received: from daytona.int.panasas.com ([172.17.28.41]) by laguna.int.panasas.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 22 Jan 2009 04:35:17 -0800
Received: from bh-buildlin2.bhalevy.com ([172.17.28.136]) by daytona.int.panasas.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 22 Jan 2009 07:35:16 -0500
User-Agent: Thunderbird/3.0a2 (X11; 2008072418)
In-Reply-To: <20090122102925.GD6936@b2j>
X-OriginalArrivalTime: 22 Jan 2009 12:35:16.0448 (UTC) FILETIME=[E1093600:01C97C8D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106746>

bill lam wrote:
> On Thu, 22 Jan 2009, Boaz Harrosh wrote:
>> Sorry My mistake, it should be:
>> [gitrepo] $ git-add etc/fstab
>>
>> Sorry it's a typo, sure you must add files relative to
>> the base directory (one containing the .git/ dir)
> 
> Hi Boaz,
> 
> I still could not add the file. This time it said symbolic link error.
> 

OK so it looks like it is something new. Good to know I will not
upgrade for now as I do use it a lot. Unless there is some config
nub that can be turned. I must say that it is most useful, I use
it everyday.

Someone please comment why are symlink not allowed. Is that because
it might be dangerous? but so is a gun I might shoot myself in the
leg, but they are still been sold.

Boaz
