From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: use href() when generating URLs in OPML
Date: Tue, 06 Jan 2009 00:17:43 -0800
Message-ID: <7vaba4n908.fsf@gitster.siamese.dyndns.org>
References: <1230898528-24187-1-git-send-email-giuseppe.bilotta@gmail.com>
 <200901021409.07695.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 09:19:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK79f-0007SL-RT
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 09:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbZAFIRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 03:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbZAFIRx
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 03:17:53 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42193 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbZAFIRw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 03:17:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B49861BE91;
	Tue,  6 Jan 2009 03:17:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 113A61BE89; Tue, 
 6 Jan 2009 03:17:45 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 82EA99D2-DBCA-11DD-BAA3-EB51113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104645>

Thanks, both; applied.
