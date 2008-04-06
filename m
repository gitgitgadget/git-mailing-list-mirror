From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] tcl/tk8.5: fix changing colors through
	Edit->Preferences
Date: Sun, 6 Apr 2008 13:09:57 +1000
Message-ID: <18424.16133.146077.411566@cargo.ozlabs.ibm.com>
References: <20080326184526.2240.qmail@b31b9595cabb35.315fe32.mid.smarden.org>
	<20080405163842.29563.qmail@4e504c5c8f9cc2.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Sun Apr 06 05:10:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiLHN-00085m-Nm
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 05:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755426AbYDFDKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 23:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755431AbYDFDKI
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 23:10:08 -0400
Received: from ozlabs.org ([203.10.76.45]:38843 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751744AbYDFDKH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 23:10:07 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id A531BDDDED; Sun,  6 Apr 2008 13:10:06 +1000 (EST)
In-Reply-To: <20080405163842.29563.qmail@4e504c5c8f9cc2.315fe32.mid.smarden.org>
X-Mailer: VM 7.19 under Emacs 22.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78883>

Gerrit Pape writes:

> Hi, any comments on this patch?  I can reproduce the problem on Debian
> with tcl/tk 8.5.1 and git 1.5.5.rc3.

Thanks for reminding me.  I have applied it.

Paul.
