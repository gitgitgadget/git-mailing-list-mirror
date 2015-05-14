From: Stefan Tatschner <stefan@sevenbyte.org>
Subject: Re: [PATCH] Documentation: Fix inconsistent quotes
Date: Thu, 14 May 2015 11:14:17 +0200
Message-ID: <1431594857.15159.4.camel@sevenbyte.org>
References: <1430330932-10578-1-git-send-email-stefan@sevenbyte.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 14 11:14:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YspDm-0001bb-Nb
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 11:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbbENJOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 05:14:22 -0400
Received: from mail.sevenbyte.org ([5.9.90.188]:43811 "EHLO mail.sevenbyte.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932265AbbENJOU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 05:14:20 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.sevenbyte.org (Postfix) with ESMTP id 5F00B126062D;
	Thu, 14 May 2015 11:14:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at sevenbyte.org
Received: from mail.sevenbyte.org ([127.0.0.1])
	by localhost (mail.sevenbyte.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MoWScUBSH-pb; Thu, 14 May 2015 11:14:17 +0200 (CEST)
In-Reply-To: <1430330932-10578-1-git-send-email-stefan@sevenbyte.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269029>

On Wed, 2015-04-29 at 20:08 +0200, Stefan Tatschner wrote:
> While reading 'man git' I realized that the highlighting of the
> environment variables is not consistent. This patch adds missing 
> single
> quotes and substitutes backticks with the proper quotes as well.

Since currently there are some patches around which aim to improve the
documentation, may I ask about the status of this patch? Should I
improve/modify something, or is it actually not needed?

Thanks,
Stefan
