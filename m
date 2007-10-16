From: "Dave Korn" <dave.korn@artimi.com>
Subject: RE: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 17:23:11 +0100
Message-ID: <03f401c81010$d8833de0$2e08a8c0@CAM.ARTIMI.COM>
References: <47125F74.9050600@op5.se><Pine.LNX.4.64.0710141934310.25221@racer.site><47126957.1020204@op5.se><Pine.LNX.4.64.0710142112540.25221@racer.site><20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org><Pine.LNX.4.64.0710151859590.7638@iabervon.org><uodezisvg.fsf@gnu.org> <471448D0.6080200@op5.se><E1Ihfrl-0007w1-3I@fencepost.gnu.org> <20071016155608.GA10603@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: <raa.lkml@gmail.com>, <barkalow@iabervon.org>, <make-w32@gnu.org>,
	<Johannes.Schindelin@gmx.de>, "'Andreas Ericsson'" <ae@op5.se>,
	<git@vger.kernel.org>
To: "'David Brown'" <git@davidb.org>, "'Eli Zaretskii'" <eliz@gnu.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 18:24:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhpDD-0007hl-Mg
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 18:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764700AbXJPQXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 12:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764307AbXJPQXP
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 12:23:15 -0400
Received: from mail.artimi.com ([194.72.81.2]:23345 "EHLO mail.artimi.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764312AbXJPQXN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 12:23:13 -0400
Received: from rainbow ([192.168.8.46]) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 16 Oct 2007 17:23:11 +0100
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20071016155608.GA10603@old.davidb.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3138
Thread-Index: AcgQD4artLH4j0p9QxueRGyPsfZN1wAAR3SQ
X-OriginalArrivalTime: 16 Oct 2007 16:23:11.0795 (UTC) FILETIME=[D8819030:01C81010]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61204>

On 16 October 2007 16:56, David Brown wrote:

> On Tue, Oct 16, 2007 at 02:25:21AM -0400, Eli Zaretskii wrote:
> 
>> On the other hand, what packages have 100K files?  If there's only one
>> -- the Linux kernel -- then I think this kind of performance is for
>> all practical purposes unimportant on Windows, because while it is
>> reasonable to assume that someone would like to use git on Windows,
>> assuming that someone will develop the Linux kernel on Windows is --
>> how should I put it -- _really_ far-fetched ;-)
> 
> Oh, I wish others could think this clearly.  Quoting a serious line off of
> a task list at an unnamed company:
> 
>    - Make Linux kernel compile under windows.
> 
> I don't think it will move past just being a wish list item, but there seem
> to be people that think it should be done.
> 
> Admittedly, they don't want developers doing it on windows, but want to
> integrate kernel building into a windows-heavy build and release process.

  Do that kind of thing here all the time, hence my previous post.  Apart from
the netfilter stuff with the filenames-that-match-in-all-but-case, no real
problems, took me a couple of hours one afternoon.

  Cygwin is a good match for linux dev work.

    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
