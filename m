From: Miles Bader <miles.bader@necel.com>
Subject: Re: [PATCH] fast importer for SCCS files
Date: Mon, 21 Jan 2008 14:53:08 +0900
Message-ID: <buo7ii3pvwb.fsf@dhapc248.dev.necel.com>
References: <c5df85930801200312o7cd5d307v1a39fb35179249a9@mail.gmail.com>
	<7vsl0s57e8.fsf@gitster.siamese.dyndns.org>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "James Youngman" <jay@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 06:54:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGpbX-0005QN-TB
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 06:53:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbYAUFxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 00:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752133AbYAUFxW
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 00:53:22 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:49519 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbYAUFxW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 00:53:22 -0500
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id m0L5r8g1029298;
	Mon, 21 Jan 2008 14:53:09 +0900 (JST)
Received: from relay21.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay31.aps.necel.com with ESMTP; Mon, 21 Jan 2008 14:53:09 +0900
Received: from dhapc248.dev.necel.com ([10.114.112.215] [10.114.112.215]) by relay21.aps.necel.com with ESMTP; Mon, 21 Jan 2008 14:53:08 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id D4231479; Mon, 21 Jan 2008 14:53:08 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <7vsl0s57e8.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 20 Jan 2008 16:50:23 -0800")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71222>

Junio C Hamano <gitster@pobox.com> writes:
> You seem to be using a tab-width that is not 8, and it shows
> everywhere.

In a python script, too...

-miles

-- 
Alliance, n. In international politics, the union of two thieves who have
their hands so deeply inserted in each other's pockets that they cannot
separately plunder a third.
