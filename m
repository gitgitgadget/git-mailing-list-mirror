From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] builtin-mv.c: check for unversionned files before
 looking at the destination.
Date: Wed, 04 Feb 2009 12:54:19 -0800
Message-ID: <7vocxhord0.fsf@gitster.siamese.dyndns.org>
References: <1233739928-19895-1-git-send-email-Matthieu.Moy@imag.fr>
 <1233739928-19895-2-git-send-email-Matthieu.Moy@imag.fr>
 <1233739928-19895-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Feb 04 21:55:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUomn-0008Bf-5U
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 21:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758636AbZBDUy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 15:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758062AbZBDUy0
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 15:54:26 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43895 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757746AbZBDUy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 15:54:26 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8AC1C2A713;
	Wed,  4 Feb 2009 15:54:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D270B2A710; Wed, 
 4 Feb 2009 15:54:20 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 01B963D4-F2FE-11DD-AD3A-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108433>

Makes sense; thanks.
