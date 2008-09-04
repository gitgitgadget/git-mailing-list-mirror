From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Are more and more patches getting lost lately?
Date: Thu, 04 Sep 2008 11:58:17 -0500
Message-ID: <ObDEE9pHJBkHrQ4N4qnEBC8w3yS7pvHq120vg-lqf6mfgacXT7fRBg@cipher.nrlssc.navy.mil>
References: <20080904083343.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 19:01:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbIC2-0000yz-7X
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 19:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105AbYIDQ7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 12:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753113AbYIDQ7S
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 12:59:18 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:42703 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753095AbYIDQ7S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 12:59:18 -0400
Received: by mail.nrlssc.navy.mil id m84GwIDJ001218; Thu, 4 Sep 2008 11:58:18 -0500
In-Reply-To: <20080904083343.6117@nanako3.lavabit.com>
X-OriginalArrivalTime: 04 Sep 2008 16:58:17.0852 (UTC) FILETIME=[6DA75BC0:01C90EAF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94941>

Nanako Shiraishi wrote:
> I noticed that recently there are many patches sent to the list
> that are left unapplied (and many of them are from you).  Many
> of them look useful or at least promising to become useful.

> From: Brandon Casey <casey@nrlssc.navy.mil>
> Subject: [PATCH] t9301-fast-export: move unset of config variable into its own test function
> Date: Thu, 21 Aug 2008 19:48:49 -0500
> Message-ID: <ZdQ6b4vecqtrZ-7Mze6M9UBwrI9qQRUu-BoApXUv0v2zM76stzXd3w@cipher.nrlssc.navy.mil>
> 
> http://article.gmane.org/gmane.comp.version-control.git/93239

For this one, Junio suggested an alternative for skipping a "class" of tests which I
have not followed up on. His solution needs to be tested, and the test scripts would
need to be marked with class identifiers.

-brandon
