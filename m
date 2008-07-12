From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix backwards-incompatible handling of
 core.sharedRepository
Date: Fri, 11 Jul 2008 20:44:10 -0700
Message-ID: <7vprpjhilx.fsf@gitster.siamese.dyndns.org>
References: <20080710231853.21448.18643.stgit@rover.dkm.cz>
 <7vr6a1mhqi.fsf@gitster.siamese.dyndns.org>
 <7vr6a1kmpq.fsf@gitster.siamese.dyndns.org>
 <20080711150707.GE32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Jul 12 05:45:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHW2y-0006Ey-2a
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 05:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752931AbYGLDoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 23:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752800AbYGLDoR
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 23:44:17 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41955 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584AbYGLDoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 23:44:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CB9D727AF7;
	Fri, 11 Jul 2008 23:44:15 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D647227AF5; Fri, 11 Jul 2008 23:44:12 -0400 (EDT)
In-Reply-To: <20080711150707.GE32184@machine.or.cz> (Petr Baudis's message of
 "Fri, 11 Jul 2008 17:07:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CCBEF3D8-4FC4-11DD-A5E9-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88219>

Thanks.  Queued on 'maint'.
