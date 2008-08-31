From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] fixup_pack_header_footer(): use nicely aligned
 buffer sizes
Date: Sun, 31 Aug 2008 00:10:37 -0700
Message-ID: <7v7i9xd5hu.fsf@gitster.siamese.dyndns.org>
References: <20080829143023.GA7403@spearce.org>
 <1220040482-10108-1-git-send-email-nico@cam.org>
 <1220040482-10108-2-git-send-email-nico@cam.org>
 <1220040482-10108-3-git-send-email-nico@cam.org>
 <1220040482-10108-4-git-send-email-nico@cam.org>
 <1220040482-10108-5-git-send-email-nico@cam.org>
 <1220040482-10108-6-git-send-email-nico@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Aug 31 09:12:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZh6f-0002QB-PB
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 09:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbYHaHKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 03:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752729AbYHaHKw
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 03:10:52 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36641 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752717AbYHaHKv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 03:10:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9B1E06EDE3;
	Sun, 31 Aug 2008 03:10:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 25EFF6EDE2; Sun, 31 Aug 2008 03:10:42 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EF705528-772B-11DD-976D-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94458>

Thanks -- it was a very good read.  I wish every series I receive is
clearly done like this one.

Queued for 'next'.
