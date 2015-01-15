From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PULL] git-svn updates from Ramkumar
Date: Thu, 15 Jan 2015 22:46:52 +0000
Message-ID: <20150115224652.GA25482@dcvr.yhbt.net>
References: <20150115090703.GA12333@dcvr.yhbt.net>
 <xmqqr3uv7u7v.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 23:46:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBtBp-0002Au-0X
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 23:46:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020AbbAOWqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 17:46:53 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:44973 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753176AbbAOWqw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 17:46:52 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A0CF1F453;
	Thu, 15 Jan 2015 22:46:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqr3uv7u7v.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262519>

Junio C Hamano <gitster@pobox.com> wrote:
> Thanks.  No tests necessary/feasible?  Just being curious.

They seemed simple and obvious enough to me,
(and most importantly, didn't trigger regressions).
If Ramkumar or anybody else has the time, I'd welcome them.
