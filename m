From: Johan Herland <johan@herland.net>
Subject: Re: [ANNOUNCE] Git 1.7.3.rc1
Date: Sun, 12 Sep 2010 16:52:21 +0200
Message-ID: <201009121652.22297.johan@herland.net>
References: <7vvd6dfb5k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 12 16:52:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ounv7-00048K-DD
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 16:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201Ab0ILOwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Sep 2010 10:52:25 -0400
Received: from mail.mailgateway.no ([82.117.37.108]:63783 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960Ab0ILOwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Sep 2010 10:52:25 -0400
Received: from [70.75.160.134] (helo=epsilon.localnet)
	by mail.mailgateway.no with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.60 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Ounun-0003MQ-9M; Sun, 12 Sep 2010 16:52:22 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.32-24-generic; KDE/4.4.2; i686; ; )
In-Reply-To: <7vvd6dfb5k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156034>

On Saturday, September 11, 2010 01:09:59 am Junio C Hamano wrote:
> Fixes since v1.7.2
> ------------------
> 
>  * "git note remove" created unnecessary extra commit when named object
>    did not have any note to begin with.

s/note/notes/ ?


...Johan
