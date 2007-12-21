From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-describe: Add a --match option to limit considered tags.
Date: Fri, 21 Dec 2007 09:52:29 -0800
Message-ID: <7v7ij87x5u.fsf@gitster.siamese.dyndns.org>
References: <1198253900-31502-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Dec 21 18:53:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5m3P-0005bd-30
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 18:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753471AbXLURwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 12:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753233AbXLURwf
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 12:52:35 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38806 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbXLURwf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 12:52:35 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 969333386;
	Fri, 21 Dec 2007 12:52:33 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 349353385;
	Fri, 21 Dec 2007 12:52:31 -0500 (EST)
In-Reply-To: <1198253900-31502-1-git-send-email-madcoder@debian.org> (Pierre
	Habouzit's message of "Fri, 21 Dec 2007 17:18:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69081>

Does it work with "describe --contains" as well?
