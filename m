From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: Something is broken in repack
Date: Fri, 14 Dec 2007 09:20:45 +0100
Message-ID: <fjtect$8qn$1@ger.gmane.org>
References: <alpine.LFD.0.99999.0712120743040.555@xanadu.home> 	 <fcaeb9bf0712130532s79aa7afeve6f018f9430ab3b3@mail.gmail.com> 	 <fjrj9k$n6k$1@ger.gmane.org> <47616044.7070504@viscovery.net> 	 <fjskqt$eap$1@ger.gmane.org> <fjt6vm$n7d$1@ger.gmane.org> <fcaeb9bf0712132224u54ca845ap4836dfe1cda37b29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gcc@gcc.gnu.org
X-From: gcc-return-142979-gcc=m.gmane.org@gcc.gnu.org Fri Dec 14 09:43:24 2007
Return-path: <gcc-return-142979-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J368h-00012P-Sd
	for gcc@gmane.org; Fri, 14 Dec 2007 09:43:24 +0100
Received: (qmail 23122 invoked by alias); 14 Dec 2007 08:42:56 -0000
Received: (qmail 23114 invoked by uid 22791); 14 Dec 2007 08:42:55 -0000
X-Spam-Check-By: sourceware.org
Received: from main.gmane.org (HELO ciao.gmane.org) (80.91.229.2)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 14 Dec 2007 08:42:43 +0000
Received: from list by ciao.gmane.org with local (Exim 4.43) 	id 1J35zL-0003gG-Ur 	for gcc@gcc.gnu.org; Fri, 14 Dec 2007 08:33:43 +0000
Received: from 195.176.178.209 ([195.176.178.209])         by main.gmane.org with esmtp (Gmexim 0.1 (Debian))         id 1AlnuQ-0007hv-00         for <gcc@gcc.gnu.org>; Fri, 14 Dec 2007 08:33:43 +0000
Received: from bonzini by 195.176.178.209 with local (Gmexim 0.1 (Debian))         id 1AlnuQ-0007hv-00         for <gcc@gcc.gnu.org>; Fri, 14 Dec 2007 08:33:43 +0000
User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
In-Reply-To: <fcaeb9bf0712132224u54ca845ap4836dfe1cda37b29@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68266>


> I'm thinking about "git clone --keep" to mark initial packs precious.
> But 'git clone' is under rewrite to C. Let's wait until C rewrite is
> done.

It should be the default, IMHO.

Paolo
