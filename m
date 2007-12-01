From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: the commitdiff is very commonly used, it's needed on search page, too
Date: Fri, 30 Nov 2007 18:36:08 -0800
Message-ID: <7vwsrz9m5j.fsf@gitster.siamese.dyndns.org>
References: <1196080926-5962-1-git-send-email-crquan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, dengxw@163.com, jnareb@gmail.com,
	pasky@suse.cz
To: Denis Cheng <crquan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 01 03:36:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyIDr-0003eS-LB
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 03:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758297AbXLACgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 21:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758280AbXLACgT
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 21:36:19 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40248 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758230AbXLACgS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 21:36:18 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 51FF92F2;
	Fri, 30 Nov 2007 21:36:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id CB63D9B9ED;
	Fri, 30 Nov 2007 21:36:34 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66680>

I'll queue this to my tree but will drop if I hear objections from
gitweb people CC'ed over the weekend.
