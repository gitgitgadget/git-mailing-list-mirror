From: Paul Mackerras <paulus@samba.org>
Subject: Re: Mark Levedahl's gitk patches
Date: Tue, 26 Jun 2007 14:02:05 +1000
Message-ID: <18048.36797.283166.952377@cargo.ozlabs.ibm.com>
References: <467FE7C4.5E421535@eudaptics.com>
	<46807CEF.2010109@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <J.Sixt@eudaptics.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Tue Jun 26 06:02:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I32Fq-0005bd-N2
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 06:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbXFZECN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 00:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbXFZECN
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 00:02:13 -0400
Received: from ozlabs.org ([203.10.76.45]:36746 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750884AbXFZECN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 00:02:13 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 01C0CDDE11; Tue, 26 Jun 2007 14:02:11 +1000 (EST)
In-Reply-To: <46807CEF.2010109@verizon.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50946>

Mark Levedahl writes:

> I found a bug in the highlight patch (the color picker updated the wrong 
> panel in the chooser but did set the correct color), and updated the 
> tab-stop patch to use a spin control to enforce entry of small integers 
> only. As there is possible interest, I am sending the amended series.

Ah.  I just pushed out a pile of patches to gitk.git including your
three.  Could you do an incremental patch on top of that for me?

Thanks,
Paul.
