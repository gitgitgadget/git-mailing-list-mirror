From: =?ISO-8859-1?Q?Ask_Bj=F8rn_Hansen?= <ask@develooper.com>
Subject: Re: How to compare different files in different branches
Date: Sat, 14 Jun 2008 18:49:43 -0700
Message-ID: <3E23E92E-37E7-4076-9277-0E1002EC196F@develooper.com>
References: <20080606122421.GA1521@denkbrett.schottelius.org> <20080606123539.GA3119@mithlond.arda.local> <20080608094754.GB1521@denkbrett.schottelius.org> <7v1w38l0el.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Nico -telmich- Schottelius <nico-git-20080606@schottelius.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 15 03:58:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7hVF-0001sH-8S
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 03:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755239AbYFOB42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 21:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755032AbYFOB42
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 21:56:28 -0400
Received: from x8.develooper.com ([216.52.237.208]:45991 "EHLO
	x8.develooper.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754781AbYFOB41 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 21:56:27 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Jun 2008 21:56:27 EDT
Received: (qmail 24616 invoked from network); 15 Jun 2008 01:49:44 -0000
Received: from gw.develooper.com (HELO embla.bn.dev) (ask@mail.dev@64.81.84.140)
  by smtp.develooper.com with (AES128-SHA encrypted) SMTP; 15 Jun 2008 01:49:44 -0000
In-Reply-To: <7v1w38l0el.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85058>


On Jun 8, 2008, at 2:51, Junio C Hamano wrote:

>> Perhaps we should reference git-rev-list(1) from git-diff(1), too?
>
> This is just the standard syntax to name blob _anywhere_, so we  
> should not
> hide it in git-rev-list(1) but somewhere people would read before  
> reading
> any "technical manual" material, perhaps in the tutorial and git(1).

+1!   A "how to specify files and revisions" tutorial with tips,  
tricks and examples would be great.

Since it's much more powerful in git than in other SCMs, this is one  
of the larger bits of things to learn.


  - ask

-- 
http://develooper.com/ - http://askask.com/
