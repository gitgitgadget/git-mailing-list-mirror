From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH (resend)] gitweb: Use feed link according to current view
Date: Tue, 22 Apr 2008 22:18:08 -0700
Message-ID: <7v63u9up2n.fsf@gitster.siamese.dyndns.org>
References: <200804202209.49980.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Jean-Baptiste Quenot" <jbq@caraldi.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 07:19:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoXOA-00055Z-IO
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 07:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbYDWFSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 01:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbYDWFSY
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 01:18:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34302 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbYDWFSY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 01:18:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C58532D57;
	Wed, 23 Apr 2008 01:18:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A7C042D56; Wed, 23 Apr 2008 01:18:17 -0400 (EDT)
In-Reply-To: <200804202209.49980.jnareb@gmail.com> (Jakub Narebski's message
 of "Sun, 20 Apr 2008 22:09:48 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80187>

Jakub Narebski <jnareb@gmail.com> writes:

> The only difference is that 'generic' links to feeds in footer are
> shown in slightly lighter color, to better distinguish situation
> when they refer to alternate version of the page, and when they refer
> to generic feed for given project.
>
> Comments?

This surely is elaborate.  Will queue.
