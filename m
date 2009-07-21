From: Roald de Vries <rdv@roalddevries.nl>
Subject: Re: clone
Date: Tue, 21 Jul 2009 11:56:02 +0200
Message-ID: <0884A878-A57C-4089-AE32-A3D1ACC32FED@roalddevries.nl>
References: <D229D90E-0294-475D-B7AC-6C7B23CC169A@roalddevries.nl> <4A6576B3.7000503@drmicha.warpmail.net>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jul 21 11:58:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTC7b-0005eK-JA
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 11:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754548AbZGUJ6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 05:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754543AbZGUJ6k
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 05:58:40 -0400
Received: from platinum.liacs.nl ([132.229.131.22]:50428 "EHLO
	platinum.liacs.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754533AbZGUJ6j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 05:58:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by platinum.liacs.nl (8.14.2/8.14.2/LIACS 1.5) with ESMTP id n6L9wXnY023749;
	Tue, 21 Jul 2009 11:58:35 +0200
X-Virus-Scanned: amavisd-new at liacs.nl
Received: from platinum.liacs.nl ([127.0.0.1])
	by localhost (platinum.liacs.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 1jg7bBINpPLW; Tue, 21 Jul 2009 11:58:10 +0200 (CEST)
Received: from prive147.liacs.nl (prive147.liacs.nl [132.229.16.147])
	by platinum.liacs.nl (8.14.2/8.14.2/LIACS 1.5) with ESMTP id n6L9u8Jl023374;
	Tue, 21 Jul 2009 11:56:10 +0200
In-Reply-To: <4A6576B3.7000503@drmicha.warpmail.net>
X-Mailer: Apple Mail (2.935.3)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0 (platinum.liacs.nl [132.229.131.22]); Tue, 21 Jul 2009 11:56:10 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123653>

Hi Michael,

I actually meant cloning all branches to both remote and non-remote  
(but remote-tracking) branches. But still, the --mirrorring is  
usefull, thx.

Kind regards, Roald


On Jul 21, 2009, at 10:05 AM, Michael J Gruber wrote:
> Roald de Vries venit, vidit, dixit 20.07.2009 16:33:
>> Dear all,
>>
>> If I clone a repository with multiple branches to 'newdir', and then
>> type 'git branch' in 'newdir', I see only 1 branch. 'git branch -r'
>> gives me all branches. Is that correct behaviour? If so, why? And
>> mainly: can I configure git to clone all original branches to non-
>> remote branches?
>>
>> Kind regards, Roald
>
> A for the 2nd part (1st one answered by Jeff), you can "git clone -- 
> mirror".
>
> But me suspects that you actually want (s)cp -rp, do you?
>
> Michael
>
