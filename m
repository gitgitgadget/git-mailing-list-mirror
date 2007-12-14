From: Nicolas Pitre <nico@cam.org>
Subject: Re: Something is broken in repack
Date: Fri, 14 Dec 2007 08:25:16 -0500 (EST)
Message-ID: <alpine.LFD.0.999999.0712140823580.8467@xanadu.home>
References: <alpine.LFD.0.99999.0712120743040.555@xanadu.home>  <fcaeb9bf0712130532s79aa7afeve6f018f9430ab3b3@mail.gmail.com>  <fjrj9k$n6k$1@ger.gmane.org> <47616044.7070504@viscovery.net>  <fjskqt$eap$1@ger.gmane.org> <fjt6vm$n7d$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, gcc@gcc.gnu.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: gcc-return-142984-gcc=m.gmane.org@gcc.gnu.org Fri Dec 14 14:25:56 2007
Return-path: <gcc-return-142984-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J3AY7-0003M8-ND
	for gcc@gmane.org; Fri, 14 Dec 2007 14:25:56 +0100
Received: (qmail 25329 invoked by alias); 14 Dec 2007 13:25:35 -0000
Received: (qmail 25295 invoked by uid 22791); 14 Dec 2007 13:25:34 -0000
X-Spam-Check-By: sourceware.org
Received: from relais.videotron.ca (HELO relais.videotron.ca) (24.201.245.36)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 14 Dec 2007 13:25:23 +0000
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca  (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))  with ESMTP id <0JT1005YWJY27ZF0@VL-MO-MR005.ip.videotron.ca> for  gcc@gcc.gnu.org; Fri, 14 Dec 2007 08:25:14 -0500 (EST)
In-reply-to: <fjt6vm$n7d$1@ger.gmane.org>
User-Agent: Alpine 0.999999 (LFD 847 2007-12-06)
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68302>

On Fri, 14 Dec 2007, Paolo Bonzini wrote:

> > Hmmm... it is even documented in git-gc(1)... and git-index-pack(1) of
> > all things.
> 
> I found that the .keep file is not transmitted over the network (at least I
> tried with git+ssh:// and http:// protocols), however.

That is a local policy.


Nicolas
