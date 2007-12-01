From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cvsimport: fix usage of cvsimport.module
Date: Fri, 30 Nov 2007 18:36:38 -0800
Message-ID: <7vabov9m4p.fsf@gitster.siamese.dyndns.org>
References: <20071130222212.GA30037@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Emanuele Giaquinta <e.giaquinta@glauco.it>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 01 03:37:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyIEI-0003kJ-9T
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 03:37:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758587AbXLACgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 21:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758570AbXLACgp
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 21:36:45 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40299 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758527AbXLACgo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 21:36:44 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id D82F62FB;
	Fri, 30 Nov 2007 21:37:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 752829B9F0;
	Fri, 30 Nov 2007 21:37:02 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66684>

Thanks; will apply to 'maint' along with your earlier fixes.
