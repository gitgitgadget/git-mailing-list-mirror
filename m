From: Yakup Akbay <yakbay@ubicom.com>
Subject: Re: Pro Git Book -- Git
Date: Tue, 28 Jul 2009 14:32:25 +0300
Message-ID: <4A6EE1C9.8090701@ubicom.com>
Reply-To: d411cc4a0907271056x458d7b15lc1b2868a46884175@mail.gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Jul 28 13:32:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVkvO-00029m-Ho
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 13:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255AbZG1Lcp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Jul 2009 07:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751649AbZG1Lcp
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 07:32:45 -0400
Received: from gwlb1.appriver.com ([69.20.60.122]:13750 "EHLO
	server70.appriver.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751348AbZG1Lco (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 07:32:44 -0400
Received: by server70.appriver.com (CommuniGate Pro PIPE 5.2.14)
  with PIPE id 100096179; Tue, 28 Jul 2009 07:32:01 -0400
Received: from [216.112.109.98] (HELO stork.scenix.com)
  by server70.appriver.com (CommuniGate Pro SMTP 5.2.14)
  with ESMTP id 100096133 for git@vger.kernel.org; Tue, 28 Jul 2009 07:31:47 -0400
Received: from [172.18.200.178] ([172.18.200.178]) by stork.scenix.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Jul 2009 04:30:12 -0700
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
X-OriginalArrivalTime: 28 Jul 2009 11:30:13.0390 (UTC) FILETIME=[C5E112E0:01CA0F76]
X-Policy: GLOBAL - ubicom.com
X-Primary: yakbay@ubicom.com
X-Note: This Email was scanned by AppRiver SecureTide
X-Virus-Scan: V-
X-Note: TCH-CT/SI:0-76/SG:2 7/28/2009 7:31:12 AM
X-GBUdb-Analysis: 0, 216.112.109.98, Ugly c=0.631376 p=-0.834061 Source Normal
X-Signature-Violations: 0-0-0-4201-c
X-Note: Spam Tests Failed: 
X-Country-Path: PRIVATE->UNITED STATES->UNITED STATES
X-Note-Sending-IP: 216.112.109.98
X-Note-Reverse-DNS: 216.112.109.98.ptr.us.xo.net
X-Note-WHTLIST: yakbay@ubicom.com
X-Note: User Rule Hits: 
X-Note: Global Rule Hits: 114 115 116 117 121 122 217 
X-Note: Mail Class: VALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124238>

> Hey all,
>
> Just a heads up - I've been working on a book on Git being published
> by Apress called "Pro Git", which is being licensed under a CC 3.0
> license and as I've just finished some of the final reviews, I've put
> the entire content of the book online at:
>
> http://progit.org
>
> It should be shipping at the end of August, I think, but I just wante=
d
> to let people know that there is another resource out there to help
> learn Git.  This one was actually technically edited by Shawn, too, s=
o
> hopefully not too many serious errors of mine got through.
>
> I've added a link to it on http://git-scm.com under the Books section=
,
> in case you want to point any newbies there.  Hope this helps take
> some teaching load off some of your plates.
>
> Thanks,
> Scott

Great!

BTW, I've had the chance to read the last section (Git Internals) and t=
here's one sentence, which I'm not sure about the meaning.=20

The last paragraph in http://progit.org/book/ch9-3.html states:

> Remote references differ from branches (|refs/heads| references)=20
> mainly in that they can=92t be checked out. Git moves them around as=20
> bookmarks to the last known state of where those branches were on=20
> those servers.
Is this true? If I do `git checkout <remote>/<branch>` then I can check=
out the tree, which is referenced by the 'remote reference'.=20
Or am I misunderstanding the sentence? What is meant by 'remote referen=
ce' and by this sentence?


P.s. I just have subscribed to the maillist but not approved yet. So, i=
t might not go to the right place. Sorry, if this email does not appear=
 under the correct thread.=20

Regards,
Yakup
