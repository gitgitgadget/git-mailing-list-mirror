From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-apply: fix typo leading to stack corruption
Date: Thu, 09 Oct 2008 05:51:37 -0700
Message-ID: <7v4p3mors6.fsf@gitster.siamese.dyndns.org>
References: <48ed30f5.0707d00a.2994.6f1e@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Imre Deak <imre.deak@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 14:53:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Knv0k-0003Gh-Ds
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 14:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754383AbYJIMvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 08:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754681AbYJIMvr
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 08:51:47 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56901 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754334AbYJIMvr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 08:51:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 17A0988A5F;
	Thu,  9 Oct 2008 08:51:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 43F7288A5D; Thu,  9 Oct 2008 08:51:41 -0400 (EDT)
In-Reply-To: <48ed30f5.0707d00a.2994.6f1e@mx.google.com> (Imre Deak's message
 of "Thu, 9 Oct 2008 00:24:16 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 08638DB8-9601-11DD-AD44-FA2D76724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97848>

Looks good and would look better with a sign-off.
