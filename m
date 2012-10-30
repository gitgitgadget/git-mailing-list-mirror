From: Chris Webb <chris@arachsys.com>
Subject: Re: [PATCH v5 00/14] New remote-hg helper
Date: Tue, 30 Oct 2012 10:28:27 +0000
Message-ID: <20121030102827.GO4891@arachsys.com>
References: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
 <20121030102526.GN4891@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 11:28:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT93s-000561-28
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 11:28:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758490Ab2J3K2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 06:28:30 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:58383 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758214Ab2J3K23 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 06:28:29 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.80)
	(envelope-from <chris@arachsys.com>)
	id 1TT93c-0000RW-MT; Tue, 30 Oct 2012 10:28:29 +0000
Content-Disposition: inline
In-Reply-To: <20121030102526.GN4891@arachsys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208692>

Chris Webb <chris@arachsys.com> writes:

> The first is really a symptom of a general difference between hg and git: an hg
> repository can have multiple heads, whereas a git repo has exactly one head.

By this I mean an hg repository without bookmarks or branches can still have
multiple heads, whereas a git branch points at exactly one place. Sorry,
very vague description there!

Cheers,

Chris.
