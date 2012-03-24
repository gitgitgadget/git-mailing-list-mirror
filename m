From: Mauricio Galindo <up.mauricio.g@gmail.com>
Subject: Designing a faster index format GSoC 2012
Date: Sat, 24 Mar 2012 12:35:01 -0600
Message-ID: <CAOx2=+fUU5rMuix6XHWgtMwBwUgCtBEokXAgnMRxB9j3YSmz8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 24 19:35:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBVoH-00068c-37
	for gcvg-git-2@plane.gmane.org; Sat, 24 Mar 2012 19:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752794Ab2CXSfD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Mar 2012 14:35:03 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:41345 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216Ab2CXSfC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2012 14:35:02 -0400
Received: by obbeh20 with SMTP id eh20so3506967obb.19
        for <git@vger.kernel.org>; Sat, 24 Mar 2012 11:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=159xe+yQ3CRgNvykJsRI0bxjO6zXkRBRT8AS/l8mkOo=;
        b=OdoT3bu5Wf7LChpOTIq6cXVQo9D9lOY9MYsM8YXgBfbdF9+RzAeIk+wSNT1VG3wMWn
         GAQhFZSsfU0K7L6GYJO93nVry94PQUJNa2C1rsFtfNdJxI/Uo5QugSp8I7Xpy5ZBicVE
         2ydnH7zJ8JlxtIze0NVOq2jJCqr+czx8TVpgfNlZHEul/YZk/23yMcANHc5VWaYGZDdC
         Kz+umJ4PNeEFelMCW3nz9jQJQwvm77t2h3ChqXD2kK5If9atZvTB0MNHNSPMpNacL8xO
         gsVzJQH8aQ88m3S/4gjd7a4ZUlNfs6/nWqO4mNPT9jn7ThE5jGDOK7Wt5IqnBNQYvvW8
         a/ow==
Received: by 10.60.12.99 with SMTP id x3mr20310293oeb.38.1332614101857; Sat,
 24 Mar 2012 11:35:01 -0700 (PDT)
Received: by 10.182.207.10 with HTTP; Sat, 24 Mar 2012 11:35:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193836>

Hi

I'm a third year computer engineering major wanting to participate at
GSoC 2012 working on the Git project of designing a faster index
format.
I was hoping if someone could give some pointers on where to begin.
I've already started looking around and found some files that I think
are important <add.c, read-cache.c, index-format.txt>.
Is there something I'm missing or that you think I should also check out?
Any pointer would be greatly appreciated.

Thank you.
