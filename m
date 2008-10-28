From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] t9400, t9401: use "git cvsserver" without dash
Date: Tue, 28 Oct 2008 08:57:52 -0700
Message-ID: <7vy708g1a7.fsf@gitster.siamese.dyndns.org>
References: <7vljy13sq0.fsf@gitster.siamese.dyndns.org>
 <20080910062529.6117@nanako3.lavabit.com>
 <20080910200318.6117@nanako3.lavabit.com>
 <7v8wtzvd8h.fsf@gitster.siamese.dyndns.org>
 <20081028111610.GE1682@wo.int.altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Dmitry V. Levin" <ldv@altlinux.org>
X-From: git-owner@vger.kernel.org Tue Oct 28 17:00:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kuqye-0007E8-F5
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 16:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbYJ1P6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 11:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751977AbYJ1P6J
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 11:58:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57936 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbYJ1P6I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 11:58:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C770C75DA2;
	Tue, 28 Oct 2008 11:58:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 75B7F75D9D; Tue, 28 Oct 2008 11:58:01 -0400 (EDT)
In-Reply-To: <20081028111610.GE1682@wo.int.altlinux.org> (Dmitry V. Levin's
 message of "Tue, 28 Oct 2008 14:16:10 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 35DE83B2-A509-11DD-8CA3-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99300>

Thanks; will cherry-pick both.
