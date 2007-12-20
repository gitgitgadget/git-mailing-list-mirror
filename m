From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git commit does not show all added files in subdirectories
Date: Wed, 19 Dec 2007 19:54:05 -0800
Message-ID: <7v4peerpgi.fsf@gitster.siamese.dyndns.org>
References: <449c10960712191947y3125f782t6ce7ec7b25ded30f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Dan McGee" <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 04:54:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5CUe-0006ef-9j
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 04:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927AbXLTDyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 22:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753440AbXLTDyS
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 22:54:18 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40319 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882AbXLTDyR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 22:54:17 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 46E7B9B7B;
	Wed, 19 Dec 2007 22:54:11 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A39C29B78;
	Wed, 19 Dec 2007 22:54:07 -0500 (EST)
In-Reply-To: <449c10960712191947y3125f782t6ce7ec7b25ded30f@mail.gmail.com>
	(Dan McGee's message of "Wed, 19 Dec 2007 21:47:57 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68970>

Should be fixed already by 3eb2a15eb385749fbfe59b4e37fc754416275760
(builtin-commit: make summary output consistent with status).
