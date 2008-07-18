From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Suggestion: doc restructuring
Date: Fri, 18 Jul 2008 12:50:16 -0700
Message-ID: <7v3am76kg7.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
 <48806D03.30603@fastmail.fm> <4880E041.8070001@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>,
	git@vger.kernel.org
To: Jon Loeliger <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 21:51:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJvzH-0005yy-3Z
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 21:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754576AbYGRTu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 15:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754564AbYGRTu0
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 15:50:26 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58849 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427AbYGRTuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 15:50:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1378531758;
	Fri, 18 Jul 2008 15:50:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 419DB31757; Fri, 18 Jul 2008 15:50:18 -0400 (EDT)
In-Reply-To: <4880E041.8070001@freescale.com> (Jon Loeliger's message of
 "Fri, 18 Jul 2008 13:26:09 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C2FDB10C-5502-11DD-84C9-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89075>

Jon Loeliger <jdl@freescale.com> writes:

> The current sub-setting and organization is painful because
> it doesn't have a comprehensive, linear, alphabetized list
> of commands from which to select the real man page.  I never
> know which "section" to find a given command.  Is it an
> Ancillary "manipulator" command?  Or maybe just a "Manipulation"
> command, or maybe an "Interrogation" command?  A "Helper"?
>
> I always have to painfully search the page for it instead.

When you are on-line (like your case to read kernel.org webpage), it is
rather easy with ^F (or whatever browser you use lets you search).

But I do agree with you that on printed medium we would want a nice
alphabetized list somewhere.
