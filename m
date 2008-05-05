From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: OSX, ZFS, UTF8, git - somebody hates me in this list
Date: Mon, 05 May 2008 10:39:43 -0700
Message-ID: <8663tsbqg0.fsf@blue.stonehenge.com>
References: <86wsm9dbhk.fsf@blue.stonehenge.com>
	<20080504215208.GG29038@spearce.org>
	<86skwxd97d.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 05 19:40:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt4gG-0006jh-Uj
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 19:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbYEERjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 13:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbYEERjp
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 13:39:45 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:22889 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbYEERjo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 13:39:44 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 96BA31DE26F; Mon,  5 May 2008 10:39:43 -0700 (PDT)
x-mayan-date: Long count = 12.19.15.5.9; tzolkin = 3 Muluc; haab = 12 Uo
In-Reply-To: <86skwxd97d.fsf@blue.stonehenge.com> (Randal L. Schwartz's message of "Sun, 04 May 2008 14:56:54 -0700")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81302>

>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:

Shawn> Isn't this just the normal HFS+ name mangling?

Randal> I don't recall having this problem on HFS+.

Also, ZFS is case-sensitive, which leads me to believe that out of
the box, it's more like UFS.

Still don't know why ZFS breaks but UFS works.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
