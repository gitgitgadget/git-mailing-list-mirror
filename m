From: Paul Mackerras <paulus@samba.org>
Subject: Re: please pull ppc64-2.6.git
Date: Tue, 30 Aug 2005 09:31:48 +1000
Message-ID: <17171.39652.237263.484079@cargo.ozlabs.ibm.com>
References: <17170.25803.413408.44080@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0508291006440.3243@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linuxppc64-dev@ozlabs.org, Git Mailing List <git@vger.kernel.org>
X-From: linuxppc64-dev-bounces@ozlabs.org Tue Aug 30 01:32:20 2005
Return-path: <linuxppc64-dev-bounces@ozlabs.org>
Received: from ozlabs.org ([203.10.76.45])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9t6L-0000Hj-Rm
	for glppd-linuxppc64-dev@m.gmane.org; Tue, 30 Aug 2005 01:31:43 +0200
Received: from ozlabs.org (localhost [127.0.0.1])
	by ozlabs.org (Postfix) with ESMTP id 2AB0268149;
	Tue, 30 Aug 2005 09:31:38 +1000 (EST)
X-Original-To: linuxppc64-dev@ozlabs.org
Delivered-To: linuxppc64-dev@ozlabs.org
Received: by ozlabs.org (Postfix, from userid 1003)
	id 0A1E968148; Tue, 30 Aug 2005 09:31:37 +1000 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508291006440.3243@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7926>

Linus Torvalds writes:

> 	echo /pub/scm/linux/kernel/git/torvalds/linux-2.6/objects > objects/info/alternates

Did that (s/linux-2.6/linux-2.6.git/ actually...)

What can one put in the alternates file?  Just an absolute path, or
does a relative path or a URL work too?

> or similar. That also makes gitweb able to show diffs etc, something it 
> can't do for a broken partial repository.

Gitweb still doesn't work; I think someone needs to update the git on
*.kernel.org.

Paul.
