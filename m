From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH 1/5] Consistently use user-defined UI font everywhere in GUI tools.
Date: Mon, 26 Mar 2007 12:06:35 +0200
Message-ID: <20070326100635.GN8017@planck.djpig.de>
References: <20070326073715.GE44578@codelabs.ru> <7vr6rcxv5x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eygene Ryabinkin <rea-git@codelabs.ru>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 12:06:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVm6D-0005jC-R4
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 12:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586AbXCZKGq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 06:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753584AbXCZKGq
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 06:06:46 -0400
Received: from planck.djpig.de ([85.10.192.180]:53717 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753583AbXCZKGp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 06:06:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 452E888136;
	Mon, 26 Mar 2007 12:06:36 +0200 (CEST)
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (smtp.lichtenheld.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 18236-03; Mon, 26 Mar 2007 12:06:35 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 7C26A88137; Mon, 26 Mar 2007 12:06:35 +0200 (CEST)
Mail-Followup-To: Junio C Hamano <junkio@cox.net>,
	Eygene Ryabinkin <rea-git@codelabs.ru>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vr6rcxv5x.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lichtenheld.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43144>

On Mon, Mar 26, 2007 at 01:31:54AM -0700, Junio C Hamano wrote:
>  (2) address gitk patches to Paul Mackerras <paulus@samba.org>,
>      with cc: the list;
> 
>  (3) address git-gui patches to Shawn Pearce <spearce@spearce.org>
>      with cc: the list.

Maybe such information could be added to
Documentation/SubmittingPatches? Currently it only talks about
contrib/ vs. everything else and not e.g. about gitk and git-gui.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
