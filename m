From: Junio C Hamano <gitster@pobox.com>
Subject: No -rc3 today
Date: Sun, 10 Aug 2008 15:37:44 -0700
Message-ID: <7vzlnkzebr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 11 00:38:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSJYr-0003Gf-3Y
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 00:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492AbYHJWhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 18:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753532AbYHJWhv
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 18:37:51 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48605 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058AbYHJWhv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 18:37:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2EAC454D24;
	Sun, 10 Aug 2008 18:37:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8EF8B54D23; Sun, 10 Aug 2008 18:37:46 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F53F3136-672C-11DD-A6BA-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91895>

I seem to have hurt my back and won't be functional for the rest of the
day, so if anybody is wondring why -rc3 does not appear, nor any patch
being commented much, the reason is simply because I am taking a day off,
not because your patches are wrong or anything.

I liked the general idea of patches from Miklos (merge-recursive),
appreciate efforts by Thomas to clarify the semantics of history
simplification with various options, diff-tree --stdin update from Karl,
Mark's "submodule foreach", Peter's "log --check" exit code work, and p4
update from Anand.

But I haven't looked at any of them beyond their descriptions. Sorry about
that.  Hopefully competent people other than myself can still comment on
them and keep the discussion going and patches getting polished.
