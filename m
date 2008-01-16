From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve use of lockfile API
Date: Wed, 16 Jan 2008 11:30:25 -0800
Message-ID: <7v4pddr2jy.fsf@gitster.siamese.dyndns.org>
References: <478E572E.3020505@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Jan 16 20:31:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFDyW-000243-Mr
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 20:31:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294AbYAPTac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 14:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbYAPTac
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 14:30:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61864 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbYAPTab (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 14:30:31 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 885503904;
	Wed, 16 Jan 2008 14:30:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AF383903;
	Wed, 16 Jan 2008 14:30:27 -0500 (EST)
In-Reply-To: <478E572E.3020505@nrlssc.navy.mil> (Brandon Casey's message of
	"Wed, 16 Jan 2008 13:12:46 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70730>

Ok, our mails crossed.  I'll scrap part of my [2/2] and queue
this series perhaps to 'next' after review.
