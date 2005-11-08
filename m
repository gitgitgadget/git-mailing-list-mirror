From: Ben Clifford <benc@hawaga.org.uk>
Subject: Re: latest stg/git commandline completions code
Date: Tue, 8 Nov 2005 21:16:28 +1100
Message-ID: <A44A02AA-BDA8-4623-825E-288F1107A5ED@hawaga.org.uk>
References: <Pine.LNX.4.60.0510251222510.8565@mundungus.clifford.ac> <200510251642.46169.blaisorblade@yahoo.it>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Nov 08 11:19:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZQYe-0000ym-QA
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 11:18:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbVKHKSG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 05:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbVKHKSG
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 05:18:06 -0500
Received: from mundungus.clifford.ac ([81.187.211.39]:45829 "EHLO
	mundungus.clifford.ac") by vger.kernel.org with ESMTP
	id S932393AbVKHKSF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 05:18:05 -0500
Received: from [IPv6:::1] (localhost [127.0.0.1])
	by mundungus.clifford.ac (8.13.3/8.13.3) with ESMTP id jA8AGRiZ031491;
	Tue, 8 Nov 2005 10:16:30 GMT
In-Reply-To: <200510251642.46169.blaisorblade@yahoo.it>
To: Blaisorblade <blaisorblade@yahoo.it>, git@vger.kernel.org
X-Mailer: Apple Mail (2.734)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11323>



> I'm using stgit on the Linux kernel so when on a command I don't  
> have tab
> completion I add the needed one (having the time and feeling to do  
> it).
>
> However, it's still done with enough care and polish to be shippable.
>
>

I've added some stuff to this to do a few cogito, gitk and (one) git  
completions, split into different files. I thought I might as well  
toss what I have out for anyone interested to play with.

I tried to put it in a new git repo online, but I'm having  
difficulties - the poor link I'm on makes it not so much fun to  
experiment. So I've tarred up my local repo warts and all and put it at:

http://www.hawaga.org.uk/ben/tech/gitcompletion- 
a108bdc110dad770ec5c092759a8bc511790d21f.tar

Ben
-- 
Ben Clifford
http://www.hawaga.org.uk/ben/
