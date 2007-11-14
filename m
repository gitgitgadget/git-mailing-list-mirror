From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git and Scmbug integration
Date: Tue, 13 Nov 2007 17:11:31 -0800
Message-ID: <7vprydpr5o.fsf@gitster.siamese.dyndns.org>
References: <1194980792.4106.6.camel@localhost>
	<ee77f5c20711131500h6ee067ffv3e488ac7bde1d22c@mail.gmail.com>
	<1194998142.4106.24.camel@localhost>
	<ee77f5c20711131602m5b9042fx72689af53e24ddd2@mail.gmail.com>
	<1194999404.4106.40.camel@localhost>
	<ee77f5c20711131627q329d45aepe48102728cf2778c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kristis Makris" <kristis.makris@asu.edu>, jnareb@gmail.com,
	git@vger.kernel.org, scmbug-users@lists.mkgnu.net
To: "David Symonds" <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 02:12:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is6ng-0004Pd-Kv
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 02:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761610AbXKNBLw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 20:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761011AbXKNBLw
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 20:11:52 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:39620 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759186AbXKNBLv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 20:11:51 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id BFACF2F0;
	Tue, 13 Nov 2007 20:12:12 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 348DB95737;
	Tue, 13 Nov 2007 20:12:05 -0500 (EST)
In-Reply-To: <ee77f5c20711131627q329d45aepe48102728cf2778c@mail.gmail.com>
	(David Symonds's message of "Wed, 14 Nov 2007 11:27:40 +1100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64936>

"David Symonds" <dsymonds@gmail.com> writes:

> Sure -- I've got a patch for it that I'll send shortly. It's using the
> existing shell git-commit, so might be suitable for maint; I haven't
> followed what's happened with the builtinification of git-commit.

No, 'maint' won't get a feature enhancements.

Again, why isn't reading HEAD enough?
