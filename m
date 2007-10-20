From: David Brown <git@davidb.org>
Subject: Re: [PATCH] Deduce exec_path also from calls to git with a
	relative path
Date: Sat, 20 Oct 2007 05:25:16 -0700
Message-ID: <20071020122516.GA23190@old.davidb.org>
References: <20071020064617.GC2237@srparish.net> <Pine.LNX.4.64.0710200818410.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Scott R Parish <srp@srparish.net>, git@vger.kernel.org,
	spearce@spearce.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 20 14:25:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjDOd-0006YT-Ak
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 14:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754360AbXJTMZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 08:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753866AbXJTMZX
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 08:25:23 -0400
Received: from mail.davidb.org ([66.93.32.219]:46273 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751445AbXJTMZW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 08:25:22 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.67 #1 (Debian))
	id 1IjDOG-000637-VV; Sat, 20 Oct 2007 05:25:16 -0700
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Scott R Parish <srp@srparish.net>, git@vger.kernel.org,
	spearce@spearce.org, gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710200818410.25221@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61828>

On Sat, Oct 20, 2007 at 08:21:34AM +0100, Johannes Schindelin wrote:

>For example, when you call "../../hello/world/git", it will not turn
>"../../hello/world" into an absolute path, and use that.

Did you mean "it will turn..."?

David
