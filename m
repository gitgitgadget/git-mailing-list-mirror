From: "Ferry Huberts" <ferry.huberts@pelagic.nl>
Subject: Re: [msysGit] Windows & executable bit
Date: Tue, 18 Aug 2009 13:17:12 +0200 (CEST)
Message-ID: <4262.77.61.241.211.1250594232.squirrel@hupie.xs4all.nl>
References: <45321.77.61.241.211.1250588523.squirrel@hupie.xs4all.nl>
    <alpine.DEB.1.00.0908181213590.4680@intel-tinevez-2-302>
    <200908181223.48291.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Johannes Schindelin" <johannes.schindelin@gmx.de>,
	"Ferry Huberts" <ferry.huberts@pelagic.nl>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: "Thomas Rast" <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 18 13:18:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdMi3-0003vK-5P
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 13:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758778AbZHRLRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 07:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758785AbZHRLRN
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 07:17:13 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:39526 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758076AbZHRLRM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Aug 2009 07:17:12 -0400
Received: by Lighthouse.internal.Hupie.com (Postfix, from userid 48)
	id DD62458CA44; Tue, 18 Aug 2009 13:17:12 +0200 (CEST)
Received: from 77.61.241.211
        (SquirrelMail authenticated user ferry.huberts@pelagic.nl)
        by hupie.xs4all.nl with HTTP;
        Tue, 18 Aug 2009 13:17:12 +0200 (CEST)
In-Reply-To: <200908181223.48291.trast@student.ethz.ch>
User-Agent: SquirrelMail/1.4.8-5.el5.centos.7
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126374>

>
> Isn't that core.filemode ?
>

yep. works

however, the man page says that you'll have to configure it in this way when
you're on a broken filesystem like FAT. We're on NTFS however....
NTFS is also broken then?

excuse me for the questions, I'm really a Linux guy, I know very little about
Windows. I'm just the interface towards the community :-)
