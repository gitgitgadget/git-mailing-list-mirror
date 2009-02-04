From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-push: add back underscore separator before lock
 token
Date: Tue, 03 Feb 2009 23:47:34 -0800
Message-ID: <7vskmu3ap5.fsf@gitster.siamese.dyndns.org>
References: <4988418E.4000808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 08:49:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUcVR-0003J4-Fu
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 08:49:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735AbZBDHrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 02:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbZBDHrj
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 02:47:39 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56388 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbZBDHri (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 02:47:38 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5F92F2A67F;
	Wed,  4 Feb 2009 02:47:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C11C82A67B; Wed, 
 4 Feb 2009 02:47:35 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 180DDC6E-F290-11DD-B18A-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108306>

Thanks; I should have caught it while reviewing.
