From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-apply doesn't handle same name patches well [V4]
Date: Fri, 27 Jun 2008 17:06:03 -0700
Message-ID: <7v63rumnis.fsf@gitster.siamese.dyndns.org>
References: <1214591952-3763-1-git-send-email-dzickus@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Don Zickus <dzickus@redhat.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 02:07:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCNyF-0004Xp-RG
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 02:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757560AbYF1AGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 20:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756742AbYF1AGJ
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 20:06:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62955 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756892AbYF1AGI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 20:06:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E28C3ED45;
	Fri, 27 Jun 2008 20:06:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5CC53ED44; Fri, 27 Jun 2008 20:06:05 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 01F6192A-44A6-11DD-8F18-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86683>

Thanks.  Looks much better.  Will queue.
