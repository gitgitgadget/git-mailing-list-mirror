From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix "git log --diff-filter" bug
Date: Wed, 26 Dec 2007 11:41:07 -0800
Message-ID: <7vve6lmegc.fsf@gitster.siamese.dyndns.org>
References: <1198580807-18802-1-git-send-email-arjen@yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Arjen Laarhoven <arjen@yaph.org>
X-From: git-owner@vger.kernel.org Wed Dec 26 20:41:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J7c8I-0005cF-Pz
	for gcvg-git-2@gmane.org; Wed, 26 Dec 2007 20:41:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbXLZTlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2007 14:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbXLZTlO
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Dec 2007 14:41:14 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55511 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514AbXLZTlN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2007 14:41:13 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E1944039;
	Wed, 26 Dec 2007 14:41:12 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C35774038;
	Wed, 26 Dec 2007 14:41:09 -0500 (EST)
In-Reply-To: <1198580807-18802-1-git-send-email-arjen@yaph.org> (Arjen
	Laarhoven's message of "Tue, 25 Dec 2007 12:06:47 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69245>

Thanks.  Some tests?
