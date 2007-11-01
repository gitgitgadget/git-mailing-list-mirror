From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do no colorify test output if stdout is not a terminal
Date: Thu, 01 Nov 2007 15:47:48 -0700
Message-ID: <7vd4ut8twr.fsf@gitster.siamese.dyndns.org>
References: <20071101140158.GA14475@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 23:48:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inipe-0005b9-Hz
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 23:48:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753855AbXKAWrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 18:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752771AbXKAWrz
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 18:47:55 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:59667 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbXKAWry (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 18:47:54 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id B83FA2F0;
	Thu,  1 Nov 2007 18:48:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 5B3EA912DF;
	Thu,  1 Nov 2007 18:48:12 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63028>

Good catch.  Thanks.
