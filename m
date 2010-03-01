From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: Better cooperation between checkouts and stashing
Date: Mon, 01 Mar 2010 22:20:16 +0100
Message-ID: <4B8C2F90.8080104@web.de>
References: <4B67227A.7030908@web.de> <7vhbq0wuy6.fsf@alter.siamese.dyndns.org> <4B898F97.90706@web.de> <7vr5o6s5xf.fsf@alter.siamese.dyndns.org> <4B8B9BF1.10408@web.de> <7v1vg4ufas.fsf@alter.siamese.dyndns.org> <4b8c0420.5544f10a.2eb2.ffffb4c4@mx.google.com> <7vk4tvsu6x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 01 22:21:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmD3N-0000df-4A
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 22:21:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366Ab0CAVVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 16:21:20 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:49162 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab0CAVVU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 16:21:20 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 10F5B150F2324;
	Mon,  1 Mar 2010 22:21:19 +0100 (CET)
Received: from [78.48.194.16] (helo=[192.168.1.202])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NmD2G-000456-00; Mon, 01 Mar 2010 22:20:16 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <7vk4tvsu6x.fsf@alter.siamese.dyndns.org>
X-Provags-ID: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141350>

> If you want to have per-branch stash, that is a totally independent problem,
> and I'd suggest using real refs ($GIT_DIR/refs/stashes/$branch_name) instead
> of the md5 hack, if that is the motivation.

How is this use case different from the other?
Which "problem" have you got in mind?

Regards,
Markus
