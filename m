From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] clone: Add an option to set up a mirror
Date: Sat, 02 Aug 2008 13:46:26 -0700
Message-ID: <7vd4krdu1p.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0808011600170.9611@pacific.mpi-cbg.de.mpi-cbg.de>
 <7vr697l01j.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0808022126270.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 02 22:47:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPO0j-0002ee-ET
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 22:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbYHBUqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 16:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbYHBUqc
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 16:46:32 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45560 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbYHBUqb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 16:46:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E8C3148EA6;
	Sat,  2 Aug 2008 16:46:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3CF1548EA5; Sat,  2 Aug 2008 16:46:27 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0808022126270.9611@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Sat, 2 Aug 2008 21:38:56 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 16003442-60D4-11DD-BAC1-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91175>

Thanks for a quick turnaround.
