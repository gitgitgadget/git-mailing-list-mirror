From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] hg-to-git: improve popen calls
Date: Tue, 15 Jan 2008 02:15:27 -0800
Message-ID: <7vve5vfl8g.fsf@gitster.siamese.dyndns.org>
References: <478C0837.7090804@gmail.com> <1200390734.10025.28.camel@galileo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Drago <markdrago@gmail.com>, git@vger.kernel.org,
	brian.ewins@gmail.com
To: Stelian Pop <stelian@popies.net>
X-From: git-owner@vger.kernel.org Tue Jan 15 11:16:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEiq8-0001kR-Px
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 11:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134AbYAOKPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 05:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753215AbYAOKPi
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 05:15:38 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55929 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703AbYAOKPh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 05:15:37 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E9FB25E89;
	Tue, 15 Jan 2008 05:15:35 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 759E65E88;
	Tue, 15 Jan 2008 05:15:30 -0500 (EST)
In-Reply-To: <1200390734.10025.28.camel@galileo> (Stelian Pop's message of
	"Tue, 15 Jan 2008 10:52:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70509>

Thanks both.  Will apply (but I am about to head to bed for the
night).
