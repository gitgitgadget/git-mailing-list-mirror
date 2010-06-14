From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] revert: add --stdin option to read commits from stdin
Date: Mon, 14 Jun 2010 08:20:43 +0200
Message-ID: <4C15CA3B.3050908@viscovery.net>
References: <20100614032251.20121.83253.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Jun 14 08:21:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OO32c-0003ai-Bb
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 08:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753578Ab0FNGU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 02:20:56 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:41275 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753367Ab0FNGU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 02:20:56 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OO32R-0003tY-Rd; Mon, 14 Jun 2010 08:20:51 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 6D2B51660F;
	Mon, 14 Jun 2010 08:20:51 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <20100614032251.20121.83253.chriscool@tuxfamily.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149077>

Am 6/14/2010 5:22, schrieb Christian Couder:
> +--stdin::
> +	In addition to the '<commit>' listed on the command
> +	line, read them from the standard input.

And the order in which --stdin and command line commits are processed is...?

-- Hannes
