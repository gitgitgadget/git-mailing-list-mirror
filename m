From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Propagate -u/--upload-pack option of "git clone" to
 transport.
Date: Fri, 25 Jul 2008 14:48:01 -0700
Message-ID: <7vsktxr5ym.fsf@gitster.siamese.dyndns.org>
References: <1217008311-27916-1-git-send-email-shaslam@lastminute.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Steve Haslam <shaslam@lastminute.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 23:49:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMV9y-00015t-Mk
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 23:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbYGYVsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 17:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbYGYVsK
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 17:48:10 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40747 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbYGYVsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 17:48:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C51DB3CC22;
	Fri, 25 Jul 2008 17:48:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id ECA453CC21; Fri, 25 Jul 2008 17:48:03 -0400 (EDT)
In-Reply-To: <1217008311-27916-1-git-send-email-shaslam@lastminute.com>
 (Steve Haslam's message of "Fri, 25 Jul 2008 18:51:51 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5E318212-5A93-11DD-A7D3-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90123>

Looks correct; thanks.  
