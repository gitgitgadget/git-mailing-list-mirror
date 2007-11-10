From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make GIT_INDEX_FILE apply to git-commit
Date: Sat, 10 Nov 2007 02:39:48 -0800
Message-ID: <7vode2mljf.fsf@gitster.siamese.dyndns.org>
References: <87abpml8rx.dlv@vanicat.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Remi Vanicat <vanicat@debian.org>
X-From: git-owner@vger.kernel.org Sat Nov 10 11:40:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqnl3-0007kf-52
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 11:40:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbXKJKjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 05:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbXKJKjy
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 05:39:54 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:35186 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbXKJKjx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 05:39:53 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 0C48C2F2;
	Sat, 10 Nov 2007 05:40:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 8BEF693125;
	Sat, 10 Nov 2007 05:40:12 -0500 (EST)
In-Reply-To: <87abpml8rx.dlv@vanicat.homelinux.org> (Remi Vanicat's message of
	"Sat, 10 Nov 2007 11:00:50 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64327>

Sounds sensible.  Tests?
