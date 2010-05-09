From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC update] git-remote-svn: Week 1
Date: Mon, 10 May 2010 00:12:20 +0200
Message-ID: <o2pf3271551005091512qdebc006cic2c5b85ab7a9e23e@mail.gmail.com>
References: <g2zf3271551005050559v2ea99346gcc59f941d634ce1a@mail.gmail.com> 
	<90AEA593-35CC-403E-8918-94DB45BC0E06@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: David Michael Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Mon May 10 00:12:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBEjw-0008Hu-5h
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 00:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305Ab0EIWMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 18:12:42 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:41690 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab0EIWMl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 18:12:41 -0400
Received: by qyk13 with SMTP id 13so5003932qyk.1
        for <git@vger.kernel.org>; Sun, 09 May 2010 15:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=t7yxxxRvK4bnTTkg8JAqNHcJ1+fimEL2WhenCC8Xamw=;
        b=LuqDUzI94NjVCZwH4Lb2M3GrQRI5gRei2Em+70xsbP8Xp1cp2OmPej/FFn2t6LziXk
         bJxOx2KKxYQciWprVahOz9NMJuQjIqNMIvt77vKwszTFTWHcgwPiPdhTO/4XCrS3kUeJ
         uYu0C/S7RnIL6+P0xJYnqfNCVtxqLMP0exY9c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=MqmA0Z7hfIh3p0B+Y5OIxo8gwMosmcXQGvvNiWmZ2E+XtXZpWLTNSC2pJaGbzDvTcA
         ZUPAWwIQvtW/C/ObszS2IYmvNkGaictlh2s69U6s9umG8knDRmLzSwTodpzbPGGpNLHO
         mkEi8yoCA+VJZB8DPRcGlKkDDFYmeJGF02O2M=
Received: by 10.224.18.36 with SMTP id u36mr1998317qaa.64.1273443160186; Sun, 
	09 May 2010 15:12:40 -0700 (PDT)
Received: by 10.229.182.85 with HTTP; Sun, 9 May 2010 15:12:20 -0700 (PDT)
In-Reply-To: <90AEA593-35CC-403E-8918-94DB45BC0E06@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146750>

Hi David,

> A quick update. I've begun work on a reference exporter written in perl.

Curiously, why?

> I believe I introduced some regressions during code cleanup.
> From memory, the svn-dump-fast-export_0.8 tag has been verified for
> 10,000 revisions of my repository.

Thanks for the heads up. Don't worry about it though- I've started
cleaning up the code. Will send you some patches off the list by
email, or whatever you prefer.

-- Ram
