From: Miles Bader <miles@gnu.org>
Subject: Re: Do most people feel tracking branches useful?
Date: Wed, 29 Oct 2008 18:08:29 +0900
Message-ID: <buoprlj4vle.fsf@dhapc248.dev.necel.com>
References: <49082514.9050405@gmail.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Liu Yubao <yubao.liu@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 10:09:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kv73l-0004kI-RS
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 10:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752891AbYJ2JIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 05:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752890AbYJ2JIg
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 05:08:36 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:44291 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879AbYJ2JIf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 05:08:35 -0400
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id m9T98SE3010818;
	Wed, 29 Oct 2008 18:08:29 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay21.aps.necel.com with ESMTP; Wed, 29 Oct 2008 18:08:29 +0900
Received: from dhapc248.dev.necel.com ([10.114.112.215] [10.114.112.215]) by relay11.aps.necel.com with ESMTP; Wed, 29 Oct 2008 18:08:29 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id 68B8219; Wed, 29 Oct 2008 18:08:29 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <49082514.9050405@gmail.com> (Liu Yubao's message of "Wed, 29 Oct
	2008 16:55:48 +0800")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99353>

Liu Yubao <yubao.liu@gmail.com> writes:
> do most people feel tracking branches useful?

Extremely useful.  I usually keep local branches closely synchronized
with a remote "central" version, and tracking branches make the frequent
push/pull much more convenient.

I often delete the default local "master" branch though, and have only
one local branch per working directory (and like you, use origin/... for
much interbranch synchronization, e.g. rebasing).

-Miles

-- 
"Whatever you do will be insignificant, but it is very important that
 you do it."  Mahatma Gandhi
