From: Fabrizio Mancin <fabman08@gmail.com>
Subject: Stash Feature
Date: Wed, 3 Jun 2015 17:22:57 +0200
Message-ID: <CAGmnFohE3ihA8T8srk1BpXg5z80tnjyUhdjFieXGYm=T0gkMUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 17:23:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0AVV-0004nM-8M
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 17:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756729AbbFCPXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 11:23:00 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37483 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747AbbFCPW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 11:22:58 -0400
Received: by wifw1 with SMTP id w1so26448757wif.0
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 08:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=GFjeLMJnRxPtmKaYVERAGiy5GnEnOzxNC3DAp1LJZG8=;
        b=YutUQnuTg2rANvQ4ap0RidMWOvhJJQvKE85qrEdHOSofFQUw/ujWwlZgXHDLjCRwlf
         ai90BQvX1PhUiYVBNE+1vQ2u5YkiJda1rSkjdxyM9siLkhj5h3ZLLi8WlTXP4nhve0i6
         nFt5R/vCzfxuKDCHNfzfb3rdKlYzYLdpchXGSp2xFx7w02Z9THBHs28bummcJ4satnXa
         /8P1cwaSMqErS18uK4QZwg6OY++yTLHjOU72FPaLrw8ohdno6cVl/rM2A4x15L22+zfc
         +i/+mQNeoSir4co8JL72SWpoUy0mglu4EwSihC4Vcx23TASbXEncMAy8JiQZLHg6zAFM
         aCWw==
X-Received: by 10.180.82.162 with SMTP id j2mr22494779wiy.54.1433344977174;
 Wed, 03 Jun 2015 08:22:57 -0700 (PDT)
Received: by 10.194.75.225 with HTTP; Wed, 3 Jun 2015 08:22:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270689>

 Hi Guys,

I've a little request for you.
What about saving date-time on git stash save command and show it on
git stash show stash@{xxx}?
I think it is a useful poperty to save.

What do you think about it?

Thank you
Fabrizio
