From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: please pull ppc64-2.6.git
Date: Mon, 29 Aug 2005 19:20:13 +0100
Message-ID: <20050829192013.B20605@flint.arm.linux.org.uk>
References: <17170.25803.413408.44080@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0508291006440.3243@g5.osdl.org>
	<20050829184510.A20605@flint.arm.linux.org.uk>
	<Pine.LNX.4.58.0508291057380.3243@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc64-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: linuxppc64-dev-bounces@ozlabs.org Mon Aug 29 20:24:07 2005
Return-path: <linuxppc64-dev-bounces@ozlabs.org>
Received: from ozlabs.org ([203.10.76.45])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9oFB-0004Aa-Uu
	for glppd-linuxppc64-dev@m.gmane.org; Mon, 29 Aug 2005 20:20:31 +0200
Received: from ozlabs.org (localhost [127.0.0.1])
	by ozlabs.org (Postfix) with ESMTP id 4E2406818C;
	Tue, 30 Aug 2005 04:20:27 +1000 (EST)
X-Original-To: linuxppc64-dev@ozlabs.org
Delivered-To: linuxppc64-dev@ozlabs.org
X-Greylist: delayed 2102 seconds by postgrey-1.21 at ozlabs;
	Tue, 30 Aug 2005 04:20:25 EST
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[212.18.232.186])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D991868185
	for <linuxppc64-dev@ozlabs.org>; Tue, 30 Aug 2005 04:20:25 +1000 (EST)
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1E9oF0-0002jX-E5; Mon, 29 Aug 2005 19:20:19 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1E9oEx-0006RS-1r; Mon, 29 Aug 2005 19:20:15 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0508291057380.3243@g5.osdl.org>;
	from torvalds@osdl.org on Mon, Aug 29, 2005 at 11:02:38AM -0700
X-BeenThere: linuxppc64-dev@ozlabs.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: 64-bit Linux on PowerPC Developers Mail List
	<linuxppc64-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc64-dev>,
	<mailto:linuxppc64-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc64-dev>
List-Post: <mailto:linuxppc64-dev@ozlabs.org>
List-Help: <mailto:linuxppc64-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc64-dev>,
	<mailto:linuxppc64-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc64-dev-bounces@ozlabs.org
Errors-To: linuxppc64-dev-bounces@ozlabs.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7913>

On Mon, Aug 29, 2005 at 11:02:38AM -0700, Linus Torvalds wrote:
> The "objects/info/alternates" thing is an extension, which allows you to 
> have a partial object store, and point to the "rest of it", and still have 
> all the tools understand it and be able to parse the totality of it. So it 
> doesn't break or change old formats, it only allows a new one.

Ah, ok.  I thought it was a new requirement, and I had visions of
similar complaints about my repositories.  Thanks for explaining
the situation.

-- 
Russell King
