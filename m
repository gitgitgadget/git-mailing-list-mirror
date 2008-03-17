From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-0.10
Date: Mon, 17 Mar 2008 11:23:18 +0100
Message-ID: <20080317102318.GA6830@diku.dk>
References: <20080317020304.GA19249@diku.dk> <7vr6e9bvuu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 11:24:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbCVd-0004mc-6f
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 11:24:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428AbYCQKXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 06:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752114AbYCQKXV
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 06:23:21 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:57746 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752428AbYCQKXV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 06:23:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id C6DC919BB3A;
	Mon, 17 Mar 2008 11:23:19 +0100 (CET)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 13621-01; Mon, 17 Mar 2008 11:23:18 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 9ED1419BB38;
	Mon, 17 Mar 2008 11:23:18 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id E65136DF894; Mon, 17 Mar 2008 11:22:26 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 87F1D1DC4B6; Mon, 17 Mar 2008 11:23:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vr6e9bvuu.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77423>

Junio C Hamano <gitster@pobox.com> wrote Mon, Mar 17, 2008:
> Jonas Fonseca <fonseca@diku.dk> writes:
> 
> > ... Building the documentation
> > (sadly?) now depends on DocBook XSL 1.72 to reduce the number of
> > accumulated AsciiDoc and XSL hacks.
> 
> Well, I've been a quiet but big fan of tig for quite some time, but to me,
> requiring autoreconf is a much larger regression than DocBook dependency.

I am not sure I understand. As far as I know, tig does not require
autoreconf unless you have cloned the repository and want to bootstrap
the configure script.

-- 
Jonas Fonseca
