From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Aug 2008, #04; Tue, 19)
Date: Tue, 19 Aug 2008 02:05:37 -0700
Message-ID: <7vvdxxcr32.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 11:10:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVNAu-0003zB-7z
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 11:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671AbYHSJFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 05:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752207AbYHSJFp
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 05:05:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49372 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbYHSJFo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 05:05:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 379EE5A73F;
	Tue, 19 Aug 2008 05:05:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7BF095A73E; Tue, 19 Aug 2008 05:05:40 -0400 (EDT)
X-maint-at: 26e08a0190cb3354e43bab13ea693a5c826a8fe1
X-master-at: c6670b348cb19c74a6d7f6943df4871eb0d8295f
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 00074EE4-6DCE-11DD-A918-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92839>

* The 'maint' branch has these fixes since 1.6.0.

Brandon Casey (1):
  t1002-read-tree-m-u-2way.sh: use 'git diff -U0' rather than 'diff -U0'

Don Zickus (1):
  mailinfo: re-fix MIME multipart boundary parsing

Robert Schiele (1):
  adapt git-cvsserver manpage to dash-free syntax
