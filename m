From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] t4049: avoid test failures on filemode challenged file
 systems (Windows)
Date: Fri, 30 Nov 2012 08:46:00 +0100
Message-ID: <50B86438.3010806@viscovery.net>
References: <1354051310-29093-1-git-send-email-gitster@pobox.com> <50B71B33.1090000@viscovery.net> <7v38zss7zb.fsf@alter.siamese.dyndns.org> <7vfw3sqoup.fsf@alter.siamese.dyndns.org> <7vfw3sp232.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 08:46:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeLIn-00023Z-AP
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 08:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752Ab2K3HqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2012 02:46:08 -0500
Received: from so.liwest.at ([212.33.55.13]:49408 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751639Ab2K3HqH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2012 02:46:07 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TeLIP-000709-DL; Fri, 30 Nov 2012 08:46:01 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 2C4C51660F;
	Fri, 30 Nov 2012 08:46:01 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vfw3sp232.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11/29/2012 21:48, schrieb Junio C Hamano:
> I've tested this with the testpen set on vfat mounted on my Linux
> box, ...
> and it seems to work OK,

Works well here on Windows, too.

Thanks,
-- Hannes
