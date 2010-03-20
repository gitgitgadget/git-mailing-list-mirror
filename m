From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] Add a git-completion rpm subpackage to the spec
Date: Sat, 20 Mar 2010 17:14:41 -0400
Message-ID: <1269119663-sup-5823@pinkfloyd.chass.utoronto.ca>
References: <1269045134-28072-1-git-send-email-icomfort@stanford.edu> <1269109086-8887-1-git-send-email-bwalton@artsci.utoronto.ca> <7v8w9mda6l.fsf@alter.siamese.dyndns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 22:14:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt60Z-00014k-4s
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 22:14:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750Ab0CTVOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 17:14:44 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:53720 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273Ab0CTVOn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 17:14:43 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:48120 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1Nt60H-0003kP-43; Sat, 20 Mar 2010 17:14:41 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Nt60H-0003Fz-39; Sat, 20 Mar 2010 17:14:41 -0400
In-reply-to: <7v8w9mda6l.fsf@alter.siamese.dyndns.org>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142755>

Excerpts from Junio C Hamano's message of Sat Mar 20 16:12:34 -0400 2010:

> looks sensible.  May I ask for what distribution you are "handling
> it"?  The last thing I want to do is to get in the way of distro
> packagers.

I can't say it's _the_ global definition for RPM based distros, but I
suspect the redhat derived ones would use this location.  I'm working
against RHEL5.

The info that Ian provides seems to corroborate this hypothesis.

HTH.
-Ben
-- 
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
