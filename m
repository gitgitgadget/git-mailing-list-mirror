From: Chris Webb <chris@arachsys.com>
Subject: Re: Tests with broken && chains in pu
Date: Sun, 4 Apr 2010 21:45:09 +0100
Message-ID: <20100404204509.GA31315@arachsys.com>
References: <201004042208.58939.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Apr 04 22:47:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyWij-00077s-Ic
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 22:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212Ab0DDUq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 16:46:56 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:37216 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154Ab0DDUqz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 16:46:55 -0400
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1NyWib-0006DX-PL; Sun, 04 Apr 2010 21:46:54 +0100
Content-Disposition: inline
In-Reply-To: <201004042208.58939.j6t@kdbg.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143946>

Johannes Sixt <j6t@kdbg.org> writes:

> two commits in pu currently add tests with broken && chains:
> abbfd017 in cw/ws-indent-with-tab:

Thanks for spotting this mistake Johannes. Should I resubmit a corrected
version of the patch, Junio, or do you prefer to squash fixups directly into
the pu branch?

Best wishes,

Chris.
