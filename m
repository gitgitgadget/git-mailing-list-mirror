From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 0/5] misc. submodule related changes
Date: Mon, 11 Jun 2007 21:06:32 +0200
Message-ID: <8c5c35580706111206x731d8e34i96e9f40f3bf5b61b@mail.gmail.com>
References: <op.ttqcxap09pspc6@localhost>
	 <7vtztepc33.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 21:06:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxpDv-0006be-VZ
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 21:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753677AbXFKTGh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 15:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753691AbXFKTGh
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 15:06:37 -0400
Received: from nz-out-0506.google.com ([64.233.162.227]:23190 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677AbXFKTGg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 15:06:36 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1373202nzf
        for <git@vger.kernel.org>; Mon, 11 Jun 2007 12:06:32 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sQLD8ChUhNnlK7h8cOXfnEQqDlPK5yIw2Hx8BS8U1BJyaoSX7aJKkFMwBvjLFVYyAeWXUnFuKX+OdGIpYRpOqoCD8fh0pb2Gy4Y3QpkRZ2A6DslHZ+EwuXCcAolu4KAS9dC+EHUzriR4GVHE5lTIwL4Nn/hjFhZexDz/StN/7Ys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QdzQMMPMfPyy3VwvQDogKnDpyWQNwBv//3maP6DRT1Sqx9QDYS6Kon/Y5I1Pt9GcMIjkP/Cd8qurnLESi9XxCUyJOj5cn7EOq22EVI3+szI4/mMK8Nh5HjnxS6/XwzuyP4TR6M1urPneufV1mhQCQfZIl6zOIgjv6SOvoqoVBW4=
Received: by 10.114.199.1 with SMTP id w1mr5835094waf.1181588792048;
        Mon, 11 Jun 2007 12:06:32 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Mon, 11 Jun 2007 12:06:32 -0700 (PDT)
In-Reply-To: <7vtztepc33.fsf@assigned-by-dhcp.pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49869>

On 6/11/07, Junio C Hamano <gitster@pobox.com> wrote:
> All of these patches have annoying whitespace breakage.  It
> appears your MUA is adding an extra SP at the beginning of every
> single line that begins with a SP, or something.

Hmph. My ISP's smtp-server was down last night so I tried using
sendmail, but neither vger nor mx-all.pobox.com liked my (dyn)dns. So
I ended up using Opera against gmail. Next time I'll just wait for my
ISP to come back from lunch ;-)

>
> Care to redo the series?

Sure.

-- 
larsh
