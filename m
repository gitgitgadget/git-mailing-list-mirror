From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git and GCC
Date: Thu, 6 Dec 2007 11:57:06 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712061150590.27959@racer.site>
References: <4aca3dc20712051108s216d3331t8061ef45b9aa324a@mail.gmail.com>  <20071205.182815.249974508.davem@davemloft.net>  <4aca3dc20712051841o71ab773ft6dd0714ebc355dd5@mail.gmail.com>  <20071205.185203.262588544.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: dberlin@dberlin.org, ismail@pardus.org.tr, gcc@gcc.gnu.org,      git@vger.kernel.org
To: David Miller <davem@davemloft.net>
X-From: gcc-return-142736-gcc=m.gmane.org@gcc.gnu.org Thu Dec 06 12:58:18 2007
Return-path: <gcc-return-142736-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J0FMt-0003C3-Lp
	for gcc@gmane.org; Thu, 06 Dec 2007 12:58:16 +0100
Received: (qmail 7349 invoked by alias); 6 Dec 2007 11:57:57 -0000
Received: (qmail 7337 invoked by uid 22791); 6 Dec 2007 11:57:56 -0000
X-Spam-Check-By: sourceware.org
Received: from mail.gmx.net (HELO mail.gmx.net) (213.165.64.20)     by sourceware.org (qpsmtpd/0.31) with SMTP; Thu, 06 Dec 2007 11:57:49 +0000
Received: (qmail invoked by alias); 06 Dec 2007 11:57:46 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]   by mail.gmx.net (mp007) with SMTP; 06 Dec 2007 12:57:46 +0100
X-Authenticated: #1490710
In-Reply-To: <20071205.185203.262588544.davem@davemloft.net>
X-Y-GMX-Trusted: 0
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67273>

Hi,

On Wed, 5 Dec 2007, David Miller wrote:

> From: "Daniel Berlin" <dberlin@dberlin.org>
> Date: Wed, 5 Dec 2007 21:41:19 -0500
> 
> > It is true I gave up quickly, but this is mainly because i don't like 
> > to fight with my tools.
> >
> > I am quite fine with a distributed workflow, I now use 8 or so gcc 
> > branches in mercurial (auto synced from svn) and merge a lot between 
> > them. I wanted to see if git would sanely let me manage the commits 
> > back to svn.  After fighting with it, i gave up and just wrote a 
> > python extension to hg that lets me commit non-svn changesets back to 
> > svn directly from hg.
> 
> I find it ironic that you were even willing to write tools to facilitate 
> your hg based gcc workflow.  That really shows what your thinking is on 
> this matter, in that you're willing to put effort towards making hg work 
> better for you but you're not willing to expend that level of effort to 
> see if git can do so as well.

While this is true...

> This is what really eats me from the inside about your dissatisfaction 
> with git.  Your analysis seems to be a self-fullfilling prophecy, and 
> that's totally unfair to both hg and git.

... I actually appreciate people complaining -- in the meantime.  It shows 
right away what group you belong to in the "Those who can do, do, those 
who can't, complain.".

You can see that very easily on the git list, or on the #git channel on 
irc.freenode.net.  There is enough data for a study which yearns to be 
written, that shows how quickly we resolve issues with people that are 
sincerely interested in a solution.

(Of course, on the other hand, there are also quite a few cases which show 
how frustrating (for both sides) and unfruitful discussions started by a 
complaint are.)

So I fully expect an issue like Daniel's to be resolved in a matter of 
minutes on the git list, if the OP gives us a chance.  If we are not even 
Cc'ed, you are completely right, she or he probably does not want the 
issue to be resolved.

Ciao,
Dscho
