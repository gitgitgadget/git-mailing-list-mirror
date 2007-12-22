From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't dereference NULL upon lookup_tree failure.
Date: Sat, 22 Dec 2007 10:32:53 -0800
Message-ID: <7v63yqy3ze.fsf@gitster.siamese.dyndns.org>
References: <873atvwueq.fsf@rho.meyering.net>
	<7v4peb4qbj.fsf@gitster.siamese.dyndns.org>
	<87hcibveut.fsf@rho.meyering.net>
	<7vzlw33a1o.fsf@gitster.siamese.dyndns.org>
	<87bq8jvd1g.fsf@rho.meyering.net>
	<7vve6r39bp.fsf@gitster.siamese.dyndns.org>
	<8763yrvb3g.fsf@rho.meyering.net>
	<7vzlw3xeqy.fsf@gitster.siamese.dyndns.org>
	<87prwyu9r0.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Matthew Farrellee <mfarrellee@redhat.com>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Sat Dec 22 19:33:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J69AG-0003EM-PS
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 19:33:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbXLVSdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 13:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752443AbXLVSdE
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 13:33:04 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47869 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbXLVSdC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 13:33:02 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D3D73737C;
	Sat, 22 Dec 2007 13:33:00 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CFF77379;
	Sat, 22 Dec 2007 13:32:55 -0500 (EST)
In-Reply-To: <87prwyu9r0.fsf@rho.meyering.net> (Jim Meyering's message of
	"Sat, 22 Dec 2007 14:41:55 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69152>

Thanks.
