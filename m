From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make reflog query '@{1219188291}' act as '@{2008/08/19
 16:24:51}'
Date: Wed, 20 Aug 2008 15:20:54 -0700
Message-ID: <7vhc9fnxa1.fsf@gitster.siamese.dyndns.org>
References: <20080819234433.GJ24212@spearce.org>
 <20080820193557.GB16626@blimp.local> <20080820194407.GJ3483@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 21 00:22:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVw48-0006fe-Ux
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 00:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407AbYHTWVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 18:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753369AbYHTWVD
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 18:21:03 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48367 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901AbYHTWVB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 18:21:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D098461E50;
	Wed, 20 Aug 2008 18:20:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D152661E4F; Wed, 20 Aug 2008 18:20:55 -0400 (EDT)
In-Reply-To: <20080820194407.GJ3483@spearce.org> (Shawn O. Pearce's message
 of "Wed, 20 Aug 2008 12:44:07 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 445D52E4-6F06-11DD-ABE9-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93063>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> I was just trying to be cute by using the original commit timestamp
> of Git itself.  Perhaps 12936648 (1TB / 83)?

Well, reverse psychology did not quite work, I guess, so I'd ask more
directly.  Why not re-send with an update to the same 8-digit rule we use
elsewhere?
