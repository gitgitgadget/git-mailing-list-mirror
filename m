From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: rev-parse doesn't take pwd into consideration
Date: Tue, 27 May 2008 19:53:27 +0900
Message-ID: <200805271054.m4RAs3NE004265@mi0.bluebottle.com>
References: <7vprr84tzc.fsf@gitster.siamese.dyndns.org> <7vhcckddov.fsf@gitster.siamese.dyndns.org> <20080526195812.GA23396@bit.office.eurotux.com> <200805262135.m4QLZtpq023003@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Luciano Rocha <luciano@eurotux.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 27 12:54:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0wpW-0003k2-Sc
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 12:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756542AbYE0KyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 06:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756422AbYE0KyG
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 06:54:06 -0400
Received: from mi0.bluebottle.com ([206.188.25.15]:51361 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756459AbYE0KyE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 06:54:04 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m4RAs3NE004265
	for <git@vger.kernel.org>; Tue, 27 May 2008 03:54:03 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:subject:date:in-reply-to:references:
	mime-version:content-type:content-transfer-encoding:x-trusted-delivery;
	b=HIkPlvLmR6ykFiFJNciuH4A2IHn2RgI2JnTQFy7ohN4ULuBCk/BjEFQy94VDJVbv4
	HQgyLnaJi4QLMmfQ+h8ionAFSKTWQxsO+zc13e1rWR985EcmOQdt8sNkmoE+mlt
Received: from nanako3.mail.bluebottle.com ([212.62.97.21])
	(authenticated bits=0)
	by fe1.bluebottle.com (8.13.1/8.13.1) with ESMTP id m4RArnXa004668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 27 May 2008 03:53:56 -0700
In-Reply-To: <7vprr84tzc.fsf@gitster.siamese.dyndns.org>
X-Trusted-Delivery: <5fa16f5af4c23ee6eba3f4a344f4255f>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83003>

Quoting Junio C Hamano <gitster@pobox.com>:

> But I do not think I (or we collectively as the project) can afford to
> keep doing that in the longer term.  A minute lost for me is a minute lost
> for the project to review and integrate changes that others spent dozens
> of minutes, perhaps hours, to come up with.  So I should not be constantly
> doing the archive research for other people.

I agree that your time is more valuable.

> My response might have been mean, and I instead could have ignored it and
> allow the thread to waste time of others responding to it, but that would
> have been a worse alternative than nipping it off in the bud.  I am not
> sure what better alternatives there were, other than having a dedicated
> secretary/librarian to do the archive research for the community.
>
>> http://thread.gmane.org/gmane.comp.version-control.git/68786/focus=68852
>
> Yeah, that's the one I had in mind.  I like quoting the threaded interface
> from gmane --- it makes the context of old discussion very clear.

I remembered that you were not so happy when I pointed at marc.info the last time.  I can learn (^_^).

And it was very easy to find the discussion in gmane (I asked "relative cwd path blob" and the discussion was the first in the list).

> Thanks.

You are wellcome (^_^).

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Free pop3 email with a spam filter.
http://www.bluebottle.com/tag/5
