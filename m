From: Joe Buck <Joe.Buck@synopsys.COM>
Subject: Re: Git and GCC
Date: Sat, 8 Dec 2007 11:53:53 -0800
Message-ID: <20071208195352.GB4731@synopsys.com>
References: <998d0e4a0712071821o520a75c4lbcaae92256071f48@mail.gmail.com> <Pine.LNX.4.64.0712081223070.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J.C. Pizarro" <jcpiza@gmail.com>,         Linus Torvalds <torvalds@linux-foundation.org>,         David Miller <davem@davemloft.net>, gcc@gcc.gnu.org,         git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: gcc-return-142849-gcc=m.gmane.org@gcc.gnu.org Sat Dec 08 20:54:29 2007
Return-path: <gcc-return-142849-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J15kq-0004tM-IZ
	for gcc@gmane.org; Sat, 08 Dec 2007 20:54:29 +0100
Received: (qmail 1343 invoked by alias); 8 Dec 2007 19:54:10 -0000
Received: (qmail 1333 invoked by uid 22791); 8 Dec 2007 19:54:09 -0000
X-Spam-Check-By: sourceware.org
Received: from us01smtp1.synopsys.com (HELO boden.synopsys.com) (198.182.44.79)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 08 Dec 2007 19:54:03 +0000
Received: from crone.synopsys.com (crone.synopsys.com [146.225.7.23]) 	by boden.synopsys.com (Postfix) with ESMTP id A8BF9E788; 	Sat,  8 Dec 2007 11:54:01 -0800 (PST)
Received: from piper.synopsys.com (localhost [127.0.0.1]) 	by crone.synopsys.com (8.9.1/8.9.1) with ESMTP id LAA03363; 	Sat, 8 Dec 2007 11:51:53 -0800 (PST)
Received: from piper.synopsys.com (localhost [127.0.0.1]) 	by piper.synopsys.com (8.12.11/8.12.3) with ESMTP id lB8JrvGK004815; 	Sat, 8 Dec 2007 11:53:57 -0800
Received: (from jbuck@localhost) 	by piper.synopsys.com (8.12.11/8.12.11/Submit) id lB8Jrr8v004813; 	Sat, 8 Dec 2007 11:53:53 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0712081223070.27959@racer.site>
User-Agent: Mutt/1.4.1i
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67566>

On Sat, 8 Dec 2007, J.C. Pizarro wrote:
> > 1.   "Don't compress this repo but compact this uncompressed repo
> >       using minimal spanning forest and deltas"
> > 2.   "After, compress this whole repo with LZMA (e.g. 48MiB) from 7zip before
> >       burning it to DVD for backup reasons or before replicating it to
> >	internet".

On Sat, Dec 08, 2007 at 12:24:00PM +0000, Johannes Schindelin wrote:
> Patches? ;-)

git list, meet J.C. Pizarro.  Care to take him off of our hands for
a while?  He's been hanging on the gcc list for some time, and perhaps
seeks new horizons.

Mr. Pizarro has endless ideas, and he'll give you some new ones every day.
He thinks that no one else knows any computer science, and he will attempt
to teach you what he knows, and tell you to rewrite all of your code based
on something he read and half-understood.  But he's not interested in
actually DOING the work, mind you; that's up to you.  When you object
that he's wasting your time, he'll start talking about freedom of speech.
