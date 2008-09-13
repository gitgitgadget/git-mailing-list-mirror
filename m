From: Heikki Orsila <shd@modeemi.fi>
Subject: Re: [PATCH] Start conforming code to "git subcmd" style part 3
Date: Sat, 13 Sep 2008 20:13:31 +0300
Message-ID: <20080913171331.GG26096@jolt.modeemi.cs.tut.fi>
References: <20080913163058.GA5108@zakalwe.fi> <200809131908.34145.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Andreas Ericsson <ae@op5.se>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Sep 13 19:15:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeYiL-0000Lb-PA
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 19:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246AbYIMROK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2008 13:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752176AbYIMROJ
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Sep 2008 13:14:09 -0400
Received: from mail.cs.tut.fi ([130.230.4.42]:35761 "EHLO mail.cs.tut.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751991AbYIMROI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2008 13:14:08 -0400
Received: from amavis2.cs.tut.fi (amavis2.cs.tut.fi [130.230.4.70])
	by mail.cs.tut.fi (Postfix) with ESMTP id 10B65915F;
	Sat, 13 Sep 2008 20:14:05 +0300 (EEST)
Received: from mail.cs.tut.fi ([130.230.4.42])
 by amavis2.cs.tut.fi (amavis2.cs.tut.fi [130.230.4.70]) (amavisd-maia, port 10024)
 with ESMTP id 07553-07; Sat, 13 Sep 2008 20:14:03 +0300 (EEST)
Received: from modeemi.modeemi.cs.tut.fi (modeemi.modeemi.cs.tut.fi [130.230.72.134])
	by mail.cs.tut.fi (Postfix) with ESMTP id 4040E915B;
	Sat, 13 Sep 2008 20:14:03 +0300 (EEST)
Received: from jolt.modeemi.cs.tut.fi (jolt.modeemi.cs.tut.fi [130.230.72.144])
	by modeemi.modeemi.cs.tut.fi (Postfix) with ESMTP id 1FC8622200;
	Sat, 13 Sep 2008 20:13:33 +0300 (EEST)
Received: by jolt.modeemi.cs.tut.fi (Postfix, from userid 16311)
	id 707394F9C4; Sat, 13 Sep 2008 20:13:32 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <200809131908.34145.trast@student.ethz.ch>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: Maia Mailguard 1.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95811>

On Sat, Sep 13, 2008 at 07:08:31PM +0200, Thomas Rast wrote:
> I think the quotes should go one further to the right:
> +	 * "git tar-tree" is now a wrapper around "git archive --format=tar"

Ah yes, thanks. Will resubmit.

-- 
Heikki Orsila
heikki.orsila@iki.fi
http://www.iki.fi/shd
