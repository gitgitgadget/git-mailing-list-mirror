From: Junio C Hamano <gitster@pobox.com>
Subject: Re: feature request: git-log should accept sth like v2.6.26-rc8-227
Date: Thu, 10 Jul 2008 13:03:39 -0700
Message-ID: <7v8ww9pkv8.fsf@gitster.siamese.dyndns.org>
References: <200807102057.15063.toralf.foerster@gmx.de>
 <7vk5ftpnek.fsf@gitster.siamese.dyndns.org>
 <m3d4lledbn.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 22:04:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH2Nm-0003PR-9y
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 22:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753679AbYGJUDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 16:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753173AbYGJUDu
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 16:03:50 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37445 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbYGJUDt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 16:03:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B597F26051;
	Thu, 10 Jul 2008 16:03:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5208D2604F; Thu, 10 Jul 2008 16:03:42 -0400 (EDT)
In-Reply-To: <m3d4lledbn.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Thu, 10 Jul 2008 12:42:53 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4F4DA638-4EBB-11DD-BF5E-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88004>

Jakub Narebski <jnareb@gmail.com> writes:

> Besides, it would be nice to have some command (git-rev-parse perhaps?)
> which could take ambiguous commit-ish, and list all commit which matches
> it.

Have fun writing it and send in a patch.
