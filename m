From: Jason Sewall <jasonsewall@gmail.com>
Subject: Re: [PATCH v2] Give the hunk comment its own color
Date: Wed, 18 Nov 2009 10:17:01 -0500
Message-ID: <31e9dd080911180717i27c6ef3fp736b7f8d41e4c8be@mail.gmail.com>
References: <1258543836-799-1-git-send-email-bert.wesarg@googlemail.com>
	 <1258557087-31540-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 16:18:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAmIB-0000sC-81
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 16:17:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755938AbZKRPRD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 10:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754461AbZKRPRD
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 10:17:03 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:44499 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755809AbZKRPRB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 10:17:01 -0500
Received: by bwz27 with SMTP id 27so1228596bwz.21
        for <git@vger.kernel.org>; Wed, 18 Nov 2009 07:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=ePHIAtpIk9Ch79EAXvidQdC+H0vi57zfrDv9RUfGxr4=;
        b=du9KQ+vkylR7RoAVYcUFuQ9zRJ7OrUgGkozZliaM4V4rN2FRGRez7Q92LPM2RgqIbN
         KqfK6JZCxSOXIoUVD8SGS4/asQzs5SVQfLou7FZI6pBVwxmrN3gjAWIGEcYyPYWKSP9M
         2/h4MtWfR/Za7/+24VAsyWdj79NZ4x51Fn4HA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=WDIHcJ+FJtLsmqsmxXK/o0zAQi8Tbv0UwZzERhjhbaVQowRyGen/86FozdBvau77nM
         BZRzgPNqH6+2GOihqo80aTNBe68jW77uwaz9KAwF6dsolkmwsR8XTTHzaGkj/KVIFb2u
         uHCYw4uBeSLW951quUwJnLXqnjAHghhIb89DY=
Received: by 10.216.91.18 with SMTP id g18mr794968wef.124.1258557423568; Wed, 
	18 Nov 2009 07:17:03 -0800 (PST)
In-Reply-To: <1258557087-31540-1-git-send-email-bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133185>

On Wed, Nov 18, 2009 at 10:11 AM, Bert Wesarg
<bert.wesarg@googlemail.com> wrote:

> Now with updated test suit.

Spelling this as 'suite' would be sweet.
