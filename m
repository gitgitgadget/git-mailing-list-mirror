From: Anjib Mulepati <anjibcs@hotmail.com>
Subject: Definition of working directory
Date: Tue, 27 Mar 2012 12:12:45 -0400
Message-ID: <BLU0-SMTP1958653CC391F120060F8B6B14A0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 27 18:13:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCZ0w-0007DT-Ej
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 18:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754452Ab2C0QMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 12:12:49 -0400
Received: from blu0-omc3-s1.blu0.hotmail.com ([65.55.116.76]:35130 "EHLO
	blu0-omc3-s1.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753905Ab2C0QMs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Mar 2012 12:12:48 -0400
Received: from BLU0-SMTP195 ([65.55.116.72]) by blu0-omc3-s1.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 27 Mar 2012 09:12:47 -0700
X-Originating-IP: [146.243.44.97]
X-Originating-Email: [anjibcs@hotmail.com]
Received: from [146.243.44.97] ([146.243.44.97]) by BLU0-SMTP195.phx.gbl over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 27 Mar 2012 09:12:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:11.0) Gecko/20120312 Thunderbird/11.0
X-OriginalArrivalTime: 27 Mar 2012 16:12:46.0957 (UTC) FILETIME=[72ECD9D0:01CD0C34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194055>

I was reading Git Community Book and came across following definition 
for working directory

The Working Directory

The Git 'working directory' is the directory that holds the current 
checkout of the files you are working on. Files in this directory are 
often removed or replaced by Git as you switch branches - this is 
normal. All your history is stored in the Git Directory; the working 
directory is simply a temporary checkout place where you can modify the 
files until your next commit.

What does it mean by this " Files in this directory are often removed or 
replaced by Git as you switch branches"?

And does working directory is just a directory we get with $pwd ?

Thanks,
Anjib
