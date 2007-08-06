From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-svn: Instructions for cloning a git-svn-created repository
Date: Mon, 06 Aug 2007 01:34:06 -0700
Message-ID: <7v643tdptt.fsf@assigned-by-dhcp.cox.net>
References: <1186388203181-git-send-email-aroben@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Eric Wong <normalperson@yhbt.net>
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 10:34:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHy2X-0002pB-I4
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 10:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755997AbXHFIeK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 04:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755993AbXHFIeJ
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 04:34:09 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:49227 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754790AbXHFIeI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 04:34:08 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070806083406.LGHA26965.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Mon, 6 Aug 2007 04:34:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YYa61X0041kojtg0000000; Mon, 06 Aug 2007 04:34:06 -0400
In-Reply-To: <1186388203181-git-send-email-aroben@apple.com> (Adam Roben's
	message of "Mon, 6 Aug 2007 01:16:43 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55125>

Thanks.

As I said on #git, I was just saying I got the impression that
this mode of operation is not supported from the #git traffic
during the past few days, without knowing if it is myself.

Making it clear how to do this in our documentation would help
those people who come to #git and ask about it, as it seems that
many people want to clone and share a git repository created by
git-svn.
