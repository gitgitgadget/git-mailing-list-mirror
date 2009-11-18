From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] Give the hunk comment its own color
Date: Wed, 18 Nov 2009 12:57:33 +0100
Message-ID: <36ca99e90911180357p929b642jada9f4afc81e99d8@mail.gmail.com>
References: <1258543836-799-1-git-send-email-bert.wesarg@googlemail.com>
	 <be6fef0d0911180344ld31237et533cfa8832ea0c6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 12:57:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAjAK-0007t2-Gb
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 12:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbZKRL53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 06:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbZKRL53
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 06:57:29 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:33293 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbZKRL52 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 06:57:28 -0500
Received: by fxm21 with SMTP id 21so1072409fxm.21
        for <git@vger.kernel.org>; Wed, 18 Nov 2009 03:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=EvZYZvd4JERTmV3rlfz+yT23EcpI8FwH5Xb+Lul/NmE=;
        b=aoBmPEmO4QKFEpyIYJhkW7jqTMXg+k/tzUmH2qd3tT0ycofFWEdlk3SB08gbPJyt8h
         VwTX+9R6Bs6nvbKvfCqlyRtEZrPuQBrUCfd4Fe1ScCXHag9yCTS95aTjVc/JeYe5SENa
         YpQykjHOF3pk5tdQvjLcgeGXBpG4+/hEe9lns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=LcoqLm8Vi9uEEm/Gca7SoTwlGYea+arEPsfxMea5vUitXr2kopzopanlBqanHvY4RJ
         Qo5blb4XzW2a/Zz/yA/miTAe5pMJir+huBuJ1fCYs9eB0oosOqeVWQuSs0B/kVeh5yg2
         +6RahdikusYUU6hzQG5tRLcfh8Q16iO9FHTOA=
Received: by 10.223.14.140 with SMTP id g12mr1236284faa.50.1258545453059; Wed, 
	18 Nov 2009 03:57:33 -0800 (PST)
In-Reply-To: <be6fef0d0911180344ld31237et533cfa8832ea0c6c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133163>

On Wed, Nov 18, 2009 at 12:44, Tay Ray Chuan <rctay89@gmail.com> wrote:
> Hi,
>
> On Wed, Nov 18, 2009 at 7:30 PM, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
>> Insired by the coloring of quilt.
>
> s/Insired/Inspired/?
Sure.

I also forgot to update the test suit.

New patch follows.

Bert
>
> --
> Cheers,
> Ray Chuan
>
