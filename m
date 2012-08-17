From: Miklos Vajna <vmiklos@suse.cz>
Subject: Re: [PATCH] man: git pull -r is a short for --rebase
Date: Fri, 17 Aug 2012 09:04:07 +0200
Message-ID: <20120817070406.GD22313@suse.cz>
References: <20120816095018.GD5489@suse.cz>
 <7v1uj63iyx.fsf@alter.siamese.dyndns.org>
 <502D5D97.3020906@kdbg.org>
 <7v4no21raw.fsf@alter.siamese.dyndns.org>
 <7vzk5uzgqa.fsf@alter.siamese.dyndns.org>
 <20120817053826.GB22313@suse.cz>
 <7vk3wyvy67.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 09:04:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2GbS-0008NW-EM
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 09:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754415Ab2HQHEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 03:04:13 -0400
Received: from cantor2.suse.de ([195.135.220.15]:40568 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792Ab2HQHEM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 03:04:12 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 7E534A39CE;
	Fri, 17 Aug 2012 09:04:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vk3wyvy67.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2012 at 11:18:40PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> From: Miklos Vajna <vmiklos@suse.cz>
> Date: Thu, 16 Aug 2012 11:50:18 +0200
> Subject: [PATCH] man: git pull -r is a short for --rebase
> 
> Letting the "--rebase" option squat on the short-and-sweet single
> letter option "-r" was an unintended accident and was not even
> documented, but the short option seems to be already used in the
> wild. Let's document it so that other options that begin with "r"
> would not be tempted to steal it.

Signed-off-by: Miklos Vajna <vmiklos@suse.cz>
