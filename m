From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH 2/3] git-svn: Add --add-author-from option.
Date: Wed, 16 Apr 2008 18:34:12 -0400
Message-ID: <32541b130804161534y33ac9b74jfa2ab81af5ee961c@mail.gmail.com>
References: <1208307858-31039-1-git-send-email-apenwarr@gmail.com>
	 <1208307858-31039-2-git-send-email-apenwarr@gmail.com>
	 <7vej96v2pk.fsf@gitster.siamese.dyndns.org>
	 <32541b130804160946s343d53d2l271b9391d89a7953@mail.gmail.com>
	 <7v3aplsl3p.fsf@gitster.siamese.dyndns.org>
	 <20080416192312.GF3133@dpotapov.dyndns.org>
	 <48067C83.4020209@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Eric Wong" <normalperson@yhbt.net>, git@vger.kernel.org,
	"Avery Pennarun" <apenwarr@versabanq.com>
To: "Sam Vilain" <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Apr 17 00:35:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmGDU-0002e3-I5
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 00:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211AbYDPWeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 18:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbYDPWeP
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 18:34:15 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:23074 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbYDPWeP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 18:34:15 -0400
Received: by fk-out-0910.google.com with SMTP id 19so3015666fkr.5
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 15:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=g0gxD+KaloS3wDuc59x2EvIDC1CC/2m5F/dprcP6ibg=;
        b=B2tdX7laFrmtILy59DKHr7j4FMxBIe4hvR1fx1pmyWO9E+N3+r4OkBSdr8Ps7uIyDFz6RYb9ONwRssPxZtarTGApZ5Jyw7EDF0bmLg9uIWG6O9vLjwFYSpF5KtuxsCSujQXKn2Ea9jUHRnO2fYWHr6jr0q4t9bIGl+VZBkbDMpA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sflBn/D9VOL3gICPT4wOcEe1CcQ0sI6S/uDhFyMvxG32o7+iU0u25rTbSTcfT5uRVeqXfiS4wgI9MckghayCL5TwOw2f9i+9t0UfZvm1nvpQH5b3+Vvn6729p3qpDKQyDX/E7isiz2HbhglLFgJHFdhtg0jKVFo/yQ16STUBed4=
Received: by 10.82.156.12 with SMTP id d12mr864292bue.78.1208385252619;
        Wed, 16 Apr 2008 15:34:12 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Wed, 16 Apr 2008 15:34:12 -0700 (PDT)
In-Reply-To: <48067C83.4020209@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79760>

On 4/16/08, Sam Vilain <sam@vilain.net> wrote:
> The usual thing is to dump the extra information in the commit message.
> Some projects, like Perl, were quite systematic about this and a lot of
> useful author information is available. In fact, it was saved in the
> proposed form.

So can we say that you have no objections to my patch? :)

Thanks,

Avery
