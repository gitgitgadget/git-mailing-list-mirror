From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] codeBeamer MR - Easy ACL for Git
Date: Fri, 20 Nov 2009 08:47:02 +0100
Message-ID: <20091120074702.GW12890@machine.or.cz>
References: <4B03B153.1020302@intland.com>
 <20091118120936.GL17748@machine.or.cz>
 <4B054D0A.5030802@intland.com>
 <2e24e5b90911192056t706071ble163a53741017ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Intland Software <marketing@intland.com>, git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 08:47:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBOD3-0000C6-M3
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 08:47:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755722AbZKTHrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 02:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755502AbZKTHrA
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 02:47:00 -0500
Received: from w241.dkm.cz ([62.24.88.241]:38409 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755447AbZKTHq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 02:46:59 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id D26CB86201E; Fri, 20 Nov 2009 08:47:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <2e24e5b90911192056t706071ble163a53741017ef@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133310>

  Hi!

On Fri, Nov 20, 2009 at 10:26:32AM +0530, Sitaram Chamarty wrote:
> On Thu, Nov 19, 2009 at 7:20 PM, Intland Software <marketing@intland.com> wrote:
> > * MR against Gitolite
> > Pretty much the same applies here as well.
> 
> Conceptually, gitolite can do the roles stuff you mentioned,
> if I understood it correctly.  Of course, gitolite's access
> config is in plain text.
> 
> The web-based control, issue tracking, etc., are all on a
> different plane from what gitosis/gitolite aim to be.  So
> much so that I might even disagree with Pasky on the need to
> mention these two products in your website.

I brought Gitosis/Gitolite up because I got the impression that MR was
marketed primarily as a Git ACL tool, the other things being sort of
mirror; maybe my impession was wrong, but I still think the comparison
in ACL capabilities is useful.

> You should stick to gitorious, github, and -- here's a new
> one for you -- indefero.

Hmm, I didn't even know about this one, thanks for the pointer. Looks
like this suddenly is a very popular area. High competition is good!

(BTW, if you don't care about wikis and issue tracking, but you do care
about simplicity and light-weightness, you should best stick to Girocco!
;-)

-- 
				Petr "Pasky" Baudis
A lot of people have my books on their bookshelves.
That's the problem, they need to read them. -- Don Knuth
