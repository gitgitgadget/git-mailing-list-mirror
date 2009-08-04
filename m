From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: fix 'Use of uninitialized value' error in href()
Date: Tue, 04 Aug 2009 00:26:37 -0700
Message-ID: <7v4oso3uqa.fsf@alter.siamese.dyndns.org>
References: <200907310824.42953.jnareb@gmail.com>
 <1249022929-21037-1-git-send-email-giuseppe.bilotta@gmail.com>
 <200907311030.52643.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 09:26:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYEQ9-0004Q6-J4
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 09:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbZHDH0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 03:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbZHDH0r
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 03:26:47 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55483 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932517AbZHDH0p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 03:26:45 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E1B571C0FD;
	Tue,  4 Aug 2009 03:26:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 53F571C0F7; Tue,  4 Aug 2009
 03:26:38 -0400 (EDT)
In-Reply-To: <200907311030.52643.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri\, 31 Jul 2009 10\:30\:50 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2A48F776-80C8-11DE-916E-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124766>

Jakub Narebski <jnareb@gmail.com> writes:

> Acked-by: Jakub Narebski <jnareb@gmail.com>

Thanks, both.
