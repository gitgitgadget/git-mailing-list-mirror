From: "Dr. Lars Hanke" <lars@lhanke.de>
Subject: Re: Diffing M$-Word
Date: Wed, 05 Aug 2009 21:35:49 +0200
Message-ID: <4A79DF15.9070000@lhanke.de>
References: <4A70AE1F.7070004@idmcomp.com> <36ca99e90907291345r188a2182n77a2fd5cb55a8bc4@mail.gmail.com> <4A71F2F1.4060605@idmcomp.com> <20090801111227.GA26029@gmail.com> <4A7841BF.5060308@idmcomp.com> <4A7869BD.5010209@lhanke.de> <4A788C93.10402@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 21:36:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYmHK-00058u-Dc
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 21:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbZHETfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 15:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbZHETfz
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 15:35:55 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:58483 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbZHETfy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 15:35:54 -0400
Received: from hermod.mgr (p5B36424F.dip.t-dialin.net [91.54.66.79])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0MKt72-1MYmHC1AmZ-000p4A; Wed, 05 Aug 2009 21:35:54 +0200
Received: from localhost (localhost.localdomain [127.0.0.1])
	by hermod.mgr (Postfix) with ESMTP id 87E2A1DC25D;
	Wed,  5 Aug 2009 21:35:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hermod.mgr
Received: from hermod.mgr ([127.0.0.1])
	by localhost (hermod.mgr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LEf8hepvIAlI; Wed,  5 Aug 2009 21:35:50 +0200 (CEST)
Received: from sleipnir.mgr (sleipnir.mgr [172.16.1.3])
	by hermod.mgr (Postfix) with ESMTP id 0CFBF1DC245;
	Wed,  5 Aug 2009 21:35:50 +0200 (CEST)
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20090706)
In-Reply-To: <4A788C93.10402@kdbg.org>
X-Provags-ID: V01U2FsdGVkX1/eFnpAM8viaVYS8/rRDHHisUu9JHkzSkXVSpz
 tuFbnhHtIyiXRylYdpQHsWwE2S+KlVPUF/eEe6HdbXl59kNTIm
 Gkv/BPYAAmTORRBHsz9cA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124955>


>> At work I have to write a lot of reports using M$-Word and found that 
>> git is capable of managing these in an easy and 
> I use a dual solution. I defined catdoc as a textconv filter so that I 
> can see textual changes in gitk; and I use my winworddiff crude hack 
> that I posted here
> http://thread.gmane.org/gmane.comp.version-control.git/59288
> as a external diff program (note: *not* a difftool). With these, I can 
> limp along sufficiently.
That sounds good. I'll try to setup this solution at work. I actually 
started writing a similar thing in C# .NET, since I didn't know that you 
could just add a .dot to supply a macro.

Thanks,
 - lars.
