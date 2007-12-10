From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Restore ls-remote reference pattern matching
Date: Mon, 10 Dec 2007 01:56:19 -0800
Message-ID: <7vhciqna9o.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0712082134350.5349@iabervon.org>
	<7vodd0tuuu.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0712082346310.5349@iabervon.org>
	<7v8x44tl7q.fsf@gitster.siamese.dyndns.org>
	<20071209162632.a16bfd6e.vsu@altlinux.ru>
	<7vtzmrobrl.fsf@gitster.siamese.dyndns.org>
	<5C669468-71F1-4E28-9E15-1EAA4893135F@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergey Vlasov <vsu@altlinux.ru>, git@vger.kernel.org
To: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
X-From: git-owner@vger.kernel.org Mon Dec 10 10:56:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1fNe-00081Q-V1
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 10:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271AbXLJJ4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 04:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbXLJJ4e
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 04:56:34 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36643 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956AbXLJJ4d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 04:56:33 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B2EB1106D;
	Mon, 10 Dec 2007 04:56:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 14B0F106B;
	Mon, 10 Dec 2007 04:56:20 -0500 (EST)
In-Reply-To: <5C669468-71F1-4E28-9E15-1EAA4893135F@orakel.ntnu.no> (Eyvind
	Bernhardsen's message of "Mon, 10 Dec 2007 10:16:42 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67696>

Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no> writes:

> This patch makes ls-remote work as expected for me.

Thanks, the patch is queued for master.
