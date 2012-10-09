From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: username case conflict in git svn clone
Date: Tue, 09 Oct 2012 20:02:46 +0200
Message-ID: <m27gqz8qwp.fsf@igel.home>
References: <5074546D.9010701@conted.ox.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Balch <david.balch@conted.ox.ac.uk>
X-From: git-owner@vger.kernel.org Tue Oct 09 20:03:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLe8y-00010n-Eg
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 20:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756599Ab2JISCt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 14:02:49 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:49717 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190Ab2JISCs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 14:02:48 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XbmWC0FLdz4KK40;
	Tue,  9 Oct 2012 20:02:46 +0200 (CEST)
X-Auth-Info: WvpM/XBm41Jfw6/BSDlQNKcMEip9DBwg/g8koRzS5j8=
Received: from igel.home (ppp-88-217-104-135.dynamic.mnet-online.de [88.217.104.135])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XbmWB6d7wzbbfN;
	Tue,  9 Oct 2012 20:02:46 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 7BBDACA2A4; Tue,  9 Oct 2012 20:02:46 +0200 (CEST)
X-Yow: Then, it's off to RED CHINA!!
In-Reply-To: <5074546D.9010701@conted.ox.ac.uk> (David Balch's message of
	"Tue, 09 Oct 2012 17:44:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207335>

David Balch <david.balch@conted.ox.ac.uk> writes:

> whenusers.txt contains:
>
> juser Joe User <joe.user@example.com>
>
> JUser Joe User <joe.user@example.com>

Reread the manual.  Hint: there must be an equal sign.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
