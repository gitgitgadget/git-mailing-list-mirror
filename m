From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 02/18] config: Introduce functions to write non-standard file
Date: Fri, 29 Jul 2011 01:45:14 +0530
Message-ID: <CALkWK0ntddWFHpwoH61im0ZU9H4o-FDy7qzynGQNSqCM0-ga+A@mail.gmail.com>
References: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
 <1311871951-3497-3-git-send-email-artagnon@gmail.com> <20110728173500.GA29866@elie.dc0b.debconf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 22:15:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmWzc-0002zD-Rz
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 22:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755719Ab1G1UPg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jul 2011 16:15:36 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63375 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755249Ab1G1UPf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2011 16:15:35 -0400
Received: by wwe5 with SMTP id 5so2868066wwe.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 13:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=OVYGaCu1yw31a0VBoXLSZzMmJlj41t5gzANjRdRhzE8=;
        b=e9p2JilXjs5V/PcxRkOvKLDes3N8RhqtT0NGCGdFmgB25fUqKpzyuT0kKppfG9Kvxn
         cl1Z95+PFqmAP80AYWttGDbuabMqHpa9N2LXueuf4yadHh1hiQT92pfEUzv6U9K21ZmQ
         H8e5GkXTczY6CS/tDCu+8aNNsxzL9/sPc8eVM=
Received: by 10.227.57.209 with SMTP id d17mr487541wbh.94.1311884134120; Thu,
 28 Jul 2011 13:15:34 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Thu, 28 Jul 2011 13:15:14 -0700 (PDT)
In-Reply-To: <20110728173500.GA29866@elie.dc0b.debconf.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178113>

Hi,

Jonathan Nieder writes:
> Other messages need a spell-check, too. =C2=A0Aside from that, patche=
s 1-3
> look good --- thanks for your perseverance.

=46ixed all.  Also hooked flyspell to git-commit-mode to avoid this in =
future.

Thanks.

-- Ram
