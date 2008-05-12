From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve reporting of errors in config file routines
Date: Mon, 12 May 2008 15:10:13 -0700
Message-ID: <7vmymvxjga.fsf@gitster.siamese.dyndns.org>
References: <20080512141636.GA29590@elte.hu>
 <20080512214104.GA12294@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 00:11:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvgEp-0006AK-JU
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 00:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753959AbYELWK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 18:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753937AbYELWK3
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 18:10:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61089 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbYELWK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 18:10:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 534FC24D9;
	Mon, 12 May 2008 18:10:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9FEA324D7; Mon, 12 May 2008 18:10:23 -0400 (EDT)
In-Reply-To: <20080512214104.GA12294@steel.home> (Alex Riesen's message of
 "Mon, 12 May 2008 23:41:04 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3A0C423A-2070-11DD-B27C-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81958>

Looks good, thanks.
