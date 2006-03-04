From: Paul Jakma <paul@clubi.ie>
Subject: Re: On recording renames
Date: Sat, 4 Mar 2006 04:09:44 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0603040405260.13612@sheen.jakma.org>
References: <7vfylyx3e3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 04 05:10:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFO5t-0000kU-Tc
	for gcvg-git@gmane.org; Sat, 04 Mar 2006 05:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWCDEKK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Mar 2006 23:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbWCDEKJ
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 23:10:09 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:54159 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S1750747AbWCDEKI
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Mar 2006 23:10:08 -0500
Received: from sheen.jakma.org (IDENT:U2FsdGVkX1+lWgjcEpcdd+4V/inqOxibcZtDTFxverU@sheen.jakma.org [212.17.55.53])
	by hibernia.jakma.org (8.13.1/8.13.1) with ESMTP id k2449j5l027869;
	Sat, 4 Mar 2006 04:09:57 GMT
X-X-Sender: paul@sheen.jakma.org
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfylyx3e3.fsf@assigned-by-dhcp.cox.net>
Mail-Copies-To: paul@hibernia.jakma.org
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: al aqsar fluffy jihad cute musharef kittens jet-A1 ear avgas wax ammonium bad qran dog inshallah allah al-akbar martyr iraq hammas hisballah rabin ayatollah korea revolt pelvix mustard gas x-ray british airways washington peroxide cool
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on hibernia.jakma.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17169>

Hi Junio,

On Fri, 3 Mar 2006, Junio C Hamano wrote:

> Recently some people said "I want to tell git that I renamed fileA 
> to fileB" on the list and #git channel,

> *1* This is by design, and I am not going to debate if that is a
> good design or not here.

Thanks for your detailed email. Before I continue digesting it, I'd 
like to revise my original proposal (having now read the 
more of the 'design philosophy'):

- I want to tell git that object A is related to object B between two
   trees.

I think at this stage a proof-of-concept would be an idea. I'll try 
get back with that before end of the month.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
we just switched to Sprint.
