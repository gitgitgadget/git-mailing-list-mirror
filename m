From: Stephen Bash <bash@genarts.com>
Subject: Re: Speeding up the initial git-svn fetch
Date: Wed, 13 Oct 2010 14:18:23 -0400 (EDT)
Message-ID: <4427644.485916.1286993903296.JavaMail.root@mail.hq.genarts.com>
References: <AANLkTimn99ErpLNfX-Jxn2t6cKCOoKFb91g1_m3TypOf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matt Stump <mstump@goatyak.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 20:18:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P65uP-0005S2-RZ
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 20:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934Ab0JMSSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 14:18:31 -0400
Received: from hq.genarts.com ([173.9.65.1]:16243 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751763Ab0JMSSa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 14:18:30 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 91CBA1E26934;
	Wed, 13 Oct 2010 14:18:29 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xE5P8RGcBfe9; Wed, 13 Oct 2010 14:18:23 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 5FC211E26309;
	Wed, 13 Oct 2010 14:18:23 -0400 (EDT)
In-Reply-To: <AANLkTimn99ErpLNfX-Jxn2t6cKCOoKFb91g1_m3TypOf@mail.gmail.com>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158957>

----- Original Message -----
> From: "Matt Stump" <mstump@goatyak.com>
> To: git@vger.kernel.org
> Sent: Wednesday, October 13, 2010 1:47:46 PM
> Subject: Re: Speeding up the initial git-svn fetch
>
> I hate making more work for people but I would love a copy of your
> notes. Getting a full clone of our SVN repository is probably the
> biggest hurdle to having a git insurgency take root. Also, which GSoC
> project were you referring to?

This one:

https://git.wiki.kernel.org/index.php/SoC2010Projects#Native_SVN_support_in_git

My notes are currently in our internal wiki, so those should be pretty easy to transpose to e-mail.  I'll need to do a little sanitization on the scripts though, and I'll look into posting those somewhere as links (all perl, just under 1400 lines all tolled).

Stephen
