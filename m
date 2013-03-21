From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation: add a README file
Date: Thu, 21 Mar 2013 15:09:06 -0700
Message-ID: <20130321220906.GB12223@google.com>
References: <1363873555-8274-1-git-send-email-ydroneaud@opteya.com>
 <7v8v5gbwh6.fsf@alter.siamese.dyndns.org>
 <64e67681cf5584b51bc84082fe6304c0@meuh.org>
 <7vzjxwabzv.fsf@alter.siamese.dyndns.org>
 <1363903193.6289.57.camel@test.quest-ce.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 23:09:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIng5-0007gD-SK
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 23:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353Ab3CUWJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 18:09:13 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:63093 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093Ab3CUWJL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 18:09:11 -0400
Received: by mail-pb0-f54.google.com with SMTP id rr4so2565273pbb.13
        for <git@vger.kernel.org>; Thu, 21 Mar 2013 15:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=0Pd3kVIquAwxmuIJiEjzJtwzxoOHsA773sAb7s1Vte8=;
        b=GfWQ68Qk55lpI0BIflEf0hmogGcLq1OIzvm4cXETTB9tAJpm1sPpbmIT7im+OF8pYX
         8aI6CKcmZ1fCSGLZkyT3YFXn4FkwEcrK6Qnmr5oHh6+KJvrQRwU02CIUDNKd7GLkyMSL
         GRiJ8lXtb5o4ppgT0E6vi+Fvl9TF50f/DTNKLLFhjmjIvFOWqFf1yK+OTeKUkm7Bn/Db
         yRrwUqTBY+VaE4UTuCxj+B4k3BhMYSmWaXcognLgmlKoxFubbhEYe2VNbeUfOhIak5u8
         SVLjXrqs6er+SzoUM/B3mXZhJ8gNwD+/0DRzJBGd/0eW5XZrDgG7HDgLGDGZgv7j6SZ4
         NLxA==
X-Received: by 10.66.155.102 with SMTP id vv6mr17148239pab.74.1363903751249;
        Thu, 21 Mar 2013 15:09:11 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id d7sm7437082pbh.45.2013.03.21.15.09.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 Mar 2013 15:09:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1363903193.6289.57.camel@test.quest-ce.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218768>

Yann Droneaud wrote:

> Anyway, having a README at the Documentation/ level could also help to
> explain what to be found in this directory:
> - user-manual
> - howto
> - technical
> - RelNote
> - SubmittingPatches
> - CodingGuidelines
> - etc.

A Documentation/README or Documentation/INDEX in the spirit of Linux's
Documentation/00-INDEX could be interesting if it does not bitrot
(unlike Linux's 00-INDEX).  Presumably that means it would have to be
pretty brief.

Thanks,
Jonathan
