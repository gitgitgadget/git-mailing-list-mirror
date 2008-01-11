From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: Update and fix Makefile
Date: Fri, 11 Jan 2008 00:57:56 -0800
Message-ID: <7vk5mg3fjf.fsf@gitster.siamese.dyndns.org>
References: <200801082154.21282.stimming@tuhh.de>
	<7vk5mkq669.fsf@gitster.siamese.dyndns.org>
	<18308.17099.334609.80415@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Stimming <stimming@tuhh.de>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Jan 11 09:59:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDFjK-0003hU-8D
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 09:59:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757798AbYAKI6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 03:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756588AbYAKI6H
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 03:58:07 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55143 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757769AbYAKI6F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 03:58:05 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 14DF15C21;
	Fri, 11 Jan 2008 03:58:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 99F1C5C1F;
	Fri, 11 Jan 2008 03:57:58 -0500 (EST)
In-Reply-To: <18308.17099.334609.80415@cargo.ozlabs.ibm.com> (Paul Mackerras's
	message of "Wed, 9 Jan 2008 14:43:07 +1100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70139>

I applied three patches since last pull from you and pushed the
result (pure gitk part) out in gitk branch:

	master.kernel.org:/pub/scm/git/git.git/ gitk

Could you please pull?
