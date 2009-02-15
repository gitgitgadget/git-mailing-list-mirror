From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rerere: remove duplicated functions
Date: Sun, 15 Feb 2009 11:33:45 -0800
Message-ID: <7vk57rlckm.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0902141944030.10279@pacific.mpi-cbg.de>
 <1234650064-639-1-git-send-email-szeder@ira.uka.de>
 <alpine.DEB.1.00.0902142327520.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 15 20:35:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYmm0-00062U-GE
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 20:35:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbZBOTdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 14:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbZBOTdv
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 14:33:51 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46765 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbZBOTdv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 14:33:51 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DA5BC2B331;
	Sun, 15 Feb 2009 14:33:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 293D82B32D; Sun,
 15 Feb 2009 14:33:46 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9293E680-FB97-11DD-856E-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110037>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Thanks.  As I started that code in C, I dare say "ACK" here :-)

Thanks, both.
