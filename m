From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Global .git directory
Date: Tue, 27 Apr 2010 11:59:33 +0200
Message-ID: <201004271159.34071.trast@student.ethz.ch>
References: <alpine.LFD.2.00.1004270705280.15197@bbs.intern>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Gerhard Wiesinger <lists@wiesinger.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 12:00:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6haG-0007ze-Ih
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 12:00:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524Ab0D0J75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 05:59:57 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:46051 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752973Ab0D0J74 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 05:59:56 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Tue, 27 Apr
 2010 11:59:54 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Tue, 27 Apr
 2010 11:59:33 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.2; x86_64; ; )
In-Reply-To: <alpine.LFD.2.00.1004270705280.15197@bbs.intern>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145892>

Gerhard Wiesinger wrote:
> Hello,
> 
> I'm new to git and as far as I saw that feature is missing: Placing .git 
> directory/repository on a central place for many git repositories. This 
> feature ensures that data directories are kept clean from metadata of git.
[...]
> I think this should be easy to implement on a centralized point.

What problem are you trying to solve, what solution are you
attempting, and why does the .git get in the way of your proposed
solution?

(In other words, please convince us that this is actually worth
having.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
