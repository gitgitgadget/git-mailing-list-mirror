From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/40] Add target architecture MinGW.
Date: Wed, 05 Mar 2008 14:22:21 -0800
Message-ID: <7vir00lski.fsf@gitster.siamese.dyndns.org>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
 <1204138503-6126-4-git-send-email-johannes.sixt@telecom.at>
 <alpine.LSU.1.00.0802281159550.22527@racer.site>
 <200803052221.12495.johannes.sixt@telecom.at>
 <alpine.LSU.1.00.0803052317350.15786@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 05 23:23:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX21C-0002HR-Lj
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 23:23:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbYCEWWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 17:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753244AbYCEWWd
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 17:22:33 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55308 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbYCEWWc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 17:22:32 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7F04F29E5;
	Wed,  5 Mar 2008 17:22:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E273C29E3; Wed,  5 Mar 2008 17:22:26 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0803052317350.15786@racer.site> (Johannes
 Schindelin's message of "Wed, 5 Mar 2008 23:18:53 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76277>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Thanks!
>
> With this, I think I have nothing to add to your series (except maybe an 
> Acked-by: where it applies, or a Reviewed-by:, but I think that this 
> would only be a burden on our maintainer).

I think Reviewed-by: would indeed be a very good addition to our
patch flow convention, borrowing from the kernel folks.
