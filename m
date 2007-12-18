From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch: Remove broken and unnecessary summary of rewritten refs.
Date: Tue, 18 Dec 2007 01:56:18 -0800
Message-ID: <7vejdk1g3h.fsf@gitster.siamese.dyndns.org>
References: <1197963047-15930-1-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Tue Dec 18 10:57:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4ZC6-0007md-Sq
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 10:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064AbXLRJ4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 04:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753013AbXLRJ4f
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 04:56:35 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57235 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865AbXLRJ4e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 04:56:34 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DF22154C9;
	Tue, 18 Dec 2007 04:56:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6932654C8;
	Tue, 18 Dec 2007 04:56:25 -0500 (EST)
In-Reply-To: <1197963047-15930-1-git-send-email-johannes.sixt@telecom.at>
	(Johannes Sixt's message of "Tue, 18 Dec 2007 08:30:47 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68722>

Sounds sensible.  Applied.
