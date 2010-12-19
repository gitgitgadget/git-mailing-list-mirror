From: Parag Kalra <paragkalra@gmail.com>
Subject: Basic Git Questions
Date: Sun, 19 Dec 2010 14:32:41 -0800
Message-ID: <AANLkTiki2e4-YD0P9kb7g-WbLTPhAXQ22R2jCAXVtjN1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 19 23:33:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PURoV-0000CM-Bh
	for gcvg-git-2@lo.gmane.org; Sun, 19 Dec 2010 23:33:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403Ab0LSWdF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Dec 2010 17:33:05 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:44416 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932260Ab0LSWdE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Dec 2010 17:33:04 -0500
Received: by fxm18 with SMTP id 18so2456627fxm.2
        for <git@vger.kernel.org>; Sun, 19 Dec 2010 14:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=L0t9odXkRdD4kWQFrJ3CEWtWVfL5YYjGSGqzNV51fuY=;
        b=Uhw+KaRRSu/Oam8kPQvqQvnPIkjXDDwIVMpmiVctBXZSgrpr3Ne54iR7FERSBz476s
         qvpusQiysuO3evNh6hYD49jM6Qw6TgsURe8MSFmFvJ2uh5dZhDWH2H71JPtgfF4zE3df
         Q5aZF2t4vqw/jg9AhlFW2I3XSow1es+KKO4mM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=CXJ7hfbX9gS4UUhJD9h1I7EvJAdG3on+KRZlMGZnNbdwVi0u7/kXmT2iedbbC2DvTq
         qp0E5aNsqCfhnvG6Nf28UxjHjCyup2OZyBdbLOjDDXFdoG1zzSYcVUr8hMyrQ6GPdwjV
         lhFdIldFaZQdeSq0ZVCF2pjqMIUjzOUYCEPbQ=
Received: by 10.223.98.204 with SMTP id r12mr3946218fan.102.1292797982208;
 Sun, 19 Dec 2010 14:33:02 -0800 (PST)
Received: by 10.223.102.139 with HTTP; Sun, 19 Dec 2010 14:32:41 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163971>

Hi,

1. I generally add the files in my working directory using "git add
=2E". But sometimes you want to add all the files except 1 or 2 file. I=
s
there a shortcut way we can tell git to add all the files but exclude
a particular file.

2. Also sometime when the code is=C2=A0committed, I realize that I have
forgot to change or add a file. Is there a way we can we commit a file
to existing commit number with git log showing only the old git commit
number and not creating a new one for the last commit.

Cheers,
Parag
