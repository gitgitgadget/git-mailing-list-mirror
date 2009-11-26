From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] Give the hunk comment its own color
Date: Thu, 26 Nov 2009 13:05:53 +0100
Message-ID: <36ca99e90911260405y42a9a07cx419d2973ec673039@mail.gmail.com>
References: <1258543836-799-1-git-send-email-bert.wesarg@googlemail.com>
	 <20091118142320.GA1220@coredump.intra.peff.net>
	 <7vaayjebu5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 13:06:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDd6n-0004p4-4j
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 13:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbZKZMFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 07:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbZKZMFt
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 07:05:49 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:45859 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbZKZMFs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 07:05:48 -0500
Received: by fxm5 with SMTP id 5so660510fxm.28
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 04:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=LzZqC1NW6oKbS+xk0+VjmpIn3JLga4my8Cn9aHiJS6o=;
        b=hW7scoISW5L4zwZl555r5afUXG6Q59FFNGFHkGOqb3i3UTRofKD1Mk65JYLRxci8kD
         4IV8n2TPEdIrq/BtmzYbY4y3G4vl3Ofh7iWaso+OYR4XWXvnS2BNGKswawhlRd+fwaFo
         nxjewW5Dh2v+ekivLype4jbxQHMLgO49SUqmM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=AvaLi2+bQYmD5embVIiBE8he4Sk4GkTvu0tU73Un5R+C35JoRdS9AC7Zy/AhC4Rkco
         aanhUMxumHASZaiYAB6Lkf227twM8onE/Hg2DqMZ0rYnsVUT9V3xgkIArDtZvTW4nXU2
         bogKVJRabOXhikS8VVWrJ8coAaAfRt4HHobvw=
Received: by 10.223.14.91 with SMTP id f27mr1435902faa.90.1259237153407; Thu, 
	26 Nov 2009 04:05:53 -0800 (PST)
In-Reply-To: <7vaayjebu5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133787>

Junio,

may I kindly remind you of this patch. If it is only the nen-existing
consensus of the default color, than please use the die.

Kind regards,
Bert Wesarg
