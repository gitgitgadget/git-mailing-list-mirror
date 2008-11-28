From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: fix keyword-expansion regex
Date: Fri, 28 Nov 2008 14:29:27 -0800
Message-ID: <7vy6z37ad4.fsf@gitster.siamese.dyndns.org>
References: <20081126185215.GA11037@osc.edu>
 <7vljv6fcr0.fsf@gitster.siamese.dyndns.org> <200811271745.30963.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Fri Nov 28 23:31:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6Bri-0005Fr-3b
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 23:31:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbYK1W3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 17:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752177AbYK1W3x
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 17:29:53 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51048 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168AbYK1W3x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2008 17:29:53 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BE9BC8270C;
	Fri, 28 Nov 2008 17:29:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9C9428270B; Fri,
 28 Nov 2008 17:29:28 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1220E87E-BD9C-11DD-8A42-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101888>

Simon Hausmann <simon@lst.de> writes:

> On Wednesday 26 November 2008 Junio C Hamano, wrote:
>> I will queue this to 'pu' and wait for an Ack from git-p4 folks.   Thanks.
>
> Acked-by: Simon Hausmann <simon@lst.de>

Thanks.
