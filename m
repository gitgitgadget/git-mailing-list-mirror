From: Miles Bader <miles.bader@necel.com>
Subject: Re: [FEATURE REQUEST] git-svn format-patch
Date: Wed, 16 Jan 2008 15:41:38 +0900
Message-ID: <buo3asymfvh.fsf@dhapc248.dev.necel.com>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com>
	<alpine.DEB.1.00.0801151444180.5289@eeepc-johanness>
	<c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com>
	<alpine.DEB.1.00.0801151612470.5289@eeepc-johanness>
	<c0f2d4110801150823u7899e6dds1192b5f3bb3f7133@mail.gmail.com>
	<alpine.DEB.1.00.0801151650240.5289@eeepc-johanness>
	<c0f2d4110801150907y59593407u820c7b3db556ed31@mail.gmail.com>
	<alpine.DEB.1.00.0801151709330.5289@eeepc-johanness>
	<c0f2d4110801151104j4c34dekc7d06dcfc89bfbe6@mail.gmail.com>
	<20080115201530.GA17239@efreet.light.src>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Ortman <chrisortman@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Jan 16 07:42:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF1z3-0002fn-E9
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 07:42:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833AbYAPGmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 01:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752829AbYAPGmR
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 01:42:17 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:38779 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbYAPGmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 01:42:16 -0500
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id m0G6fai9004892;
	Wed, 16 Jan 2008 15:41:39 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay31.aps.necel.com with ESMTP; Wed, 16 Jan 2008 15:41:39 +0900
Received: from dhapc248.dev.necel.com ([10.114.112.215] [10.114.112.215]) by relay31.aps.necel.com with ESMTP; Wed, 16 Jan 2008 15:41:39 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id 0AB023C7; Wed, 16 Jan 2008 15:41:38 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <20080115201530.GA17239@efreet.light.src> (Jan Hudec's message of
	"Tue, 15 Jan 2008 21:15:30 +0100")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70641>

Jan Hudec <bulb@ucw.cz> writes:
> Git currently uses C, shell, perl and tcl/tk. There would probably be some
> resistance to adding more dependencies, but that would not apply to the
> contrib directory (so useful things written in something else are likely to
> end up there).

Is tcl/tk restricted to the GUI stuff?

-Miles

-- 
A zen-buddhist walked into a pizza shop and
said, "Make me one with everything."
