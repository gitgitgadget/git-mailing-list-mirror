From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Patch for git-svn.perl
Date: Sat, 06 Sep 2008 19:18:40 -0700
Message-ID: <7vfxocr94v.fsf@gitster.siamese.dyndns.org>
References: <257934.40788.qm@web27803.mail.ukl.yahoo.com>
 <20080907020307.GA12234@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: brad.king@kitware.com, git@vger.kernel.org,
	Paul Talacko <gnuruandstuff@yahoo.co.uk>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Sep 07 04:21:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kc9tZ-0002cD-8r
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 04:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753055AbYIGCSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 22:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752998AbYIGCSv
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 22:18:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45256 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404AbYIGCSu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 22:18:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 668CA5F530;
	Sat,  6 Sep 2008 22:18:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9CC3A5F52C; Sat,  6 Sep 2008 22:18:43 -0400 (EDT)
In-Reply-To: <20080907020307.GA12234@untitled> (Eric Wong's message of "Sat,
 6 Sep 2008 19:03:16 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4E1CEB66-7C83-11DD-AE51-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95102>

Eric Wong <normalperson@yhbt.net> writes:

> Junio,
>
> I've rebased against 80d12c2 and repushed out to
> git://git.bogomips.org/git-svn.git along with the following changes:

Thanks.  I'll be pulling from you, Paul and Shawn for subsystem updates
this weekend.
