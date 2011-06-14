From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC update] Sequencer: Debating the UI
Date: Tue, 14 Jun 2011 11:30:34 +0530
Message-ID: <BANLkTikDq8DJeUde-jSPL2bKw1jk3GoYVg@mail.gmail.com>
References: <BANLkTinxx5qFuhwsUt3JeXOO7TjBj8wFvw@mail.gmail.com> <20110614053143.GA24882@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 08:01:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWMgP-0003Df-15
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 08:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879Ab1FNGA4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jun 2011 02:00:56 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61295 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886Ab1FNGAz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2011 02:00:55 -0400
Received: by wwa36 with SMTP id 36so5513997wwa.1
        for <git@vger.kernel.org>; Mon, 13 Jun 2011 23:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=kPI8nNk1Y4uu4XKCjw1ZJfv//BkWQmCH/YCFJU487XU=;
        b=XWhHPY16JdyNgQL6jH9k0sMuSMaW8Ppalq0IS5gJ9N8G9C16OJArNC4TRkgv8qrMwz
         ZUoj7JG4GoLVdLJ9OEVABTwr+C9YL+i9lv7iCNg9lnv3rdd77K32at1Z9rR0itKhl+W7
         LRYKLWZaLNMVT/A312c6+MIK3i0auiJcGV4HQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=hCP1GpjQ1WjfEFhx7cXKW/i/cK0pMP0vdxTg/A8INAgZIBLB2pQQI7oRfkaIya+4QH
         L3LSKc35Y7/Cc+9y7GayClslIIRV1UbLJIhAGMBn/JabXXFEJHbFxCLCqWnXy2h83cFi
         P7QDXE6KEQzlB+0kJ7QBZAC6AOq0D32wu/taU=
Received: by 10.216.79.5 with SMTP id h5mr811254wee.110.1308031254185; Mon, 13
 Jun 2011 23:00:54 -0700 (PDT)
Received: by 10.216.1.20 with HTTP; Mon, 13 Jun 2011 23:00:34 -0700 (PDT)
In-Reply-To: <20110614053143.GA24882@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175747>

Hi,

Jonathan Nieder writes:
> I would love to use a working "cherry-pick --continue". :) =C2=A0I wo=
uld
> use it like this:

Great.  I hope to have a mockup of this ready in a couple of days or so=
=2E

> Speaking of which, do you have a git tree that testers should use /
> send patches against? =C2=A0E.g., is the "sequencer" branch at
> git://github.com/artagnon/git.git the one to play with?

Yes.

-- Ram
