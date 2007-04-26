From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 0/2] bookmarks (was: Re: git-fetch and unannotated tags)
Date: Thu, 26 Apr 2007 15:45:01 +0200
Message-ID: <20070426134501.GA3273@diana.vm.bytemark.co.uk>
References: <200704252004.45112.andyparkins@gmail.com> <200704252142.33756.andyparkins@gmail.com> <Pine.LNX.4.64.0704252332170.18446@beast.quantumfyre.co.uk> <200704260908.07108.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Julian Phillips <julian@quantumfyre.co.uk>,
	Junio C Hamano <junkio@cox.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 15:45:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hh4Hf-0001US-34
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 15:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754790AbXDZNpP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 26 Apr 2007 09:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754788AbXDZNpP
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 09:45:15 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3227 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754790AbXDZNpO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 09:45:14 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Hh4HO-0001CB-00; Thu, 26 Apr 2007 14:45:02 +0100
Content-Disposition: inline
In-Reply-To: <200704260908.07108.andyparkins@gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45635>

On 2007-04-26 09:08:06 +0100, Andy Parkins wrote:

> Maybe I'm missing the point - what do people see lightweight tags as
> useful for if not for marking revisions in a not-to-be-published
> fashion?

I agree. Lightweight tags intentionally lack all the information that
heavyweight tags have: committer/author, date, and log message. This
makes them quick and handy as a personal bookmarking system, but less
friendly for communication with others: all you have is the name. You
can't even know who created the tag, or when, or for what purpose,
unless it's all encoded it the tag name.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
