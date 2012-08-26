From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC] git svn: handle errors and concurrent commits in
 dcommit
Date: Sun, 26 Aug 2012 00:34:30 +0000
Message-ID: <20120826003430.GA32346@dcvr.yhbt.net>
References: <1343856397-6536-1-git-send-email-robert@debian.org>
 <20120802104421.GA13271@dcvr.yhbt.net>
 <5021F9D4.1010700@debian.org>
 <20120808230754.GB24956@dcvr.yhbt.net>
 <7v1ujgot8h.fsf@alter.siamese.dyndns.org>
 <20120810195133.GA16423@dcvr.yhbt.net>
 <50316C07.30907@debian.org>
 <20120821220125.GA2040@dcvr.yhbt.net>
 <50381287.4090605@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Robert Luberda <robert@debian.org>
X-From: git-owner@vger.kernel.org Sun Aug 26 02:34:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5QoM-00069w-JU
	for gcvg-git-2@plane.gmane.org; Sun, 26 Aug 2012 02:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754745Ab2HZAee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 20:34:34 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:49369 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752624Ab2HZAed (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2012 20:34:33 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 477CE1F520;
	Sun, 26 Aug 2012 00:34:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <50381287.4090605@debian.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204290>

Robert Luberda <robert@debian.org> wrote:
> Eric Wong wrote:
> > Oops, I'll push the following out since Junio already merged your
> > original:
> 
> I can see that you haven't pushed the change yet. Maybe it would be a
> good idea to fix other style mistakes  (extra spaces after redirections,
> lack of spaces after function names, `[' used instead of `test', etc) as
> well? I can prepare a patch if you think it is a good idea.

Oops, I got distracted.  Yes please on an updated patch.  Thanks.
