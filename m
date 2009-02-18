From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC 1/2] gitweb: Fix warnings with override permitted but
 no repo override
Date: Wed, 18 Feb 2009 11:02:42 -0800
Message-ID: <7vr61vwotp.fsf@gitster.siamese.dyndns.org>
References: <499AD871.8000808@oak.homeunix.org>
 <1234926043-7471-1-git-send-email-marcel@oak.homeunix.org>
 <7vvdr8yw78.fsf@gitster.siamese.dyndns.org>
 <200902181409.42407.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Marcel M. Cary" <marcel@oak.homeunix.org>, git@vger.kernel.org,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Francis Galiegue <fg@one2team.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 20:04:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZrik-0000nb-Mi
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 20:04:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545AbZBRTC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 14:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753484AbZBRTCz
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 14:02:55 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50102 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456AbZBRTCz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 14:02:55 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 655A09BC54;
	Wed, 18 Feb 2009 14:02:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1CFA49BC51; Wed,
 18 Feb 2009 14:02:43 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BE1286F0-FDEE-11DD-9D78-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110569>

Jakub Narebski <jnareb@gmail.com> writes:

> Fixed up patch at the bottom.

Thanks.
