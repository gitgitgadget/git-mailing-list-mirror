From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Avoiding broken Gitweb links and deleted objects
Date: Fri, 10 May 2013 09:03:52 +0200
Message-ID: <518C9BD8.90508@viscovery.net>
References: <CAJELnLFrfY=-gOFEe0cJHuyT4UNjbTm8hXMxAmzmQHVbz4iEbg@mail.gmail.com> <518C8EAC.6000106@viscovery.net> <7vzjw349y0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matt McClure <matthewlmcclure@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 10 09:04:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UahNB-0002yQ-HM
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 09:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435Ab3EJHEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 03:04:04 -0400
Received: from so.liwest.at ([212.33.55.13]:28867 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750825Ab3EJHED (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 03:04:03 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UahN3-0007Bs-6J; Fri, 10 May 2013 09:04:01 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E8A4E1660F;
	Fri, 10 May 2013 09:04:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <7vzjw349y0.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223819>

Am 5/10/2013 8:37, schrieb Junio C Hamano:
> What if we teach "git rebase" to record, perhaps by default, an
> "ours" merge on top of Y that takes the tree state of Y but has X as
> its second parent, ...

Please let's not go that route...

-- Hannes
