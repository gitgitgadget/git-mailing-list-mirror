From: Petr Baudis <pasky@suse.cz>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 01:28:18 +0200
Message-ID: <20061017232818.GF20017@pasky.or.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca>
	<Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
	<45345AEF.6070107@utoronto.ca> <45348B5E.8000404@op5.se>
	<4534E335.8070203@utoronto.ca> <4534F133.1090003@op5.se>
	<453532A5.6060701@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Andreas Ericsson <ae@op5.se>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: bazaar-ng-bounces@lists.canonical.com Wed Oct 18 01:28:32 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZyMF-0006QB-BI
	for gcvbg-bazaar-ng@m.gmane.org; Wed, 18 Oct 2006 01:28:27 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GZyM9-0004BP-TO; Wed, 18 Oct 2006 00:28:21 +0100
Received: from w241.dkm.cz ([62.24.88.241] helo=machine.or.cz)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <pasky@machine.or.cz>) id 1GZyM7-0004BK-L2
	for bazaar-ng@lists.canonical.com; Wed, 18 Oct 2006 00:28:19 +0100
Received: (qmail 6790 invoked by uid 2001); 18 Oct 2006 01:28:18 +0200
To: Aaron Bentley <aaron.bentley@utoronto.ca>
Content-Disposition: inline
In-Reply-To: <453532A5.6060701@utoronto.ca>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29137>

Dear diary, on Tue, Oct 17, 2006 at 09:44:37PM CEST, I got a letter
where Aaron Bentley <aaron.bentley@utoronto.ca> said that...
> Andreas Ericsson wrote:
> >> In our terminology, if it can diverge from the original, it's a branch,
> >> not a checkout.
> >>
> > 
> > This clears things up immensely. bazaar checkout != git checkout.
> > I still fail to see how a local copy you can't commit to is useful
> 
> My bzr is run from a local copy I can't commit to.  To get the latest
> changes from http://bazaar-vcs.org, I can run "bzr update ~/bzr/dev".
> To merge the latest changes into my branch, I can run
> "bzr merge ~/bzr/dev".  It's also convenient for applying other peoples'
> patches to.

The question is, why is it useful to enforce the "no commit" rule? Git
can work exactly the same, it just doesn't _enforce_ the rule. And is
the capability of enforcing such a rule important enough to warrant its
own column in the comparison table?
