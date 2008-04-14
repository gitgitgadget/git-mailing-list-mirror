From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH 3/2] bisect: add "stop", "show" and "restart" as synonyms
 for other commands
Date: Mon, 14 Apr 2008 16:23:36 -0700
Message-ID: <7vej9881hj.fsf@gitster.siamese.dyndns.org>
References: <20080414061627.62119f74.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Apr 15 01:24:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlY2H-0008Bi-9b
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 01:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755814AbYDNXXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 19:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755748AbYDNXXo
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 19:23:44 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42755 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753778AbYDNXXo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 19:23:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8C23A3936;
	Mon, 14 Apr 2008 19:23:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E84363935; Mon, 14 Apr 2008 19:23:38 -0400 (EDT)
In-Reply-To: <20080414061627.62119f74.chriscool@tuxfamily.org> (Christian
 Couder's message of "Mon, 14 Apr 2008 06:16:27 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79539>

Christian Couder <chriscool@tuxfamily.org> writes:

> This patch adds the following synonyms:
>
> 	- "show" for "visualize",
> 	- "stop" for "reset",
> 	- "restart" for "start",
>
> as suggested by Ingo Molnar.

Hmmm.  I sympathize with "show", only because there are other places we
already use "show" and also "visualize" is too long to type, but "stop"
and "restart"?
