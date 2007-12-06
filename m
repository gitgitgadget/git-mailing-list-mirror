From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do check_repository_format() early
Date: Wed, 05 Dec 2007 17:18:23 -0800
Message-ID: <7v7ijsk4dc.fsf@gitster.siamese.dyndns.org>
References: <20071128165837.GA5903@laptop> <20071205132514.GA5580@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 02:19:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J05OC-0000rN-PZ
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 02:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbXLFBSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 20:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754171AbXLFBSd
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 20:18:33 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:37067 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737AbXLFBSc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 20:18:32 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 4ED302EF;
	Wed,  5 Dec 2007 20:18:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id A13559CE6D;
	Wed,  5 Dec 2007 20:18:47 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67216>

Thanks, this looks very sensible to me.
