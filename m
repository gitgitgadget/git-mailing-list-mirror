From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [OT] Re: Git and GCC
Date: Thu, 6 Dec 2007 14:38:27 -0800
Message-ID: <20071206143827.004991f8.rdunlap@xenotime.net>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com> 	<20071205.202047.58135920.davem@davemloft.net> 	<4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com> 	<20071205.204848.227521641.davem@davemloft.net> 	<4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com> 	<alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org> 	<1196968371.18340.30.camel@ld0161-tx32> 	<7vk5nrd1yq.fsf@gitster.siamese.dyndns.org> 	<7vabonczad.fsf@gitster.siamese.dyndns.org> 	<85r6hzo3y8.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jon Loeliger <jdl@freescale.com>,  Linus Torvalds <torvalds@linux-foundation.org>, Daniel Berlin  <dberlin@dberlin.org>, David Miller <davem@davemloft.net>,  ismail@pardus.org.tr, gcc@gcc.gnu.org, Git List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: gcc-return-142778-gcc=m.gmane.org@gcc.gnu.org Thu Dec 06 23:39:12 2007
Return-path: <gcc-return-142778-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J0PN6-000182-Q5
	for gcc@gmane.org; Thu, 06 Dec 2007 23:39:09 +0100
Received: (qmail 2341 invoked by alias); 6 Dec 2007 22:38:49 -0000
Received: (qmail 2332 invoked by uid 22791); 6 Dec 2007 22:38:49 -0000
X-Spam-Check-By: sourceware.org
Received: from xenotime.net (HELO xenotime.net) (66.160.160.81)     by sourceware.org (qpsmtpd/0.31) with SMTP; Thu, 06 Dec 2007 22:38:32 +0000
Received: from midway.site ([71.117.233.180]) by xenotime.net for <gcc@gcc.gnu.org>; Thu, 6 Dec 2007 14:38:27 -0800
In-Reply-To: <85r6hzo3y8.fsf@lola.goethe.zz>
X-Mailer: Sylpheed 2.4.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
X-IsSubscribed: yes
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67350>

On Thu, 06 Dec 2007 23:26:07 +0100 David Kastrup wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >> Jon Loeliger <jdl@freescale.com> writes:
> >>
> >>> I'd like to learn more about that.  Can someone point me to
> >>> either more documentation on it?  In the absence of that,
> >>> perhaps a pointer to the source code that implements it?
> >>
> >> See Documentation/technical/pack-heuristics.txt,
> >
> > A somewhat funny thing about this is ...
> >
> > $ git show --stat --summary b116b297
> > commit b116b297a80b54632256eb89dd22ea2b140de622
> > Author: Jon Loeliger <jdl@jdl.com>
> > Date:   Thu Mar 2 19:19:29 2006 -0600
> >
> >     Added Packing Heursitics IRC writeup.
> 
> Ah, fishing for compliments.  The cookie baking season...

Indeed.  Here are some really good & sweet recipes (IMHO).

http://www.xenotime.net/linux/recipes/


---
~Randy
Features and documentation: http://lwn.net/Articles/260136/
