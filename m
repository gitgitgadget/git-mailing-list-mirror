From: Valentin Haenel <valentin@fsfe.org>
Subject: Re: [PATCH v3 3/3] Add support for -p/--patch to git-commit
Date: Sat, 7 May 2011 12:46:13 +0200
Message-ID: <20110507104613.GA20375@kudu.in-berlin.de>
References: <1304748001-17982-1-git-send-email-conrad.irwin@gmail.com> <1304748001-17982-4-git-send-email-conrad.irwin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: conrad.irwin@gmail.com
X-From: git-owner@vger.kernel.org Sat May 07 12:46:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIf1i-0000BA-24
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 12:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793Ab1EGKqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2011 06:46:17 -0400
Received: from kudu.in-berlin.de ([192.109.42.123]:44100 "EHLO
	kudu.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754347Ab1EGKqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2011 06:46:16 -0400
Received: from kudu.in-berlin.de (localhost [127.0.0.1])
	by kudu.in-berlin.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p47AkDZW021776;
	Sat, 7 May 2011 12:46:13 +0200
Received: (from esc@localhost)
	by kudu.in-berlin.de (8.14.3/8.14.3/Submit) id p47AkDUr021775;
	Sat, 7 May 2011 12:46:13 +0200
X-Authentication-Warning: kudu.in-berlin.de: esc set sender to valentin@fsfe.org using -f
Content-Disposition: inline
In-Reply-To: <1304748001-17982-4-git-send-email-conrad.irwin@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173047>

Being a big fan of the --patch options for various commands, I like this
one.

Since it uses the add--interactive.perl stuff, it would also be affacted
by 'interactive.singlekey'. So it might be worth mentioning that in
config.txt for sake of completeness. I currently have some patches that
modify config.txt in this regard, cooking in next, see: 46b522c

V-
