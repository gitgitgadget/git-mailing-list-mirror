From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Fix bad quoting in documentation
Date: Sat, 16 Jan 2010 16:30:00 +0530
Message-ID: <f3271551001160300m24932ad4wfd72abc826f2bb65@mail.gmail.com>
References: <f3271551001160002r25cb0ac7hc96891f4af22bd03@mail.gmail.com> 
	<201001161120.14846.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jan 16 12:00:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW6OJ-0007pF-Ej
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 12:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700Ab0APLAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 06:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752362Ab0APLAX
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 06:00:23 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:50734 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116Ab0APLAW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 06:00:22 -0500
Received: by ywh6 with SMTP id 6so1243107ywh.4
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 03:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=LGZHk6SZ9fPR/MggbLSuEf6nVHGJUuLsK1/OF4GPWEI=;
        b=FCSI+g8BDzR6q3PpbVJY/df3JcUHFjEjr/f8ZwlVW42V6hMaoPIeFde5LhFR/F/TXi
         DyUKV/dFl1m/DYi7y1pZ7fxHenNp5hHWw4Z0KB7vJXwBETUoJnRzxUUlAwNAqN0IVeRo
         LRjBmIzTuy9tc6CTlwSIHakxlCorKO2NAvXsA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=BRdcLJW8LgFWZmRQyo6dshLr1Sq5IZfGriBaihC3Y0tTATXXzzFRTOPpjTsf3nJ3Su
         +KbmleDFjdw90A7WmUBLugcQcadJ6wbfqhXVb48hrdtLFLm+1C9oC0iZhTh8CxKf4d9G
         uRhHAYAc6vCyWvrMsONns3nQ1Y2uHEjuhwWf4=
Received: by 10.91.215.7 with SMTP id s7mr3383782agq.81.1263639620113; Sat, 16 
	Jan 2010 03:00:20 -0800 (PST)
In-Reply-To: <201001161120.14846.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137221>

Hi,

> If not, please tell the debian guys to set ASCIIDOC8=YesPlease when
> building the docs.

Thanks! The Makefile clearly points this out. I'll let the Debian people know.

-- Ram
