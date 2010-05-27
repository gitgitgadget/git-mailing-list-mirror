From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git pull works remotely but not locally
Date: Thu, 27 May 2010 16:47:50 +0200
Message-ID: <AANLkTinn_D2nrZDoczHqvAFKdCxxubK0N0jHr-nE94JP@mail.gmail.com>
References: <4BFE750B.5030007@llaisdy.com> <AANLkTikmrBQ1aUQeAZKB8pdgwXjureozZOzEHq8CF4kb@mail.gmail.com> 
	<4BFE83A7.4020604@llaisdy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ivan Uemlianin <ivan@llaisdy.com>
X-From: git-owner@vger.kernel.org Thu May 27 16:48:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHeNp-0004nC-GE
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 16:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757896Ab0E0OsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 10:48:24 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36643 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755683Ab0E0OsX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 10:48:23 -0400
Received: by gyg13 with SMTP id 13so12702gyg.19
        for <git@vger.kernel.org>; Thu, 27 May 2010 07:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=oMMOYIjwqDAuzqWLY4xxf/FNjcjn0yhUGOKPMJR/vbk=;
        b=NVL4Am3AAAmQt1KWjWvsjy+gTEvYU+V06aXFcE1cOt5cm/h+hMV7Xg4w1P7OlHfjMS
         E0BHNDpfYMXf3cAmAo0+hYUUAb37uohVQMzt67gVqXBTWGG7cTqN+yfoZoMwviiOm9Dd
         8F6pooQcJp5H+Cgm4Hwqv+XyORdsOR9jbA0qM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=UcZl4UcREwdrf9IXDzPC7UTAMb7qfM3i2Zzy8tkYYBAx1ixeAg9fkWBcYbkABypO8g
         BKkYVpw0L8jBkiVKPAK5OS/uyVPvK8BINLgiNi7zTTPUywpzL5EUlPkTH+SSkqWA+zOl
         xD7nnsQYWIAncKbsqnQrwEdXASy0rJKcMzAc8=
Received: by 10.151.87.7 with SMTP id p7mr247788ybl.340.1274971691433; Thu, 27 
	May 2010 07:48:11 -0700 (PDT)
Received: by 10.151.61.12 with HTTP; Thu, 27 May 2010 07:47:50 -0700 (PDT)
In-Reply-To: <4BFE83A7.4020604@llaisdy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147867>

Heya,

On Thu, May 27, 2010 at 16:37, Ivan Uemlianin <ivan@llaisdy.com> wrote:
> git-pull is 755, and I can run /path/to/git-pull (I get an error and it
> crashes, but I have the permission).

That's not supposed to happen, what does it say? Also, is it possible
you have an old git install lying around? It might be that it's partly
using the old, and partly using the new install.

-- 
Cheers,

Sverre Rabbelier
