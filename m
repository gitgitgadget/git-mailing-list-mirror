From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk patch display corner-case bug
Date: Sun, 19 Feb 2006 22:06:04 +1100
Message-ID: <17400.20764.131417.903578@cargo.ozlabs.ibm.com>
References: <20060218233618.GA29025@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 19 12:51:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAn63-0001HJ-7X
	for gcvg-git@gmane.org; Sun, 19 Feb 2006 12:51:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWBSLum convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 19 Feb 2006 06:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWBSLum
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Feb 2006 06:50:42 -0500
Received: from ozlabs.org ([203.10.76.45]:17067 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932403AbWBSLum convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2006 06:50:42 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id EAE55679F0; Sun, 19 Feb 2006 22:50:40 +1100 (EST)
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
In-Reply-To: <20060218233618.GA29025@diana.vm.bytemark.co.uk>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16433>

Karl Hasselstr=F6m writes:

> Totally correct except that it omitted the line consisting of only
> three dashes.

Could you check that the missing line is present in the output from
git-rev-list --header --parents --topo-order please?

Paul.
