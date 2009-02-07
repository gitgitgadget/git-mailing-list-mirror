From: Tim Schofield <tim.schofield1960@googlemail.com>
Subject: Re: Eclipse Plugin install issue
Date: Sat, 7 Feb 2009 03:51:03 -0800 (PST)
Message-ID: <1234007463339-2288907.post@n2.nabble.com>
References: <b0a3bf780902060717l653cc6dcx385aa147f606a520@mail.gmail.com> <20090206153418.GM26880@spearce.org> <200902061710.34337.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 07 12:52:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVlje-0003Pp-4k
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 12:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbZBGLvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 06:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752436AbZBGLvG
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 06:51:06 -0500
Received: from kuber.nabble.com ([216.139.236.158]:43117 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbZBGLvF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 06:51:05 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1LVliB-0004mZ-B8
	for git@vger.kernel.org; Sat, 07 Feb 2009 03:51:03 -0800
In-Reply-To: <200902061710.34337.robin.rosenberg@dewire.com>
X-Nabble-From: tim.schofield1960@googlemail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108843>




Robin Rosenberg-2 wrote:
> 
> fredag 06 februari 2009 16:34:18 skrev Shawn O. Pearce:
>> Chris Velevitch <chris.velevitch@gmail.com> wrote:
>> > I've pointed the Eclipse update manager to
>> > http://www.jgit.org/update-site and when try to install it, it get:-
>> > 
>> > Cannot complete the request.  See the details.
>> > Cannot find a solution satisfying the following requirements
>> > Match[requiredCapability:
>> >
>> org.eclipse.equinox.p2.iu/org.spearce.egit.feature.group/[0.4.0.200901290136,0.4.0.200901290136]].
>> ...
>> > The instructions didn't say there were any prerequisites.
>> 
>> There aren't any prerequisites beyond the base Eclipse 3.4 and
>> any Java 5 or later runtime.  Its very odd that the update manager
>> can't install EGit.
>>  
>> Robin, is there a missing JAR file on the jgit.org update site?
> 
> I installed the latest version yesterday myself in both  the SDK edition
> and JEE editions of Ganymed 3.4.0. Just checked that it worked in 3.4.1
> too and from another location. That was a later version though
> 200902052244, but I try every version unless I get interrupted and forget
> about it.
> 
> -- robin
> 
> 
> 

I am getting this identical error. I am using 200902052244 and eclipse
Version: 3.4.1 Build id: M20080911-1700.

Anyone got any ideas?

Thanks
Tim


-- 
View this message in context: http://n2.nabble.com/Eclipse-Plugin-install-issue-tp2284628p2288907.html
Sent from the git mailing list archive at Nabble.com.
