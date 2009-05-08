From: Miles Bader <miles@gnu.org>
Subject: Re: I want "fast forward my workdir to upstream if it's safe"
Date: Sat, 09 May 2009 06:34:55 +0900
Message-ID: <87iqkbth1c.fsf@catnip.gol.com>
References: <86prekfv7z.fsf@blue.stonehenge.com>
	<20090508023028.GA1218@coredump.intra.peff.net>
	<F871F2A1-DFCF-4642-BB53-7BE483A93271@orakel.ntnu.no>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
X-From: git-owner@vger.kernel.org Fri May 08 23:35:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2Xj5-0002J1-J0
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 23:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755030AbZEHVfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 17:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbZEHVfQ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 17:35:16 -0400
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:52364 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbZEHVfP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 17:35:15 -0400
Received: from 218.33.236.103.eo.eaccess.ne.jp ([218.33.236.103] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	id 1M2Xia-0003v0-TN; Sat, 09 May 2009 06:34:56 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id E5FAFDF70; Sat,  9 May 2009 06:34:55 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <F871F2A1-DFCF-4642-BB53-7BE483A93271@orakel.ntnu.no> (Eyvind
	Bernhardsen's message of "Fri, 8 May 2009 14:34:12 +0200")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118630>

Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no> writes:
> I read it as a request for pull/merge --ff-only (based on "abort if the
> workdir is dirty or is not a fast-forward update").  This feature  has
> been implemented twice, but never included:

I'd also like such a feature.

[It seems like such an obvious partner to "--no-ff" (etc), that it's
kind of surprising it isn't there already -- I think there have been
multiple times in the past where I've spent time grovelling the
pull/merge documentation looking for the right option name to do this,
only to give up in confusion when I couldn't find it...]

-Miles

-- 
Love is the difficult realization that something other than oneself is real.
[Iris Murdoch]
