From: zooko <zooko@zooko.com>
Subject: Re: [ANNOUNCE] darcs-fast-export
Date: Mon, 10 Nov 2008 19:39:26 -0700
Message-ID: <AC24F62F-9CFC-442D-8744-813F1930C2F7@zooko.com>
References: <20081111015313.GB24201@genesis.frugalware.org>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: bazaar@lists.canonical.com, mercurial@selenic.com, git@vger.kernel.org,
	darcs-users@darcs.net
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: darcs-users-bounces@darcs.net Tue Nov 11 03:42:03 2008
Return-path: <darcs-users-bounces@darcs.net>
Envelope-to: gcvdu-darcs-users@gmane.org
Received: from fraxinus.osuosl.org ([140.211.166.137])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzjCd-0000sr-2k
	for gcvdu-darcs-users@gmane.org; Tue, 11 Nov 2008 03:42:03 +0100
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F25793DB8F;
	Tue, 11 Nov 2008 02:40:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DArVqRuoIDRX; Tue, 11 Nov 2008 02:40:50 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4329D3DB0F;
	Tue, 11 Nov 2008 02:40:50 +0000 (UTC)
X-Original-To: darcs-users@lists.darcs.net
Delivered-To: darcs-users@osuosl.org
Received: from fraxinus.osuosl.org (fraxinus.osuosl.org [140.211.166.137])
	by ash.osuosl.org (Postfix) with ESMTP id 3FBAA8F74E
	for <darcs-users@lists.darcs.net>; Tue, 11 Nov 2008 02:40:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2E0F03DB0F
	for <darcs-users@lists.darcs.net>; Tue, 11 Nov 2008 02:40:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R4n-wMSQJTTL for <darcs-users@lists.darcs.net>;
	Tue, 11 Nov 2008 02:40:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.4
Received: from nooxie.zooko.com (nooxie.zooko.com [207.7.131.41])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 822D93DA54
	for <darcs-users@darcs.net>; Tue, 11 Nov 2008 02:40:47 +0000 (UTC)
Received: from [192.168.1.157] (97-118-99-189.hlrn.qwest.net [97.118.99.189])
	by nooxie.zooko.com (Postfix) with ESMTP id E8DBC883F0;
	Mon, 10 Nov 2008 18:41:44 -0800 (PST)
In-Reply-To: <20081111015313.GB24201@genesis.frugalware.org>
X-Mailer: Apple Mail (2.753.1)
X-BeenThere: darcs-users@darcs.net
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: A list for users of darcs <darcs-users.darcs.net>
List-Unsubscribe: <http://lists.osuosl.org/mailman/listinfo/darcs-users>,
	<mailto:darcs-users-request@darcs.net?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/darcs-users>
List-Post: <mailto:darcs-users@darcs.net>
List-Help: <mailto:darcs-users-request@darcs.net?subject=help>
List-Subscribe: <http://lists.osuosl.org/mailman/listinfo/darcs-users>,
	<mailto:darcs-users-request@darcs.net?subject=subscribe>
Sender: darcs-users-bounces@darcs.net
Errors-To: darcs-users-bounces@darcs.net
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100613>

Hello Miklos Vajna:

Thanks for announcing this project.

I looked at the "alternatives" section, and you wrote:

"tailor is a nice any2any VCS converter, but the end result can  
easily differ to the original repo because tailor replays all the  
changesets itself, while darcs-fast-export just leaves this task to  
darcs."

If you can show an example of the end result differing from the  
original repo then that is a bug in tailor, and please report it!

Thanks.

Regards,

Zooko
---
http://allmydata.org -- Tahoe, the Least-Authority Filesystem
http://allmydata.com -- back up all your files for $10/month
