From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: Update and fix Makefile
Date: Fri, 11 Jan 2008 01:06:08 -0800
Message-ID: <7vfxx43f5r.fsf@gitster.siamese.dyndns.org>
References: <200801082154.21282.stimming@tuhh.de>
	<7vk5mkq669.fsf@gitster.siamese.dyndns.org>
	<18308.17099.334609.80415@cargo.ozlabs.ibm.com>
	<7vk5mg3fjf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Stimming <stimming@tuhh.de>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Jan 11 10:07:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDFqt-0005qV-IL
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 10:06:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491AbYAKJGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 04:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755823AbYAKJGS
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 04:06:18 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55649 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755318AbYAKJGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 04:06:16 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A1F8E5CCE;
	Fri, 11 Jan 2008 04:06:14 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 19F275CCD;
	Fri, 11 Jan 2008 04:06:09 -0500 (EST)
In-Reply-To: <7vk5mg3fjf.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 11 Jan 2008 00:57:56 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70140>

Junio C Hamano <gitster@pobox.com> writes:

> I applied three patches since last pull from you and pushed the
> result (pure gitk part) out in gitk branch:
>
> 	master.kernel.org:/pub/scm/git/git.git/ gitk
>
> Could you please pull?

Sorry, this was a very ill-behaved pull request.  The patches
picked up from the list I applied are these three:

Charles Bailey (1):
      gitk: Fix the Makefile to cope with systems lacking msgfmt

Christian Stimming (2):
      gitk: Fix typo in user message.
      gitk: Update German translation.
