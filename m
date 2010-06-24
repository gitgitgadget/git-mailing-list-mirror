From: Sabyasachi Ruj <ruj.sabya@gmail.com>
Subject: Confusion about content of conflicted file after : git remove/add
Date: Thu, 24 Jun 2010 10:23:49 +0530
Message-ID: <AANLkTimqrfeNEmlfHGxWTdLgS7tAMOA66N4nV8b5I8F6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 24 06:54:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OReS9-0006Ax-1n
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 06:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702Ab0FXEyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 00:54:11 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:32957 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab0FXEyK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 00:54:10 -0400
Received: by vws9 with SMTP id 9so1951449vws.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 21:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=VKU//OO7JIibEwNBv4wJ2IF/i4wpphrUbmaXF1JuxHc=;
        b=evBd5ur68sbB+GRwaLbaIAq0E4bHsVMBw/8yf02QTjnQt8GDLxFVMlOCJxy+o6OiUK
         +BmJpRc20/erKd53hjBoJXv31hOVnjJmRqSYAhPHoGGHE8812odBkLSVefvWG7N5Goy5
         vt7xS7QNptHWJrS2m4exjtTRL2VG0HjtTx/bc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=tKVj/p0Id5EFIdiuNcxFZ1mE2N1oKoMxjc5l9lw5LM7TiHKXPoMW/t6UhzJ1E/f7rU
         Db4Vzeqjc/dhexF9Amt29nRvyE9V+6XsXPuSO3J4oY8L9k1+7S5AGURUzpm7aASGeSJk
         kYITnYaOHsHevy7ih9NyETjy3qyh6OEAJk12s=
Received: by 10.224.95.158 with SMTP id d30mr5736600qan.15.1277355249161; Wed, 
	23 Jun 2010 21:54:09 -0700 (PDT)
Received: by 10.229.241.149 with HTTP; Wed, 23 Jun 2010 21:53:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149561>

I have asked the question in detail in Stack Overflow.
http://stackoverflow.com/questions/3100032/git-rename-delete-confusion
Can anyone here explain that situation. Please also read the comments
I wrote there.

I am totally baffled and can't predict what will be the content of a
file after "git rm and git add" in branch and "git mv" in another
branch.

--
Sabyasachi
