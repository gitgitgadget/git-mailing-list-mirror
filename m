From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] shortlog: do not require to run from inside a git
 repository
Date: Sat, 15 Mar 2008 20:55:56 -0700
Message-ID: <7vskyrl3ub.fsf@gitster.siamese.dyndns.org>
References: <20080314213524.GA10085@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Sun Mar 16 04:56:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JajzN-0000Wv-5Q
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 04:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175AbYCPD4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 23:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752134AbYCPD4G
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 23:56:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45473 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051AbYCPD4F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2008 23:56:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2B32A1A09;
	Sat, 15 Mar 2008 23:56:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4EDCB1A07; Sat, 15 Mar 2008 23:56:00 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77348>

Jonas Fonseca <fonseca@diku.dk> writes:

> Once upon a time shortlog could be run from a non-git directory
> and still do its job. Fix this regression and add a small test
> for it.

Nice regression fix.  Thanks.
