From: Robert Luberda <robert@debian.org>
Subject: Re: [PATCH/RFC] git svn: handle errors and concurrent commits in
 dcommit
Date: Sat, 25 Aug 2012 01:47:19 +0200
Organization: Debian
Message-ID: <50381287.4090605@debian.org>
References: <1343856397-6536-1-git-send-email-robert@debian.org> <20120802104421.GA13271@dcvr.yhbt.net> <5021F9D4.1010700@debian.org> <20120808230754.GB24956@dcvr.yhbt.net> <7v1ujgot8h.fsf@alter.siamese.dyndns.org> <20120810195133.GA16423@dcvr.yhbt.net> <50316C07.30907@debian.org> <20120821220125.GA2040@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: Robert Luberda <robert@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Aug 25 01:47:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T53bT-0001hf-Oy
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 01:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755749Ab2HXXrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 19:47:45 -0400
Received: from master.debian.org ([70.103.162.29]:48416 "EHLO
	master.debian.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755031Ab2HXXrn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 19:47:43 -0400
Received: from localhost ([127.0.0.1] helo=vox.robbo.home)
	by master.debian.org with esmtp (Exim 4.72)
	(envelope-from <robert@debian.org>)
	id 1T53bE-0000rp-Lf; Fri, 24 Aug 2012 23:47:36 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by vox.robbo.home (Postfix) with ESMTP id DAA97E2B2A;
	Sat, 25 Aug 2012 01:47:19 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.6esrpre) Gecko/20120817 Icedove/10.0.6
In-Reply-To: <20120821220125.GA2040@dcvr.yhbt.net>
X-Enigmail-Version: 1.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204242>

Eric Wong wrote:

Hi,

> 
> Oops, I'll push the following out since Junio already merged your
> original:

I can see that you haven't pushed the change yet. Maybe it would be a
good idea to fix other style mistakes  (extra spaces after redirections,
lack of spaces after function names, `[' used instead of `test', etc) as
well? I can prepare a patch if you think it is a good idea.

Regards,
robert
