From: "J.C. Pizarro" <jcpiza@gmail.com>
Subject: Re: [PATCH] gc --aggressive: make it really aggressive
Date: Thu, 6 Dec 2007 20:07:20 +0100
Message-ID: <998d0e4a0712061107r47f99599m262ffc7aefc4938a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Pierre Habouzit" <madcoder@debian.org>,  	"Linus Torvalds" <torvalds@linux-foundation.org>,  	"Daniel Berlin" <dberlin@dberlin.org>,  	"David Miller" <davem@davemloft.net>, ismail@pardus.org.tr,  	gcc@gcc.gnu.org, git@vger.kernel.org, gitster@pobox.com
To: "David Kastrup" <dak@gnu.org>,  	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: gcc-return-142760-gcc=m.gmane.org@gcc.gnu.org Thu Dec 06 20:07:48 2007
Return-path: <gcc-return-142760-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J0M4Z-0003go-94
	for gcc@gmane.org; Thu, 06 Dec 2007 20:07:47 +0100
Received: (qmail 19411 invoked by alias); 6 Dec 2007 19:07:28 -0000
Received: (qmail 19360 invoked by uid 22791); 6 Dec 2007 19:07:27 -0000
X-Spam-Check-By: sourceware.org
Received: from wr-out-0506.google.com (HELO wr-out-0506.google.com) (64.233.184.234)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Dec 2007 19:07:23 +0000
Received: by wr-out-0506.google.com with SMTP id 60so301336wri         for <gcc@gcc.gnu.org>; Thu, 06 Dec 2007 11:07:21 -0800 (PST)
Received: by 10.70.29.7 with SMTP id c7mr112872wxc.1196968040789;         Thu, 06 Dec 2007 11:07:20 -0800 (PST)
Received: by 10.70.54.17 with HTTP; Thu, 6 Dec 2007 11:07:20 -0800 (PST)
Content-Disposition: inline
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67321>

On 2007/12/06, David Kastrup <dak@gnu.org> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > However, I think that --aggressive should be aggressive, and if you
> > decide to run it on a machine which lacks the muscle to be aggressive,
> > well, you should have known better.
>
> That's a rather cheap shot.  "you should have known better" than
> expecting to be able to use a documented command and option because the
> git developers happened to have a nicer machine...
>
> _How_ is one supposed to have known better?
>
> --
> David Kastrup, Kriemhildstr. 15, 44793 Bochum

In GIT, the --aggressive option doesn't make it aggressive.
In GCC, the -Wall option doesn't enable all warnings.

                                                           #
It's a "Tie one to one" with the similar reputations.   #######
                             To have a rest in peace.      #
                                                           #
   J.C.Pizarro                                             #
