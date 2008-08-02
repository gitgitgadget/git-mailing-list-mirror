From: Junio C Hamano <gitster@pobox.com>
Subject: gitweb status for 1.6.0?
Date: Sat, 02 Aug 2008 14:28:27 -0700
Message-ID: <7vvdyjcdj8.fsf@gitster.siamese.dyndns.org>
References: <20080802211714.GG24723@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Aug 02 23:29:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPOfS-0006ep-Ea
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 23:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997AbYHBV2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 17:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751942AbYHBV2g
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 17:28:36 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49132 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbYHBV2f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 17:28:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7F8A547231;
	Sat,  2 Aug 2008 17:28:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 500C247230; Sat,  2 Aug 2008 17:28:29 -0400 (EDT)
In-Reply-To: <20080802211714.GG24723@spearce.org> (Shawn O. Pearce's message
 of "Sat, 2 Aug 2008 14:17:14 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F6298096-60D9-11DD-B052-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91186>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> We're getting ready for the git 1.6 release in the not-too-distant
> future, and that will ship with gitgui-0.11.

Thanks.

There have been a handful gitweb patches on the list recently (I think
they were all post -rc0 feature enhancements, but I may be mistaken).  I'm
wondering what their status are.  Does any of them matter in the current
cycle?

By the way, I've privately pinged Paul for gitk status.
