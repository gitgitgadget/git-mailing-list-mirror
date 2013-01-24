From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v3 0/2] Make git-svn work with gitdir links
Date: Thu, 24 Jan 2013 01:27:24 +0000
Message-ID: <20130124012724.GA8112@dcvr.yhbt.net>
References: <20120308005103.GA27398@dcvr.yhbt.net>
 <1358731322-44600-1-git-send-email-barry.wardell@gmail.com>
 <20130123023235.GA24135@dcvr.yhbt.net>
 <CAHrK+Z-uXAEgd_HuisbioO8=D7DEdmceeUEz3A1Jr_rtm7a3WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Barry Wardell <barry.wardell@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 02:27:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyBbZ-0004V8-DD
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 02:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744Ab3AXB11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 20:27:27 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:60819 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752299Ab3AXB1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 20:27:25 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02E9D44C001;
	Thu, 24 Jan 2013 01:27:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAHrK+Z-uXAEgd_HuisbioO8=D7DEdmceeUEz3A1Jr_rtm7a3WA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214381>

Barry Wardell <barry.wardell@gmail.com> wrote:
> On Wed, Jan 23, 2013 at 2:32 AM, Eric Wong <normalperson@yhbt.net> wrote:
> > Does squashing this on top of your changes fix all your failures?
> > I plan on squashing both your changes together with the below:
> 
> Yes, I can confirm that applying this patch on top of mine makes all
> git-svn tests pass again. I have also re-run the tests without my patch
> applied and found that they do all indeed pass, so I apologize for my
> previous incorrect comment.

Thanks, squashed, tested and pushed (have another unrelated patch coming)
