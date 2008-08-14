From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-parse-options: use appropriate cast in
 length_callback
Date: Wed, 13 Aug 2008 18:11:31 -0700
Message-ID: <7v1w0sienw.fsf@gitster.siamese.dyndns.org>
References: <u9kSfvaPV5O7E74203zUsAGug_d6ifoE65miBrOTQbXuuqogK67SOA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Aug 14 03:12:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTROJ-00071I-T7
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 03:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754996AbYHNBLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 21:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755003AbYHNBLh
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 21:11:37 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61659 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754996AbYHNBLg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 21:11:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2ECFD58D26;
	Wed, 13 Aug 2008 21:11:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 81ABA58D25; Wed, 13 Aug 2008 21:11:33 -0400 (EDT)
In-Reply-To: <u9kSfvaPV5O7E74203zUsAGug_d6ifoE65miBrOTQbXuuqogK67SOA@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Wed, 13 Aug 2008 19:48:57 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F0CD7464-699D-11DD-8E97-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92304>

Good eyes.  Thanks.
