From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: wt-status.h is also a lib header
Date: Mon, 26 May 2008 14:54:42 -0700
Message-ID: <7vlk1w4tp9.fsf@gitster.siamese.dyndns.org>
References: <483AC2CE.7090801@gmail.com>
 <alpine.DEB.1.00.0805261521130.30431@racer> <483ADA17.3080401@viscovery.net>
 <alpine.DEB.1.00.0805262220160.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 26 23:55:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0kfN-00062H-S4
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 23:55:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755169AbYEZVyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 17:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755159AbYEZVyu
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 17:54:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63608 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754542AbYEZVyt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 17:54:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8ABA12B4D;
	Mon, 26 May 2008 17:54:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 046D32B44; Mon, 26 May 2008 17:54:44 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0805262220160.30431@racer> (Johannes
 Schindelin's message of "Mon, 26 May 2008 22:21:10 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5C474468-2B6E-11DD-999F-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82965>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When a struct in wt-status.h changes, many files need to be rebuilt.

What project, that has levenshtein.h, is this patch is for ;-)?
