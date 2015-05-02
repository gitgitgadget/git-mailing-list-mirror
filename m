From: Alangi Derick <alangiderick@gmail.com>
Subject: Re: Improving code base readability
Date: Sat, 2 May 2015 08:15:45 +0100
Message-ID: <CAKB+oNtUy12qumkE7VAe8_N6aHesJtMqpWNxi3M-7yOviE6BLQ@mail.gmail.com>
References: <CAKB+oNvB322hyX3UbGBPETDc0zEdC39PdeM=GG=rVf_WYGq_OA@mail.gmail.com>
	<20150501185946.GV5467@google.com>
	<CAKB+oNsYDL=iv8AqjoN_JqGTFf0_=f4nKa9_gcxHPLZO+rxmbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 02 09:15:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoReR-0002ye-8t
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 09:15:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbbEBHPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2015 03:15:46 -0400
Received: from mail-qc0-f169.google.com ([209.85.216.169]:35834 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbbEBHPq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2015 03:15:46 -0400
Received: by qcbgu10 with SMTP id gu10so11641424qcb.2
        for <git@vger.kernel.org>; Sat, 02 May 2015 00:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=e2YSHdsv8BfdM6zmlVYNG8q/hJ5ffs4a+Lb8QiPja6Y=;
        b=KgUVyDfSWtu5jORRLaPX0SFHBdLgG12yTnMfQcCx6/Yi/yRFCkq+ZaRkSe4cXpmFMw
         jKuVLrxpqkCZob+ek4vQ0lNc+WXs+bSyW94s3gaQgYZdVG5OnbT0BLdywozltd7fXp7g
         aK36YO0EpZBe3xySrOPzqYiKDAoJN+Gg5aaZNYv5a77EkIaVspbDN69k4ggrtHTDKYiG
         zupy5HlHfRqd8WOEXvS5N+ZIfLV7DLYvJq7huSIzhelT1n5JORjGCVxMeA+tRgGapc8k
         gQ8f/erJx64R27GADRrqYQxMpgWRiHY/3uJmrQzTckHggUZjpKxdtBRQ6JxbrNZJC63N
         Q5HA==
X-Received: by 10.140.30.166 with SMTP id d35mr14986205qgd.85.1430550945691;
 Sat, 02 May 2015 00:15:45 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Sat, 2 May 2015 00:15:45 -0700 (PDT)
In-Reply-To: <CAKB+oNsYDL=iv8AqjoN_JqGTFf0_=f4nKa9_gcxHPLZO+rxmbA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268223>

I read the po/README and also the po/TEAMS and i can't find English
there as a language. So what should i do or is it that the english in
the error messages are not clear that i can work on?
