From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] Use parse_date_format() in revisions.c to parse the --date parameter
Date: Fri, 28 Sep 2007 11:11:06 -0700
Message-ID: <7v1wcipsn9.fsf@gitster.siamese.dyndns.org>
References: <200709281516.05438.andyparkins@gmail.com>
	<200709281517.32030.andyparkins@gmail.com>
	<Pine.LNX.4.64.0709281622240.28395@racer.site>
	<200709281900.25536.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 20:11:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbKJP-00050U-IU
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 20:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033AbXI1SLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 14:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753976AbXI1SLO
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 14:11:14 -0400
Received: from rune.pobox.com ([208.210.124.79]:58839 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753950AbXI1SLN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 14:11:13 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 6FFEF13DA10;
	Fri, 28 Sep 2007 14:11:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 6583B13DA0D;
	Fri, 28 Sep 2007 14:11:30 -0400 (EDT)
In-Reply-To: <200709281900.25536.andyparkins@gmail.com> (Andy Parkins's
	message of "Fri, 28 Sep 2007 19:00:23 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59415>

Andy Parkins <andyparkins@gmail.com> writes:

> On Friday 2007, September 28, Johannes Schindelin wrote:
>
>> Since this is really more like a code move, 1/4 and 2/4 should be
>> squashed.
>
> I have no problem with that.
>
> Junio: would you like a resend?

Sounds like a good plan.
