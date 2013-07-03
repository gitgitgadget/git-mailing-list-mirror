From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] fixup-builtins: remove unused cruft
Date: Wed, 3 Jul 2013 15:57:05 +0530
Message-ID: <CALkWK0=zwYYay7AA1mvcqKsEzs-iQhdBfnR2GeisJ6ZT8Wvrug@mail.gmail.com>
References: <1372434379-24085-1-git-send-email-artagnon@gmail.com>
 <20130628164545.GB9127@sigill.intra.peff.net> <7vfvw2nk8r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 12:27:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuKHv-0002jE-GY
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 12:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211Ab3GCK1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 06:27:47 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:49751 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab3GCK1q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 06:27:46 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar20so14654710iec.21
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 03:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AnYSHB22Qeb/tkTqGQT0NYw4usoNXHiAJojfiQjoyyo=;
        b=oFQij24WVt1m1RRD2siMko/wWe6GQ4O3s/qVE1pPL4daRq0wLsP3dWV/Xv8AmFJPL1
         ZG5XwM4V5xjPabEMag97tIeVhGhmqq6NjqwYO/JHnqKKUFJ9mHWR2BIXzDhObI1TIeDu
         8gVqGI/St5wBVsyOx9I7a+j5XAa7chTuXT+xV0rdpx3GbH+b+AcSoirGhuZxtI+dtVNV
         D+n/elnfnXlBRTm197Ego7117wOGtSvmZw001jwKVOJmfXQarTKzfJevTbuDUMU1UTaj
         ia1O8RlgyOmFIg5DaFcm70BTFFJ3IquQ+gX9Hs0rM/hnlZGtQzpWHpnHc3c27vaJlSpN
         MOHA==
X-Received: by 10.50.225.66 with SMTP id ri2mr75627igc.55.1372847266089; Wed,
 03 Jul 2013 03:27:46 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Wed, 3 Jul 2013 03:27:05 -0700 (PDT)
In-Reply-To: <7vfvw2nk8r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229485>

Junio C Hamano wrote:
> It is not "nobody is working on", but "it has already been used to
> help the transision and served its purpose, and is no longer is very
> useful for follow-up work because the majority of remaining matches
> it finds are false positives."

Please amend the commit message appropriately (you clearly know best) and queue.
