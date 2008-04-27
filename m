From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2.2] Teach rebase interactive the mark command
Date: Sat, 26 Apr 2008 23:13:42 -0700
Message-ID: <7vej8rj04p.fsf@gitster.siamese.dyndns.org>
References: <20080425091117.GA23726@alea.gnuu.de>
 <1209116688-12266-1-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Sun Apr 27 08:15:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq0Ac-0001Qg-L9
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 08:15:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525AbYD0GOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 02:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbYD0GOo
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 02:14:44 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61801 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837AbYD0GOn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 02:14:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BC25B4F38;
	Sun, 27 Apr 2008 02:13:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C1C8C4F35; Sun, 27 Apr 2008 02:13:46 -0400 (EDT)
In-Reply-To: <1209116688-12266-1-git-send-email-joerg@alea.gnuu.de>
 (=?utf-8?Q?J=C3=B6rg?= Sommer's message of "Fri, 25 Apr 2008 11:44:48 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80417>

Thanks; as I already queued the series to 'next', I took the liberty of
applying the interdiff as a separate fix-up/improvement commit to the tip
of the topic.
