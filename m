From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: config: add 'help.*' and 'instaweb.*' variables.
Date: Mon, 07 Jan 2008 23:40:57 -0800
Message-ID: <7vabngwyra.fsf@gitster.siamese.dyndns.org>
References: <20080108045514.1a506761.chriscool@tuxfamily.org>
	<7vmyrgx26h.fsf@gitster.siamese.dyndns.org>
	<200801080843.35693.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jan 08 08:41:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JC95f-000399-Ev
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 08:41:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989AbYAHHlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 02:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbYAHHlN
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 02:41:13 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37940 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbYAHHlM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 02:41:12 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A422F3834;
	Tue,  8 Jan 2008 02:41:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 612273831;
	Tue,  8 Jan 2008 02:41:06 -0500 (EST)
In-Reply-To: <200801080843.35693.chriscool@tuxfamily.org> (Christian Couder's
	message of "Tue, 8 Jan 2008 08:43:35 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69847>

Christian Couder <chriscool@tuxfamily.org> writes:

> By the way I had no comment on my RFC/Patch to run the test scripts under 
> valgrind. Maybe it's useless because it doesn't find any bug right now.

I found it interesting myself.  I did not know how well it fits
into the rest of the testing infrastructure, though.  Perhaps
you would want to reopen the issue after 1.5.4?
