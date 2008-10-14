From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Oct 2008, #03; Tue, 14)
Date: Tue, 14 Oct 2008 15:08:50 -0700
Message-ID: <7vej2i7rt9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 15 00:10:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kps5j-0005PY-K5
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 00:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347AbYJNWI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 18:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752242AbYJNWI4
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 18:08:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52284 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbYJNWI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 18:08:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 06D646EA60;
	Tue, 14 Oct 2008 18:08:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 590066EA5F; Tue, 14 Oct 2008 18:08:52 -0400 (EDT)
X-maint-at: 6c1679254cb6be7b268d1431595e1626bf18792d
X-master-at: 67faaaba8338cf59c212ce5239eeb223a77acdf0
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B10D9460-9A3C-11DD-9839-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98215>

Just trying to get my development repository back in sync with what I
received from Shawn.  Thanks to everybody, I think maint is ready for
1.6.0.3.

* The 'maint' branch has these fixes since the last announcement.

Junio C Hamano (1):
  Update draft release notes to 1.6.0.3


* The 'master' branch has these since the last announcement
  in addition to the above.

Jeff King (1):
  tests: shell negation portability fix

Junio C Hamano (1):
  Update draft release notes to 1.6.1
