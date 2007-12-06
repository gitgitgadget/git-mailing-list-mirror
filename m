From: David Miller <davem@davemloft.net>
Subject: Re: Git and GCC
Date: Wed, 05 Dec 2007 20:20:47 -0800 (PST)
Message-ID: <20071205.202047.58135920.davem@davemloft.net>
References: <4aca3dc20712051841o71ab773ft6dd0714ebc355dd5@mail.gmail.com> 	<20071205.185203.262588544.davem@davemloft.net> 	<4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: ismail@pardus.org.tr, gcc@gcc.gnu.org, git@vger.kernel.org
To: dberlin@dberlin.org
X-From: gcc-return-142715-gcc=m.gmane.org@gcc.gnu.org Thu Dec 06 05:21:21 2007
Return-path: <gcc-return-142715-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J08EZ-0002MC-UF
	for gcc@gmane.org; Thu, 06 Dec 2007 05:21:12 +0100
Received: (qmail 10278 invoked by alias); 6 Dec 2007 04:20:53 -0000
Received: (qmail 10269 invoked by uid 22791); 6 Dec 2007 04:20:53 -0000
X-Spam-Check-By: sourceware.org
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net (HELO sunset.davemloft.net) (74.93.104.97)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Dec 2007 04:20:49 +0000
Received: from localhost (localhost [127.0.0.1]) 	by sunset.davemloft.net (Postfix) with ESMTP id 9756AC8C15C; 	Wed,  5 Dec 2007 20:20:47 -0800 (PST)
In-Reply-To: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>
X-Mailer: Mew version 5.2 on Emacs 22.1 / Mule 5.0 (SAKAKI)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67228>

From: "Daniel Berlin" <dberlin@dberlin.org>
Date: Wed, 5 Dec 2007 22:47:01 -0500

> The size is clearly not just svn data, it's in the git pack itself.

And other users have shown much smaller metadata from a GIT import,
and yes those are including all of the repository history and branches
not just the trunk.
