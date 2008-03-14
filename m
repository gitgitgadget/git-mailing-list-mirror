From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-recursive: handle file mode changes
Date: Thu, 13 Mar 2008 17:12:39 -0700
Message-ID: <7vabl2w4co.fsf@gitster.siamese.dyndns.org>
References: <20080308171726.GA16129@localhost>
 <alpine.LSU.1.00.0803081850470.3975@racer.site>
 <20080313125229.GA24758@localhost>
 <alpine.LSU.1.00.0803131607030.1656@racer.site>
 <20080313192246.GA30361@localhost>
 <alpine.LSU.1.00.0803132216580.4174@racer.site>
 <20080313224741.GA5000@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 14 01:13:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZxYB-0004op-SI
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 01:13:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757948AbYCNAMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 20:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757976AbYCNAMx
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 20:12:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62300 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757823AbYCNAMw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 20:12:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B66D21F41;
	Thu, 13 Mar 2008 20:12:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 16C121F34; Thu, 13 Mar 2008 20:12:46 -0400 (EDT)
In-Reply-To: <20080313224741.GA5000@localhost> (Clemens Buchacher's message
 of "Thu, 13 Mar 2008 23:47:41 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77154>

Clemens Buchacher <drizzd@aon.at> writes:

> I am not exactly sure how I should set the result.merge flag. In this context
> it seems to have the exact opposite meaning of result.clean. Is that correct?

This is from the e-mail header of your message:

  Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
   git@vger.kernel.org, gitster@pobox.com

If you are asking people question, do not do this.  You want answers
addressed to you.  Johannes and I may not be interested in learning what
may want to find out, and redirecting answers for you to us is simply
rude.
