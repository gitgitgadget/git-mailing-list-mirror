From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] diff.c: remove useless check for value != NULL
Date: Fri, 15 Feb 2008 23:14:56 -0800
Message-ID: <7vejbdcqz3.fsf@gitster.siamese.dyndns.org>
References: <20080216055953.d5fafe10.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Feb 16 08:16:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQHHS-0000eZ-Dc
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 08:16:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbYBPHP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 02:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbYBPHP3
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 02:15:29 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64118 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbYBPHP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 02:15:28 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 73D7331EA;
	Sat, 16 Feb 2008 02:15:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 1C7B131E8; Sat, 16 Feb 2008 02:15:14 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74023>

Christian Couder <chriscool@tuxfamily.org> writes:

> 	This patch series can be applied on "master"
> 	on top of my "diff.c: strdup -> xstrdup" patch. 
>
> 	The first 3 patches apply cleanly on "next" though.

They are all 'maint' material as far as I can tell ;-)

Thanks.
