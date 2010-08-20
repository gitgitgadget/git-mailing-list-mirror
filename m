From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 3/4] fmt-merge-msg: Update fmt-merge-msg and merge-config
 documentation
Date: Fri, 20 Aug 2010 14:44:59 +0200
Message-ID: <4C6E78CB.1090907@viscovery.net>
References: <1282307041-19681-1-git-send-email-artagnon@gmail.com> <1282307041-19681-4-git-send-email-artagnon@gmail.com> <20100820123935.GB9448@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 14:47:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmR0d-0004Ru-Nc
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 14:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783Ab0HTMpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 08:45:06 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:59866 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751337Ab0HTMpE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 08:45:04 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OmQxw-0004xk-3g; Fri, 20 Aug 2010 14:45:00 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id CF1451660F;
	Fri, 20 Aug 2010 14:44:59 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.11) Gecko/20100711 Thunderbird/3.0.6
In-Reply-To: <20100820123935.GB9448@kytes>
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154026>

Am 8/20/2010 14:39, schrieb Ramkumar Ramachandra:
> Minor mistake: This patch removes the --summary option from the
> documentation before removing it from the code.

Not only that: It also removes --no-log, and makes the argument to --log
mandatory, doesn't it?

-- Hannes
