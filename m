From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v3] Give the hunk comment its own color
Date: Mon, 30 Nov 2009 08:41:49 +0100
Message-ID: <36ca99e90911292341o524840ebo47d79f06b1588d5c@mail.gmail.com>
References: <7v4oogzo74.fsf@alter.siamese.dyndns.org>
	 <1259304918-12600-1-git-send-email-bert.wesarg@googlemail.com>
	 <7vhbsfi4bz.fsf@alter.siamese.dyndns.org>
	 <36ca99e90911280408v186777f1h22254744fb61bf1f@mail.gmail.com>
	 <36ca99e90911292307w769913fdn1f610eeb065b41e@mail.gmail.com>
	 <7v4ooczdoe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 08:41:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF0tQ-0004gS-MV
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 08:41:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890AbZK3Hlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 02:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753727AbZK3Hlo
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 02:41:44 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:50799 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbZK3Hlo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 02:41:44 -0500
Received: by fxm5 with SMTP id 5so3366427fxm.28
        for <git@vger.kernel.org>; Sun, 29 Nov 2009 23:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=vJkmw346BzEE3P7QD+/cLvRYCdrTsGClTLN1wgOKa/8=;
        b=xmXOtPF7WhRbe5agQZUTAQByMJY2n83FDP4s9PeECcNjV4ot1KOedjiAuMzYFveQxn
         rblgFPQio5DWDrLeAUW/7r+ei69KleEcb7l+JbqUfuWk2GnkGkp0bQLSs7L0j7SVR42V
         6q8zoR57Uj8xCIagJiqTbZrSqe4V0wUEhhfis=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=n/D5NPRwL8eIZwT+/CYN1lRt6TdpWNhYBcNxNMH+eh47d8FTO5rbYd5IB44Q1j6iXr
         9ckqevAzBBwhr0eI2wwJKAWWTY87on5Lg18bfQNkzAXsdha514Xg/as+h+RAnvzeSBc5
         2APwZvIAj8lRUbVbRRPUUlGKXqepafI5MAu3g=
Received: by 10.223.25.27 with SMTP id x27mr656295fab.7.1259566909521; Sun, 29 
	Nov 2009 23:41:49 -0800 (PST)
In-Reply-To: <7v4ooczdoe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134069>

On Mon, Nov 30, 2009 at 08:15, Junio C Hamano <gitster@pobox.com> wrote:
> Sorry, but I think the fix is already in 'next', no?
Yes it is, should have fetched first. sorry.
