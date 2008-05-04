From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: OSX, ZFS, UTF8, git - somebody hates me in this list
Date: Sun, 04 May 2008 15:00:11 -0700
Message-ID: <86k5i9d91w.fsf@blue.stonehenge.com>
References: <86wsm9dbhk.fsf@blue.stonehenge.com>
	<20080504215208.GG29038@spearce.org>
	<86skwxd97d.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 05 00:01:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsmGS-0002Jj-W2
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 00:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755529AbYEDWAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 18:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755452AbYEDWAN
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 18:00:13 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:15966 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754873AbYEDWAM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 18:00:12 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 757E91DE39C; Sun,  4 May 2008 15:00:11 -0700 (PDT)
x-mayan-date: Long count = 12.19.15.5.8; tzolkin = 2 Lamat; haab = 11 Uo
In-Reply-To: <86skwxd97d.fsf@blue.stonehenge.com> (Randal L. Schwartz's message of "Sun, 04 May 2008 14:56:54 -0700")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81204>

>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:

>>>>> "Shawn" == Shawn O Pearce <spearce@spearce.org> writes:

Shawn> Isn't this just the normal HFS+ name mangling?

Randal> I don't recall having this problem on HFS+.

Ahh, oddly enough, it does exactly the same on HFS+, but *not* UFS, which is
why I hadn't noticed it yet, since all of my things I mirror are on my UFS
partition, just in case they have case-colliding names.

I'm trying to get rid of my UFS partition because it's a pain in the rear,
so I was hoping to upgrade to ZFS.  Hence, the query.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
