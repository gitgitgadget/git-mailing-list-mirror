From: Oswald Buddenhagen <ossi@kde.org>
Subject: Re: cvs import
Date: Sat, 16 Sep 2006 08:04:55 +0200
Message-ID: <20060916060454.GA3769@ugly.local>
References: <45084400.1090906@bluegap.ch> <9e4733910609131201q7f583029r72dac66cd0dd098f@mail.gmail.com> <46a038f90609131341se42b2dcne73c017cf757d13a@mail.gmail.com> <450872AE.5050409@bluegap.ch> <9e4733910609131438n686b6d72u4d5799533c7473d7@mail.gmail.com> <4508EA78.5030001@alum.mit.edu> <20060914155003.GB9657@spearce.org> <450A581E.2050509@bluegap.ch> <20060916033917.GA24269@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Schiltknecht <markus@bluegap.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jon Smirl <jonsmirl@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>, monotone-devel@nongnu.org,
	dev@cvs2svn.tigris.org
X-From: dev-return-1662-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Sat Sep 16 08:05:25 2006
Return-path: <dev-return-1662-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc51.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by ciao.gmane.org with smtp (Exim 4.43)
	id 1GOTIr-0004T7-7B
	for gcvscd-dev@gmane.org; Sat, 16 Sep 2006 08:05:25 +0200
Received: (qmail 32059 invoked by uid 5000); 16 Sep 2006 06:05:23 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Delivered-To: mailing list dev@cvs2svn.tigris.org
Received: (qmail 32049 invoked from network); 16 Sep 2006 06:05:22 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAKkwC0WLbQEBBw4HBh0
X-IronPort-AV: i="4.09,173,1157353200"; 
   d="scan'208"; a="26991191:sNHT21925631"
X-IRONPORT: SCANNED
To: Shawn Pearce <spearce@spearce.org>
Mail-Followup-To: Shawn Pearce <spearce@spearce.org>,
	Markus Schiltknecht <markus@bluegap.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jon Smirl <jonsmirl@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>, monotone-devel@nongnu.org,
	dev@cvs2svn.tigris.org
Content-Disposition: inline
In-Reply-To: <20060916033917.GA24269@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-16)
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27110>

On Fri, Sep 15, 2006 at 11:39:18PM -0400, Shawn Pearce wrote:
> On the other hand from what I understand of Monotone it needs
> the revisions in oldest->newest order, as does SVN.
> 
> Doing both orderings in cvs2noncvs is probably ugly.
>
don't worry, as i know mike, he'll come up with an abstract, outright
beautiful interface that makes you want to implement middle->oldnewest
just for the sake of doing it. :)

-- 
Hi! I'm a .signature virus! Copy me into your ~/.signature, please!
--
Chaos, panic, and disorder - my work here is done.
