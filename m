From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] provide advance warning of some future pack default changes
Date: Thu, 13 Dec 2007 21:19:18 -0800
Message-ID: <7vir31x38p.fsf@gitster.siamese.dyndns.org>
References: <7vk5nwu51x.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.99999.0712031258460.9605@xanadu.home>
	<7vsl2jh3rb.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999999.0712132227090.8467@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Dec 14 06:19:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J32xk-0005W8-Hb
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 06:19:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbXLNFTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 00:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbXLNFTa
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 00:19:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56605 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbXLNFT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 00:19:29 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 334A0890D;
	Fri, 14 Dec 2007 00:19:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C6D3D890C;
	Fri, 14 Dec 2007 00:19:20 -0500 (EST)
In-Reply-To: <alpine.LFD.0.999999.0712132227090.8467@xanadu.home> (Nicolas
	Pitre's message of "Thu, 13 Dec 2007 22:32:36 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68225>

Thanks.

Deprecating versions before 1.5.2 (May 20 2007) feels a bit too quick,
but seven month is almost an eternity in git timescale, and by now
anything older than 1.5.2 can safely be called prehistoric.  Will apply.
