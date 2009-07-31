From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3 v3] Make git builtins not link against libcurl
Date: Fri, 31 Jul 2009 09:19:45 -0700
Message-ID: <7vk51ou8ny.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0907310054570.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Jul 31 18:19:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWupr-0007OB-4M
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 18:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbZGaQTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 12:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbZGaQTw
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 12:19:52 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50009 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbZGaQTv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 12:19:51 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C0F331B9A1;
	Fri, 31 Jul 2009 12:19:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BF0E41B9A0; Fri,
 31 Jul 2009 12:19:46 -0400 (EDT)
In-Reply-To: <alpine.LNX.2.00.0907310054570.2147@iabervon.org> (Daniel
 Barkalow's message of "Fri\, 31 Jul 2009 01\:26\:35 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F9AF3B66-7DED-11DE-B8F8-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124576>

diff -M tells me that this is a general code clean-up with s/shim/remote/
that I can agree with ;-)

Thanks; will queue.
