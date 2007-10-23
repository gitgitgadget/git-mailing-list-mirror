From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 7/9] git-hash-object: Add --stdin-paths option
Date: Tue, 23 Oct 2007 01:53:31 -0400
Message-ID: <20071023055331.GF14735@spearce.org>
References: <1193118397-4696-1-git-send-email-aroben@apple.com> <1193118397-4696-2-git-send-email-aroben@apple.com> <1193118397-4696-3-git-send-email-aroben@apple.com> <1193118397-4696-4-git-send-email-aroben@apple.com> <1193118397-4696-5-git-send-email-aroben@apple.com> <1193118397-4696-6-git-send-email-aroben@apple.com> <1193118397-4696-7-git-send-email-aroben@apple.com> <1193118397-4696-8-git-send-email-aroben@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Tue Oct 23 07:53:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkCiA-0000K4-Ho
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 07:53:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364AbXJWFxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 01:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752562AbXJWFxk
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 01:53:40 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41660 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbXJWFxj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 01:53:39 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IkChr-0005Ev-Hp; Tue, 23 Oct 2007 01:53:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7EF5420FBAE; Tue, 23 Oct 2007 01:53:31 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1193118397-4696-8-git-send-email-aroben@apple.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62106>

Adam Roben <aroben@apple.com> wrote:
> This allows multiple paths to be specified on stdin.

git-fast-import wasn't suited to the task?
 
-- 
Shawn.
