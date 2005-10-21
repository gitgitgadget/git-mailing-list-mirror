From: Petr Baudis <pasky@suse.cz>
Subject: Re: LCA2006 Git/Cogito tutorial
Date: Fri, 21 Oct 2005 02:51:45 +0200
Message-ID: <20051021005145.GB30889@pasky.or.cz>
References: <4352F4C9.1040703@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 02:52:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESl8U-00026a-SE
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 02:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbVJUAvr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 20:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbVJUAvr
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 20:51:47 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48010 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964832AbVJUAvr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2005 20:51:47 -0400
Received: (qmail 29357 invoked by uid 2001); 21 Oct 2005 02:51:45 +0200
To: "Martin Langhoff \(CatalystIT\)" <martin@catalyst.net.nz>
Content-Disposition: inline
In-Reply-To: <4352F4C9.1040703@catalyst.net.nz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10400>

Dear diary, on Mon, Oct 17, 2005 at 02:48:09AM CEST, I got a letter
where "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz> told me that...
> Petr Baudis hinted earlier that he might be coming, as did Linus (but
> he was hoping for a sponsor, I'm not sure whether he'll be there or
> not). Speak up if you'll be there!

I'm sorry but I will not be there - it is too far away from my little
country. :-(

> I'll post my slides and presentation plan beforehand to the list, to
> avoid spreading misinfirmation/bad practices. They will probably be
> based on a recent talk I gave @ Wellington Perl Mongers about
> swtiching to Git/Cogito:
> 
>    http://wellington.pm.org/archive/200510/git/

(i) You might want to say "cg-export" instead of "git-tar-tree" (*shrug*)

(ii) You say:

	- Very fast stupid merge
	    ... and very smart, slow merges when stupid won't do

  What are you explicitly referring to? I don't think any kind of merge
in GIT (unless something totally missed me) can be called "very smart".
If it's a three-way merge, it's never "very smart".

(iii) I have only one major problem with your file:

	emacs .gitignore

  This should be obviously:

	vim .gitignore

;-)

> ps: lately, about 30% of my emails to git@vger from gmail have been 
> dropped on the floor. This is starting to get annoying, is anyone seeing 
> similar issues?

Not me. Perhaps I'm in some VIP class. :^)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
