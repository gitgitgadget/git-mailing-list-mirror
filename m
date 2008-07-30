From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] git-svn: Abort with an error if 'fetch' parameter is invalid.
Date: Wed, 30 Jul 2008 16:56:46 -0400
Message-ID: <32541b130807301356n68bf1a2an9443f1fc48f0e22c@mail.gmail.com>
References: <1217451235-9609-1-git-send-email-apenwarr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, normalperson@yhbt.net
To: "Avery Pennarun" <apenwarr@stasis.open.versabanq.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 22:57:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOIk4-0001x9-3E
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 22:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbYG3U4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 16:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752271AbYG3U4s
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 16:56:48 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:62652 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbYG3U4s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 16:56:48 -0400
Received: by py-out-1112.google.com with SMTP id p76so150308pyb.10
        for <git@vger.kernel.org>; Wed, 30 Jul 2008 13:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=D3u4wcDHSFDa32p+dyvzxBnFPs2DJit4BckdH9PAU1A=;
        b=TxcK2B/9j7CqVhU+RG59f6UhdDeFsoaZc2pj9XPnEGogC02ONiGo5pbGy91MNPY8ik
         CqoV33BzNuCb7YWbP3eDOMruzJ/ojpKy/+257Gl3eBcCws0VidVhiS9YN7jeDceTirEy
         1n6uTWzqTQBar8G8Tayx4jrTmTQMThID71FJM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=gvnOTgLU3Wm3+Ujl8NP7zwjgkp7C3e/JUg/BkFjKcttOeEZioB7OCfJ2NBDmd/jMiW
         TRwOdZ2/76dmMRBwcfDcVdEOK2ff8Osp+yezgEbJf4YlA4U7oFyfM6HuXyOWWpsXnXyw
         n3Eq1YSR1BkFrh8yDqtr9mOt40AOrwWwUwJmk=
Received: by 10.115.58.18 with SMTP id l18mr9262876wak.177.1217451406864;
        Wed, 30 Jul 2008 13:56:46 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Wed, 30 Jul 2008 13:56:46 -0700 (PDT)
In-Reply-To: <1217451235-9609-1-git-send-email-apenwarr@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90853>

On 7/30/08, Avery Pennarun <apenwarr@stasis.open.versabanq.com> wrote:
> ...

Please excuse the broken From: line on the above patch.  The
@gmail.com address is correct.

Avery
