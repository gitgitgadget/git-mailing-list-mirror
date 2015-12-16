From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFPR] updates for 2.7?
Date: Wed, 16 Dec 2015 01:00:17 +0000
Message-ID: <20151216010017.GA19633@dcvr.yhbt.net>
References: <xmqqtwnjcnrb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org,
	Niluge kiwi <kiwiiii@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 02:00:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a90S7-0007PS-G5
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 02:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932992AbbLPBAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 20:00:18 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:41649 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932818AbbLPBAS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 20:00:18 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9927220570;
	Wed, 16 Dec 2015 01:00:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqtwnjcnrb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282526>

Junio C Hamano <gitster@pobox.com> wrote:
> Git 2.7-rc1 has just been tagged, and the remainder of the year will
> be for the stabilization, fixes to brown-paper-bag bugs, reverts of
> regressions, etc., but I haven't seen updates to the various
> subsystems you guys maintain for some time.  Please throw me "this
> is a good time to pull and here are the updates" message in the
> coming few weeks.

Not much on the git-svn front.  I've been meaning to split out
further and make it lazy load for faster startup for a while...
(+Cc Niluge kiwi)
