From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rev-parse doesn't take pwd into consideration
Date: Mon, 26 May 2008 13:15:44 -0700
Message-ID: <7vhcckddov.fsf@gitster.siamese.dyndns.org>
References: <20080526195812.GA23396@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luciano Rocha <luciano@eurotux.com>
X-From: git-owner@vger.kernel.org Mon May 26 22:17:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0j8B-0002X3-D3
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 22:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755012AbYEZUP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 16:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755024AbYEZUP6
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 16:15:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53388 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754944AbYEZUP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 16:15:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 69B224128;
	Mon, 26 May 2008 16:15:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E36314127; Mon, 26 May 2008 16:15:51 -0400 (EDT)
In-Reply-To: <20080526195812.GA23396@bit.office.eurotux.com> (Luciano Rocha's
 message of "Mon, 26 May 2008 20:58:12 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8C732A20-2B60-11DD-9CE9-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82951>

This was discussed to death.  Check the list archive.
