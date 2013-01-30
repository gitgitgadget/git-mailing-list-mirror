From: John Keeping <john@keeping.me.uk>
Subject: Re: What's cooking in git.git (Jan 2013, #11; Wed, 30)
Date: Wed, 30 Jan 2013 19:07:59 +0000
Message-ID: <20130130190759.GJ1342@serenity.lan>
References: <7vd2wmldw9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 20:08:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0d1W-0006nL-JK
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 20:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756721Ab3A3TIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 14:08:11 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:34330 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756718Ab3A3TIH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 14:08:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id D8E7322BFB;
	Wed, 30 Jan 2013 19:08:06 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bs7txCrWeAwu; Wed, 30 Jan 2013 19:08:06 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id 68BD022B5C;
	Wed, 30 Jan 2013 19:08:06 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 5C2C2161E02E;
	Wed, 30 Jan 2013 19:08:06 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Iu0Ny8FVPVlc; Wed, 30 Jan 2013 19:08:06 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id DA351161E3F9;
	Wed, 30 Jan 2013 19:08:01 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vd2wmldw9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215058>

On Wed, Jan 30, 2013 at 10:33:10AM -0800, Junio C Hamano wrote:
> [Discarded]
> 
> * jk/update-install-for-p4 (2013-01-20) 1 commit
>  . INSTALL: git-p4 doesn't support Python 3
> 
>  Made obsolete by bc/git-p4-for-python-2.4 topic.

I disagree with this - that branch doesn't change INSTALL to list "not
Python 3" in the supported versions.

Brandon, would you mind doing s/2.4 or later/2.4 - 2.7/ on your branch?


John
