From: David Brown <git@davidb.org>
Subject: Re: [PATCH] git-send-email: Add --suppress-all-from option.
Date: Fri, 21 Dec 2007 14:37:48 -0800
Message-ID: <20071221223748.GA499@old.davidb.org>
References: <1198216860-487-1-git-send-email-git@davidb.org> <7vfxxw7xkb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 23:38:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5qVU-00062e-PL
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 23:38:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760162AbXLUWhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 17:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756544AbXLUWhw
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 17:37:52 -0500
Received: from mail.davidb.org ([66.93.32.219]:45029 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760166AbXLUWhv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 17:37:51 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.68 #1 (Debian))
	id 1J5qV2-00009H-Te; Fri, 21 Dec 2007 14:37:48 -0800
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vfxxw7xkb.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69102>

On Fri, Dec 21, 2007 at 09:43:48AM -0800, Junio C Hamano wrote:
>David Brown <git@davidb.org> writes:
>
>> Sometimes, it is useful to be able to send a patch to a third party
>> without the author of the patch being copied on the message.
>
>I would agree with the cause, but not necessarily with the
>execution.

Ok.  I will look into the overall cleanup, but probably not until this
weekend.

Dave
