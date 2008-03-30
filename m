From: Adam Simpkins <adam@adamsimpkins.net>
Subject: Re: [PATCH] Add new git-graph command
Date: Sun, 30 Mar 2008 15:00:38 -0700
Message-ID: <20080330220037.GA10978@adamsimpkins.net>
References: <20080330195840.GA8695@adamsimpkins.net> <m33aq8ueq5.fsf@localhost.localdomain>
Reply-To: Adam Simpkins <adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 00:01:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg5ad-0003GZ-Gc
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 00:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754447AbYC3WAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 18:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754448AbYC3WAl
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 18:00:41 -0400
Received: from smtp182.iad.emailsrvr.com ([207.97.245.182]:60579 "EHLO
	smtp182.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754382AbYC3WAl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 18:00:41 -0400
Received: from relay8.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay8.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id BB20D1B51A9;
	Sun, 30 Mar 2008 18:00:39 -0400 (EDT)
Received: by relay8.relay.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 83F9E1B5118;
	Sun, 30 Mar 2008 18:00:39 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 1F02114100B8; Sun, 30 Mar 2008 15:00:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m33aq8ueq5.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78517>

On Sun, Mar 30, 2008 at 01:41:43PM -0700, Jakub Narebski wrote:
> Adam Simpkins <adam@adamsimpkins.net> writes:
> 
> > This is a first pass at a command to print a text-based graph of the commit
> > history.  It is similar to the history graph shown by gitk, but doesn't
> > require a windowing system.
> 
> Should I understand that git-show-branch has too cryptic an output?

Yes, I find it a bit hard to read with more than just a few branches.

-- 
Adam Simpkins
adam@adamsimpkins.net
